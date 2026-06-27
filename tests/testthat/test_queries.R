library(ontoProc2)

# Shared helper: pick the first AIO term with a label for use across tests
.get_test_term <- function(conn) {
  run_query(conn,
    "SELECT subject FROM rdfs_label_statement WHERE subject LIKE 'AIO:%' LIMIT 1"
  )$subject[1]
}

# ---------------------------------------------------------------------------
# search_labels
# ---------------------------------------------------------------------------

test_that("search_labels returns a data.frame with matching rows", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  result <- search_labels(conn, "a")
  expect_s3_class(result, "data.frame")
  expect_true(all(c("subject", "label") %in% names(result)))
  expect_true(nrow(result) > 0L)
})

test_that("search_labels respects the limit argument", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  result <- search_labels(conn, "a", limit = 3L)
  expect_lte(nrow(result), 3L)
})

test_that("search_labels returns 0-row data.frame for pattern with no match", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  result <- search_labels(conn, "zzzzz_no_match_xyzzy_99999")
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 0L)
})

# ---------------------------------------------------------------------------
# get_label
# ---------------------------------------------------------------------------

test_that("get_label returns data.frame for a known term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_label(conn, term)
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) >= 1L)
  expect_true("label" %in% names(result))
})

test_that("get_label returns 0-row data.frame for unknown term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  result <- get_label(conn, "AIO:9999999999")
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 0L)
})

# ---------------------------------------------------------------------------
# get_definition
# ---------------------------------------------------------------------------

test_that("get_definition returns character(1) or NA for any term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_definition(conn, term)
  expect_true(is.character(result) || is.na(result))
  expect_length(result, 1L)
})

test_that("get_definition returns NA for unknown term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  result <- get_definition(conn, "AIO:9999999999")
  expect_true(is.na(result))
})

# ---------------------------------------------------------------------------
# get_synonyms
# ---------------------------------------------------------------------------

test_that("get_synonyms returns a data.frame for type='all'", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_synonyms(conn, term, type = "all")
  expect_s3_class(result, "data.frame")
  expect_true(all(c("subject", "predicate", "synonym") %in% names(result)))
})

test_that("get_synonyms accepts explicit synonym type", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  for (tp in c("exact", "broad", "narrow", "related")) {
    result <- get_synonyms(conn, term, type = tp)
    expect_s3_class(result, "data.frame")
  }
})

# ---------------------------------------------------------------------------
# get_term_info
# ---------------------------------------------------------------------------

test_that("get_term_info returns a list with expected elements", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  info <- get_term_info(conn, term)
  expect_type(info, "list")
  expect_true(all(c("id", "label", "definition", "synonyms",
                    "superclasses", "subclasses") %in% names(info)))
  expect_equal(info$id, term)
})

# ---------------------------------------------------------------------------
# get_direct_edges
# ---------------------------------------------------------------------------

test_that("get_direct_edges returns data.frame with expected columns", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  for (dir in c("outgoing", "incoming", "both")) {
    result <- get_direct_edges(conn, term, direction = dir)
    expect_s3_class(result, "data.frame")
    expect_true(all(c("subject", "predicate", "object") %in% names(result)))
  }
})

# ---------------------------------------------------------------------------
# get_direct_subclasses / get_direct_superclasses
# ---------------------------------------------------------------------------

test_that("get_direct_subclasses returns data.frame with id and label", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_direct_subclasses(conn, term)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("id", "label") %in% names(result)))
})

test_that("get_direct_superclasses returns data.frame with id and label", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_direct_superclasses(conn, term)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("id", "label") %in% names(result)))
})

# ---------------------------------------------------------------------------
# get_ancestors / get_descendants
# ---------------------------------------------------------------------------

test_that("get_ancestors returns data.frame with id, label, predicate", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_ancestors(conn, term)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("id", "label", "predicate") %in% names(result)))
})

test_that("get_ancestors with include_self=TRUE includes the query term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result_with <- get_ancestors(conn, term, include_self = TRUE)
  result_without <- get_ancestors(conn, term, include_self = FALSE)
  if (nrow(result_with) > 0) {
    expect_true(term %in% result_with$id)
  }
  if (nrow(result_without) > 0) {
    expect_false(term %in% result_without$id)
  }
})

test_that("get_descendants returns data.frame with id, label, predicate", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_descendants(conn, term)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("id", "label", "predicate") %in% names(result)))
})

test_that("get_descendants with include_self=TRUE includes the query term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result_with <- get_descendants(conn, term, include_self = TRUE)
  result_without <- get_descendants(conn, term, include_self = FALSE)
  if (nrow(result_with) > 0) {
    expect_true(term %in% result_with$id)
  }
  if (nrow(result_without) > 0) {
    expect_false(term %in% result_without$id)
  }
})

test_that("get_ancestors_partonomy returns data.frame", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_ancestors_partonomy(conn, term)
  expect_s3_class(result, "data.frame")
})

test_that("get_descendants_partonomy returns data.frame", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_descendants_partonomy(conn, term)
  expect_s3_class(result, "data.frame")
})

# ---------------------------------------------------------------------------
# count_descendants
# ---------------------------------------------------------------------------

test_that("count_descendants returns a non-negative integer", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  n <- count_descendants(conn, term)
  expect_type(n, "integer")
  expect_length(n, 1L)
  expect_gte(n, 0L)
})

# ---------------------------------------------------------------------------
# get_restrictions / find_by_restriction / find_intersection
# ---------------------------------------------------------------------------

test_that("get_restrictions returns a data.frame for any term", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- get_restrictions(conn, term)
  expect_s3_class(result, "data.frame")
  expected_cols <- c("restriction_id", "property", "property_label", "filler", "filler_label")
  expect_true(all(expected_cols %in% names(result)))
})

test_that("find_by_restriction returns a data.frame", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- find_by_restriction(conn, "BFO:0000050", term)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("id", "label") %in% names(result)))
})

test_that("find_by_restriction with include_filler_descendants=TRUE returns data.frame", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- find_by_restriction(conn, "BFO:0000050", term,
                                include_filler_descendants = TRUE)
  expect_s3_class(result, "data.frame")
})

test_that("find_intersection returns a data.frame", {
  conn <- semsql_connect(ontology = "aio")
  on.exit(disconnect(conn, quiet = TRUE))
  term <- .get_test_term(conn)
  result <- find_intersection(conn, term, "BFO:0000050", term)
  expect_s3_class(result, "data.frame")
  expect_true(all(c("id", "label") %in% names(result)))
})
