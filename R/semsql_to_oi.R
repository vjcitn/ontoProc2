#' produce an ontology_index instance from semantic sql sqlite connection
#' @import dplyr
#' @importFrom ontologyIndex ontology_index
#' @param con DBI::dbConnect value for sqlite table
#' @return result of ontologyIndex::ontology_index evaluated for the labels and 
#' parent-child relations in tables statements and edge of the semantic sql resource
#' @export
semsql_to_oi = function(con) {
# sqlite> select * from statements where predicate = 'rdfs:label' limit 40;
 alltabs = DBI::dbListTables(con)
 stopifnot(all(c("edge", "statements") %in% alltabs))
 labdf = dplyr::tbl(con, "statements") |> dplyr::filter(predicate == "rdfs:label") |>
   as.data.frame()
 edgdf = dplyr::tbl(con, "edge") |> dplyr::filter(predicate == "rdfs:subClassOf") |>
   as.data.frame()
 nn = split(labdf$value, labdf$subject) # value!!
 pl = split(edgdf$object, edgdf$subject)
 okn = intersect(names(nn), names(pl))
 pl = pl[okn]
 nn = nn[okn]
 ontologyIndex::ontology_index(name=nn, parents=pl)
}

