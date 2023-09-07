#' produce INCAtools distribution URL
#' @param ontology short string that is the prefix to .db.gz in the bbop-sqlite collection
#' @examples
#' semsql_url("cl")
#' @export
semsql_url = function(ontology = "efo") {
  sprintf("https://s3.amazonaws.com/bbop-sqlite/%s.db.gz", ontology)
}
