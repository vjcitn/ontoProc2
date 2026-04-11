library(ontoProc2)

test_that("retriever behaves reasonably", {
  conn <- semsql_connect(ontology = "aio")
  expect_true(inherits(conn, "ontoProc2::SemsqlConn"))
  expect_true(get_prefix(conn) == "AIO")
  expect_true(nrow(count_by_prefix(conn)) > 0)
  disconnect(conn)
  expect_error({
    suppressWarnings(tryCatch(
      {
        retrieve_semsql_conn("xyzzyAA", quietly = TRUE)
      },
      error = function(e) {
        stop(paste0("Download failed: ", e$message))
      }
    ))
  })
})
