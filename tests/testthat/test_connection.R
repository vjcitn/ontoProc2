library(ontoProc2)

test_that("semsql_connect returns SemsqlConn for cached ontology", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  expect_true(inherits(conn, "ontoProc2::SemsqlConn"))
})

test_that("is_connected returns TRUE for open connection", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  expect_true(is_connected(conn))
})

test_that("disconnect closes connection and is_connected returns FALSE", {
  conn <- semsql_connect(ontology = "aio")
  expect_true(is_connected(conn))
  disconnect(conn, quiet = TRUE)
  expect_false(is_connected(conn))
})

test_that("reconnect restores a disconnected connection", {
  conn <- semsql_connect(ontology = "aio")
  disconnect(conn, quiet = TRUE)
  expect_false(is_connected(conn))
  conn2 <- reconnect(conn)
  on.exit(disconnect(conn2, quiet = TRUE))
  expect_true(is_connected(conn2))
})

test_that("reconnect on already-connected object returns it unchanged", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  conn2 <- reconnect(conn)
  expect_true(is_connected(conn2))
  disconnect(conn2, quiet = TRUE)
})

test_that("get_prefix returns the ontology prefix", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  expect_equal(get_prefix(conn), "AIO")
})

test_that("list_tables returns a character vector of table names", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  tbls <- list_tables(conn)
  expect_type(tbls, "character")
  expect_true(length(tbls) > 0)
  expect_true("rdfs_label_statement" %in% tbls)
  expect_true("edge" %in% tbls)
  expect_true("entailed_edge" %in% tbls)
})

test_that("describe_table returns a data.frame with PRAGMA info", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  info <- describe_table(conn, "rdfs_label_statement")
  expect_s3_class(info, "data.frame")
  expect_true(nrow(info) > 0)
  expect_true("name" %in% names(info))
})

test_that("describe_table errors on unknown table", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  expect_error(describe_table(conn, "no_such_table_xyz"))
})

test_that("count_by_prefix returns a data.frame with prefix and n columns", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  df <- count_by_prefix(conn)
  expect_s3_class(df, "data.frame")
  expect_true(nrow(df) > 0)
  expect_true(all(c("prefix", "n") %in% names(df)))
  expect_true(any(tolower(df$prefix) == "aio"))
})

test_that("run_query executes arbitrary SQL and returns data.frame", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  result <- run_query(conn, "SELECT subject, value AS label FROM rdfs_label_statement LIMIT 3")
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 3L)
  expect_true(all(c("subject", "label") %in% names(result)))
})

test_that("report runs without error on connected object", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  expect_invisible(report(conn))
})

test_that("report runs without error on disconnected object", {
  conn <- semsql_connect(ontology = "aio")
  disconnect(conn, quiet = TRUE)
  expect_invisible(report(conn))
})

test_that("semsql_connect errors when db_path and ontology are both NULL", {
  expect_error(semsql_connect())
})

test_that("semsql_connect errors for non-existent db_path", {
  expect_error(semsql_connect(db_path = "/no/such/file.db"))
})

test_that("retrieve_semsql_conn errors for unknown ontology", {
  expect_error(
    suppressWarnings(tryCatch(
      retrieve_semsql_conn("xyzzy_notanontology_abc123", quietly = TRUE),
      error = function(e) stop(paste0("Download failed: ", e$message))
    ))
  )
})

test_that("with_connection evaluates expression and auto-disconnects", {
  conn <- semsql_connect(ontology = "aio")
  db_path <- conn@db_path
  disconnect(conn, quiet = TRUE)
  result <- with_connection(db_path, {
    run_query(conn, "SELECT COUNT(*) AS n FROM rdfs_label_statement")$n
  })
  expect_type(result, "integer")
  expect_true(result > 0L)
})
