library(ontoProc2)

test_that("retriever behaves reasonably", {
con = retrieve_semsql_conn("aio")
aio = SemSQL(con, "aio")
expect_true(slot(aio, "resource")=="aio")
expect_true(slot(aio, "nstats")>100)
DBI::dbDisconnect(con)
expect_error({
z <- suppressWarnings( tryCatch({
     retrieve_semsql_conn("xyzzyAA", quietly=TRUE) # use ...
  }, error = function(e) {
    stop(paste0("Download failed: ", e$message))
  }) )
})
})

