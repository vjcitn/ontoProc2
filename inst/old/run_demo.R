#' @description
#' Runs a series of example queries against a \code{SemsqlConn} object using
#' the Cell Ontology neuron term (\code{CL:0000540}) as the example. Useful
#' for verifying a new connection is working correctly.
#'
#' @param conn A \code{SemsqlConn} object.
#' @return NULL invisibly, called for its side effects.
#' @examples
#' goref <- semsql_connect(ontology = "go")
#' run_demo(goref)
#' disconnect(goref)
#' @export
run_demo <- function(conn) {
  stopifnot(inherits(conn, "SemsqlConn"))

  cat("\n", strrep("=", 50), "\n", sep = "")
  cat("SemsqlConn Demo\n")
  cat(strrep("=", 50), "\n\n")

  cat("1. Searching for terms containing 'apoptosis':\n")
  hits <- search_labels(conn, "apoptosis", limit = 5L)
  print(hits)

  cat("\n", strrep("-", 40), "\n\n")

  cat("2. Term info for 'apoptotic process' (GO:0006915):\n")
  info <- get_term_info(conn, "GO:0006915")
  cat("   Label:", info$label, "\n")
  cat("   Definition:", substr(info$definition, 1, 100), "...\n")

  cat("\n", strrep("-", 40), "\n\n")

  cat("3. Direct superclasses of apoptotic process:\n")
  print(info$superclasses)

  cat("\n", strrep("-", 40), "\n\n")

  cat("4. All ancestors of apoptotic process:\n")
  ancestors <- get_ancestors(conn, "GO:0006915")
  print(head(ancestors, 10))
  cat("   ... (", nrow(ancestors), " total ancestors)\n")

  cat("\n", strrep("-", 40), "\n\n")

  cat("5. Counting descendants:\n")
  n <- count_descendants(conn, "GO:0006915")
  cat("   Apoptotic process has", n, "descendant terms\n")

  cat("\n", strrep("=", 50), "\n")
  cat("Demo complete!\n")
  cat(strrep("=", 50), "\n")
  invisible(NULL)
}
