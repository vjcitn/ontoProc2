library(ontoProc2)

test_that("semsql_url formats URL correctly", {
  url <- semsql_url("cl")
  expect_type(url, "character")
  expect_length(url, 1L)
  expect_match(url, "^https://s3\\.amazonaws\\.com/bbop-sqlite/cl\\.db\\.gz$")
})

test_that("semsql_url works for different ontologies", {
  expect_match(semsql_url("go"), "go\\.db\\.gz$")
  expect_match(semsql_url("efo"), "efo\\.db\\.gz$")
  expect_match(semsql_url("aio"), "aio\\.db\\.gz$")
})

test_that("PREDICATES is a named list with expected elements", {
  expect_type(PREDICATES, "list")
  expected <- c("subclass_of", "part_of", "has_part", "develops_from",
                "located_in", "has_characteristic")
  expect_true(all(expected %in% names(PREDICATES)))
})

test_that("PREDICATES contains correct CURIE values", {
  expect_equal(PREDICATES$subclass_of, "rdfs:subClassOf")
  expect_equal(PREDICATES$part_of, "BFO:0000050")
  expect_equal(PREDICATES$has_part, "BFO:0000051")
  expect_equal(PREDICATES$develops_from, "RO:0002202")
  expect_equal(PREDICATES$located_in, "RO:0001025")
  expect_equal(PREDICATES$has_characteristic, "RO:0000053")
})
