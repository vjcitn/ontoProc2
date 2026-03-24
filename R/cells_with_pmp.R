
#' produce a table with cells exhibiting given proteins on plasma
#' membrane according to CL
#' @param curies a character vector in format "PR:nnnnnnnnn"
#' @return a data.frame with columns cl, celltype, pr, protein
#' @examples
#' cells_with_pmp(c("PR:000002064", "PR:000001874"))
#' @export
cells_with_pmp = function(curies) {
  data("tag2cn", package="ontoProc2")
  cl = semsql_connect(ontology = "cl")
  pr = semsql_connect(ontology = "pr")
  on.exit({disconnect(cl); disconnect(pr)})
  cl4pmp = dplyr::tbl(cl@con, "entailed_edge") |> 
     dplyr::filter(object %in% curies, predicate == "RO:0002104") |>
     as.data.frame() |> 
     dplyr::filter(grepl("PR:", object)) |> 
     dplyr::select(subject, object) |> dplyr::mutate(cl=subject, prtag=object)
  mappr = dplyr::tbl(pr@con, "rdfs_label_statement") |> dplyr::select(subject, value) |> as.data.frame() |>
     dplyr::filter(grepl("^PR:", subject)) |> dplyr::mutate(prtag=subject)
  ans = dplyr::left_join( cl4pmp, mappr, by="prtag") |> dplyr::select(prtag, value, cl)
  ans$celltype = tag2cn[ans$cl]
  ans
}

