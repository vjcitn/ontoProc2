#' produce a table with list of proteins from protein ontology
#' identified as present on cell membranes for input cell type CURIEs
#' @param curies a character vector in format "CL:nnnnnnn"
#' @return a data.frame with columns cl, celltype, pr, protein
#' @examples
#' \donttest{
#' get_present_pmp(c("CL:0000091", "CL:0000926"))
#' }
#' @export
get_present_pmp <- function(curies) {
  data("tag2cn", package = "ontoProc2")
  cl <- semsql_connect(ontology = "cl")
  pr <- semsql_connect(ontology = "pr")
  on.exit({
    disconnect(cl)
    disconnect(pr)
  })
  pmp4type <- dplyr::tbl(cl@con, "entailed_edge") |>
    dplyr::filter(subject %in% curies, predicate == "RO:0002104") |>
    as.data.frame() |>
    dplyr::filter(grepl("PR:", object)) |>
    dplyr::select(subject, object)
  ok <- pmp4type$object
  prmed <- dplyr::tbl(pr@con, "rdfs_label_statement") |>
    dplyr::filter(subject %in% ok) |>
    as.data.frame()
  lj <- dplyr::left_join(pmp4type |>
    dplyr::mutate(cl = subject, prtag = object), prmed |>
    dplyr::mutate(prtag = subject, prlab = value), by = "prtag") |> dplyr::select(cl, prtag, prlab)
  cn <- tag2cn[lj$cl]
  ans <- data.frame(cl = lj$cl, celltype = cn, pr = lj$prtag, protein = lj$prlab)
  ans |> dplyr::filter(pr != "PR:000000001")
}
