# this code is an effort to replace the GO.db API with methods based on Semantic SQL
# representations from INCA project

#' define a wrapper for the SQLite connection
#' @slot conn an instance of SQLiteConnection
#' @slot resource character(1) a descriptive string
#' @slot nstats numeric(1) holder for count of number of statements
#' @export
setClass("SemSQL", slots=c(conn="SQLiteConnection", resource="character", nstats="numeric"))

#' constructor for SemSQL instance
#' @param conn SQLiteConnection
#' @param resource character tag
#' @export
SemSQL = function(conn, resource) {
  nstats = dplyr::tbl(conn, "statements") |> dplyr::count() |> dplyr::pull()
  new("SemSQL", conn=conn, resource=resource, nstats=nstats)
}

#' present information about a SemSQL object
#' @export
setMethod("show", "SemSQL", function(object) {
   cat(sprintf("SemanticSQL interface for %s\n", slot(object, "resource")))
   cat(sprintf("There are %d statements.\n", slot(object, "nstats")))
   })

#' check aspects of SemSQL object
#' @name SemSQL
#' @export
setValidity(Class="SemSQL", method=function(object) {
   con = slot(object, "conn")
   inherits(con, "SQLiteConnection")
})

#' emulate the AnnotationDbi select method
#' @param x instance of SemSQL
#' @param keys vector of elements of the appropriate type
#' @param columns vector of desired output columns
#' @param keytype character(1) defaults to 'GOID'
#' @export
setGeneric("select", function(x, keys, columns, keytype="GOID", ...) standardGeneric("select"))

#' emulate AnnotationDbi
#' @examples
#' gg = retrieve_semsql_conn("go")
#' ngo = SemSQL(gg, "GO")
#' ngo
#' validObject(ngo)
#' select(ngo, keys=c("GO:0018942", "GO:0000003"), columns=c("DEFINITION", "TERM", "ONTOLOGY"))
#' @export
setMethod("select", "SemSQL", function(x, keys, columns, keytype = "GOID", ...) {
 if (missing(keys)) stop("keys must be supplied")
 if (missing(columns)) stop("columns must be supplied")
 if (keytype == "GOID")
  tmp = dplyr::tbl(x@conn, "statements") |> dplyr::filter(subject %in% keys) 
 else stop("Only keytype GOID supported at this time")
 def = term = onto = NULL
 if ("DEFINITION" %in% columns) {
  def = dplyr::filter(tmp, predicate == "IAO:0000115") |> dplyr::select(subject, value) |>
    rename(DEFINITION=value, GOID=subject)
  }
 if ("TERM" %in% columns) {
  term = dplyr::filter(tmp, predicate == "rdfs:label") |> dplyr::select(subject, value)  |>
    rename(TERM=value, GOID=subject)
  }
 if ("ONTOLOGY" %in% columns) {
  onto = dplyr::filter(tmp, predicate == "oio:hasOBONamespace") |> dplyr::select(subject, value) |>
    rename(ONTOLOGY=value, GOID=subject)
  }
 if (!is.null(def)) ans = def
 
 ans = list(def=def, term=term, onto=onto)
 todo = which(sapply(ans, function(x) !is.null(x)))
 fin = ans[[todo[1]]]  # start
 if (length(todo)==1) return(fin)
 for (i in todo[-1]) fin = left_join(fin, ans[[i]], by="GOID")
 fin
})




#> getMethod("select", "GODb")
#Method Definition:
#
#function (x, keys, columns, keytype, ...) 
#{
#    if (missing(keytype)) 
#        keytype <- "GOID"
#    .select(x, keys, columns, keytype, jointype = "go_term.go_id", 
#        ...)
#}
#<bytecode: 0x10cebae50>
#<environment: namespace:AnnotationDbi>


