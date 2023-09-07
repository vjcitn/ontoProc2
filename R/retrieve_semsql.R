
#' return a SQLite connection (read only) to an INCAtools Semantic SQL ontology
#' @import BiocFileCache
#' @import RSQLite
#' @importFrom R.utils gunzip
#' @import DBI
#' @param ontology character(1) short string prefixing .db.gz in the INCAtools collection
#' @param cache a BiocFileCache instance, defaulting to BiocFileCache::BiocFileCache()
#' @examples
#' # first time will involve a download and decompression
#' aionto = retrieve_semsql_conn("aio")
#' head(DBI::dbListTables(aionto))
#' @export
retrieve_semsql_conn = function(ontology = "efo", 
     cache=BiocFileCache::BiocFileCache()) {
#
# this function checks for cached version of ontology database
# and if present, returns SQLite connection to it.  otherwise
# it caches and then recurses
#
  rname = paste0(ontology, "_bbop_ontoproc2")
  bbop_info = BiocFileCache::bfcquery(cache, rname)
  ind = grep(rname, bbop_info$rname) 
  if (length(ind)>0) {
    if (length(ind)>1) message(sprintf("multiple cache entries with %s, using last", rname))
    ind = ind[length(ind)] # use last
    cached_path = bbop_info[ind, "rpath"]$rpath
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
    Recall()
    }
  }
