#' a named vector with values rdfs labels in NCI thesaurus, and names the corresponding formal ontology tags
#' @docType data
#' @format named character vector
#' @usage
#' data(ncit_map)
#' @examples
#' data("ncit_map", package = "ontoProc2")
#' ncit_map["EFO:1000899"]
"ncit_map"

#' a named vector with mapping from CURIE to cell type phrase for CL.owl of 2025-12-17
#' @docType data
#' @format names character vector
#' @usage
#' data(tag2cn)
#' @examples
#' data("tag2cn", package = "ontoProc2")
#' tag2cn[c("CL:0000000", "CL:0000006")]
"tag2cn"

#' a named vector with mapping from cell type phrase to CURIE for CL.owl of 2025-12-17
#' @docType data
#' @format names character vector
#' @usage
#' data(cn2tag)
#' @examples
#' data("cn2tag", package = "ontoProc2")
#' cn2tag["Kupffer cell"]
"cn2tag"
