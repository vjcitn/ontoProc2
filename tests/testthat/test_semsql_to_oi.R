library(ontoProc2)

test_that("semsql_to_oi returns an ontology_index from aio connection", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  oi <- suppressWarnings(semsql_to_oi(conn@con))
  expect_true(inherits(oi, "ontology_index"))
})

test_that("semsql_to_oi result has name and parents elements", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  oi <- suppressWarnings(semsql_to_oi(conn@con))
  expect_true(all(c("name", "parents") %in% names(oi)))
})

test_that("semsql_to_oi result has at least one term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  oi <- suppressWarnings(semsql_to_oi(conn@con))
  expect_true(length(oi$name) > 0L)
})

test_that("semsql_to_oi errors if required tables are absent", {
  tmp <- tempfile(fileext = ".db")
  on.exit(unlink(tmp))
  con <- DBI::dbConnect(RSQLite::SQLite(), tmp)
  DBI::dbExecute(con, "CREATE TABLE dummy (id TEXT)")
  expect_error(semsql_to_oi(con))
  DBI::dbDisconnect(con)
})
