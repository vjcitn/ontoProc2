
#' return a SQLite connection (read only) to an INCAtools Semantic SQL ontology
#' @import BiocFileCache
#' @import RSQLite
#' @importFrom R.utils gunzip
#' @import DBI
#' @param ontology character(1) short string prefixing .db.gz in the INCAtools collection
#' @param cache a BiocFileCache instance, defaulting to BiocFileCache::BiocFileCache()
#' @param cacheid character(1) or NULL; if non-null, the associated SQLite resource will be used from cache
#' @examples
#' # first time will involve a download and decompression
#' aionto = retrieve_semsql_conn("aio")
#' head(DBI::dbListTables(aionto))
#' dplyr::tbl(aionto, "class_node") |> head() 
#' @export
retrieve_semsql_conn = function(ontology = "efo", 
     cache=BiocFileCache::BiocFileCache(), cacheid=NULL) {
#
# this function checks for cached version of ontology database
# and if present, returns SQLite connection to it.  otherwise
# it caches and then recurses
#
  if (!is.null(cacheid)) {
   cached_path = bfcinfo(cache,cacheid)$rpath
   return(dbConnect(SQLite(), cached_path, SQLITE_RO))
   }
  rname = paste0(ontology, "_bbop_ontoproc2")
  bbop_info = BiocFileCache::bfcquery(cache, rname)
  ind = grep(rname, bbop_info$rname) 
  if (length(ind)>0) {
    if (length(ind)>1) {
       message(sprintf("multiple cache entries found matching request %s", rname))
       message("please be more specific, by supplying cache id as 'BFCnnn'.")
       print(bbop_info)
       stop("cannot proceed with ambiguous ontology spec")
       }
    cached_path = bbop_info[ind, "rpath"]$rpath  # ind is length 1
    return(dbConnect(SQLite(), cached_path, SQLITE_RO))
    }
  else {  
    addr = semsql_url(ontology)
    zdbname = basename(addr)
    dbname = sub(".gz$", "", zdbname)
    ztmploc = paste0(tempdir(), "/", zdbname)
    tmploc = paste0(tempdir(), "/", dbname)
    download.file(addr, paste0(tempdir(), "/", zdbname))
    gunzip(ztmploc) # file now at tmploc
    BiocFileCache::bfcadd(cache, rname=rname,
     rtype="local", fpath=tmploc, action="move")
    Recall(ontology=ontology, cache=cache)
    }
  }
