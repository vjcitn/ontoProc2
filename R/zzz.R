utils::globalVariables(c("predicate", "subject", "value"))

.onLoad = function(libname, pkgname) {
S7::method(print, SemsqlConn) <- function(x) {
  if (!is_connected(x))
    stop("SemsqlConn object is disconnected; reconnect with semsql_connect()")
  n_labels <- dbGetQuery(x@con,
    "SELECT COUNT(*) AS n FROM rdfs_label_statement")$n
  cat("<SemsqlConn>",
      " prefix:", x@ontology_prefix,
      " | labeled terms:", format(n_labels, big.mark = ","),
      "\n")
  invisible(x)
 }
}

