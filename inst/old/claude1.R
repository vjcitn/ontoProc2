# =============================================================================
# SemanticSQL Tutorial in R - Working with Cell Ontology (CL)
# =============================================================================
# This script emulates the activities from the SemanticSQL Jupyter notebook
# using RSQLite to query the Cell Ontology database.
#
# The CL database follows the semantic-sql schema, which provides standardized
# SQL views for OWL/RDF ontologies.
# =============================================================================

library(DBI)
library(RSQLite)
library(dplyr)    # Optional: for tidyverse-style data manipulation

# =============================================================================
# 1. CONNECT TO THE DATABASE
# =============================================================================
# Replace with your actual path to the CL database
# You can download it from: https://s3.amazonaws.com/bbop-sqlite/cl.db.gz

#connect_to_cl <- function(db_path) {
#  con <- dbConnect(RSQLite::SQLite(), db_path)
#  message("Connected to CL database: ", db_path)
#  return(con)
#}

library(ontoProc2)
con = retrieve_semsql_conn("cl")

# Usage: con <- connect_to_cl("path/to/cl.db")

# =============================================================================
# 2. EXPLORE DATABASE STRUCTURE
# =============================================================================

# List all tables and views in the database
list_tables <- function(con) {
  tables <- dbListTables(con)
  cat("Tables and views in the database:\n")
  print(tables)
  return(tables)
}

# Get column info for a specific table
describe_table <- function(con, table_name) {
  query <- sprintf("PRAGMA table_info(%s)", table_name)
  info <- dbGetQuery(con, query)
  cat("Columns in", table_name, ":\n")
  print(info[, c("name", "type")])
  return(info)
}

# =============================================================================
# 3. BASIC LABEL QUERIES - rdfs_label_statement
# =============================================================================
# The rdfs_label_statement view contains human-readable labels for all terms

# Search for terms by label pattern
search_by_label <- function(con, pattern, limit = 20) {
  query <- sprintf("
    SELECT subject, value AS label
    FROM rdfs_label_statement
    WHERE value LIKE '%%%s%%'
    LIMIT %d
  ", pattern, limit)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Get label for a specific term (CURIE)
get_label <- function(con, term_id) {
  query <- sprintf("
    SELECT subject, value AS label
    FROM rdfs_label_statement
    WHERE subject = '%s'
  ", term_id)
  
  result <- dbGetQuery(con, query)
  return(result)
}

# Example: search_by_label(con, "neuron")
# Example: get_label(con, "CL:0000540")

# =============================================================================
# 4. TEXT DEFINITIONS - has_text_definition_statement
# =============================================================================

# Get definition for a term
get_definition <- function(con, term_id) {
  query <- sprintf("
    SELECT subject, value AS definition
    FROM has_text_definition_statement
    WHERE subject = '%s'
  ", term_id)
  
  result <- dbGetQuery(con, query)
  return(result)
}

# Search definitions containing a pattern
search_definitions <- function(con, pattern, limit = 20) {
  query <- sprintf("
    SELECT 
      d.subject,
      l.value AS label,
      d.value AS definition
    FROM has_text_definition_statement d
    LEFT JOIN rdfs_label_statement l ON d.subject = l.subject
    WHERE d.value LIKE '%%%s%%'
    LIMIT %d
  ", pattern, limit)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# =============================================================================
# 5. SYNONYMS - has_synonym_statement and related views
# =============================================================================

# Get all synonyms for a term
get_synonyms <- function(con, term_id) {
  query <- sprintf("
    SELECT 
      subject,
      predicate,
      value AS synonym
    FROM has_oio_synonym_statement
    WHERE subject = '%s'
  ", term_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Get exact synonyms only
get_exact_synonyms <- function(con, term_id) {
  query <- sprintf("
    SELECT subject, value AS exact_synonym
    FROM has_exact_synonym_statement
    WHERE subject = '%s'
  ", term_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# =============================================================================
# 6. DIRECT EDGES (ASSERTED RELATIONSHIPS) - edge table
# =============================================================================
# The edge table contains direct (one-hop) relationships

# Get all direct edges for a subject
get_direct_edges <- function(con, term_id) {
  query <- sprintf("
    SELECT 
      e.subject,
      sl.value AS subject_label,
      e.predicate,
      pl.value AS predicate_label,
      e.object,
      ol.value AS object_label
    FROM edge e
    LEFT JOIN rdfs_label_statement sl ON e.subject = sl.subject
    LEFT JOIN rdfs_label_statement pl ON e.predicate = pl.subject
    LEFT JOIN rdfs_label_statement ol ON e.object = ol.subject
    WHERE e.subject = '%s'
  ", term_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Get direct subclasses of a term
get_direct_subclasses <- function(con, term_id) {
  query <- sprintf("
    SELECT 
      e.subject AS subclass_id,
      l.value AS subclass_label
    FROM edge e
    LEFT JOIN rdfs_label_statement l ON e.subject = l.subject
    WHERE e.object = '%s'
      AND e.predicate = 'rdfs:subClassOf'
  ", term_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Get direct superclasses (parents) of a term
get_direct_superclasses <- function(con, term_id) {
  query <- sprintf("
    SELECT 
      e.object AS superclass_id,
      l.value AS superclass_label
    FROM edge e
    LEFT JOIN rdfs_label_statement l ON e.object = l.subject
    WHERE e.subject = '%s'
      AND e.predicate = 'rdfs:subClassOf'
  ", term_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# =============================================================================
# 7. ENTAILED EDGES (INFERRED RELATIONSHIPS) - entailed_edge table
# =============================================================================
# The entailed_edge table contains pre-computed transitive closure
# This is generated by relation-graph and includes inferred relationships

# Get all ancestors (transitive superclasses) of a term
get_ancestors <- function(con, term_id, predicates = c("rdfs:subClassOf")) {
  pred_list <- paste0("'", predicates, "'", collapse = ", ")
  
  query <- sprintf("
    SELECT 
      ee.object AS ancestor_id,
      l.value AS ancestor_label,
      ee.predicate
    FROM entailed_edge ee
    LEFT JOIN rdfs_label_statement l ON ee.object = l.subject
    WHERE ee.subject = '%s'
      AND ee.predicate IN (%s)
    ORDER BY l.value
  ", term_id, pred_list)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Get all descendants (transitive subclasses) of a term
get_descendants <- function(con, term_id, predicates = c("rdfs:subClassOf")) {
  pred_list <- paste0("'", predicates, "'", collapse = ", ")
  
  query <- sprintf("
    SELECT 
      ee.subject AS descendant_id,
      l.value AS descendant_label,
      ee.predicate
    FROM entailed_edge ee
    LEFT JOIN rdfs_label_statement l ON ee.subject = l.subject
    WHERE ee.object = '%s'
      AND ee.predicate IN (%s)
    ORDER BY l.value
  ", term_id, pred_list)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Get ancestors including part-of relationships
get_ancestors_with_partonomy <- function(con, term_id) {
  # BFO:0000050 is the standard CURIE for "part of"
  predicates <- c("rdfs:subClassOf", "BFO:0000050")
  return(get_ancestors(con, term_id, predicates))
}

# =============================================================================
# 8. OWL RESTRICTIONS - owl_some_values_from
# =============================================================================
# Query existential restrictions (e.g., "has part some X", "part of some Y")

# Get all existential restrictions for a class
get_existential_restrictions <- function(con, term_id) {
  query <- sprintf("
    SELECT 
      svf.id,
      svf.on_property,
      pl.value AS property_label,
      svf.filler,
      fl.value AS filler_label
    FROM owl_some_values_from svf
    LEFT JOIN rdfs_label_statement pl ON svf.on_property = pl.subject
    LEFT JOIN rdfs_label_statement fl ON svf.filler = fl.subject
    WHERE svf.id IN (
      SELECT object FROM rdfs_subclass_of_statement WHERE subject = '%s'
    )
  ", term_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Find all classes that have a specific relationship to a filler
# e.g., all cells that are "part of" some organ
find_classes_with_restriction <- function(con, property, filler) {
  query <- sprintf("
    SELECT 
      sc.subject AS class_id,
      cl.value AS class_label
    FROM rdfs_subclass_of_statement sc
    JOIN owl_some_values_from svf ON sc.object = svf.id
    LEFT JOIN rdfs_label_statement cl ON sc.subject = cl.subject
    WHERE svf.on_property = '%s'
      AND svf.filler = '%s'
  ", property, filler)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# =============================================================================
# 9. COMPLEX QUERIES - Multi-table Joins
# =============================================================================

# Get comprehensive term information
get_term_info <- function(con, term_id) {
  # Get label
  label <- get_label(con, term_id)
  
  # Get definition
  definition <- get_definition(con, term_id)
  
  # Get synonyms
  synonyms <- get_synonyms(con, term_id)
  
  # Get direct superclasses
  superclasses <- get_direct_superclasses(con, term_id)
  
  # Get direct subclasses
  subclasses <- get_direct_subclasses(con, term_id)
  
  result <- list(
    id = term_id,
    label = if(nrow(label) > 0) label$label else NA,
    definition = if(nrow(definition) > 0) definition$definition else NA,
    synonyms = synonyms,
    superclasses = superclasses,
    subclasses = subclasses
  )
  
  return(result)
}

# Find terms that are subclasses of A AND related to B
# Useful for finding cell types in a specific location
find_intersection <- function(con, superclass_id, relation_property, related_to_id) {
  query <- sprintf("
    WITH descendants AS (
      SELECT subject FROM entailed_edge
      WHERE object = '%s' AND predicate = 'rdfs:subClassOf'
    ),
    related AS (
      SELECT sc.subject 
      FROM rdfs_subclass_of_statement sc
      JOIN owl_some_values_from svf ON sc.object = svf.id
      WHERE svf.on_property = '%s'
        AND svf.filler IN (
          SELECT subject FROM entailed_edge
          WHERE object = '%s' AND predicate = 'rdfs:subClassOf'
          UNION SELECT '%s'
        )
    )
    SELECT 
      d.subject AS term_id,
      l.value AS term_label
    FROM descendants d
    JOIN related r ON d.subject = r.subject
    LEFT JOIN rdfs_label_statement l ON d.subject = l.subject
    ORDER BY l.value
  ", superclass_id, relation_property, related_to_id, related_to_id)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# =============================================================================
# 10. STATISTICS AND SUMMARIES
# =============================================================================

# Count terms by prefix (namespace)
count_by_prefix <- function(con) {
  query <- "
    SELECT 
      SUBSTR(subject, 1, INSTR(subject, ':') - 1) AS prefix,
      COUNT(*) AS count
    FROM rdfs_label_statement
    GROUP BY prefix
    ORDER BY count DESC
  "
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Count subclasses for top-level terms
count_descendants <- function(con, term_id) {
  query <- sprintf("
    SELECT COUNT(DISTINCT subject) AS descendant_count
    FROM entailed_edge
    WHERE object = '%s'
      AND predicate = 'rdfs:subClassOf'
  ", term_id)
  
  result <- dbGetQuery(con, query)
  return(result$descendant_count)
}

# =============================================================================
# 11. HELPER FUNCTIONS FOR COMMON CL QUERIES
# =============================================================================

# Common CL root classes
CL_ROOTS <- list(
  cell = "CL:0000000",           # cell (root of cell ontology)
  native_cell = "CL:0000003",    # native cell
  stuff_accumulating_cell = "CL:0000325"
)

# Get all cell types (descendants of CL:0000000)
get_all_cell_types <- function(con, limit = 100) {
  query <- sprintf("
    SELECT 
      ee.subject AS cell_type_id,
      l.value AS cell_type_label
    FROM entailed_edge ee
    LEFT JOIN rdfs_label_statement l ON ee.subject = l.subject
    WHERE ee.object = 'CL:0000000'
      AND ee.predicate = 'rdfs:subClassOf'
      AND ee.subject LIKE 'CL:%%'
    ORDER BY l.value
    LIMIT %d
  ", limit)
  
  results <- dbGetQuery(con, query)
  return(results)
}

# Find neurons (subclasses of neuron CL:0000540)
get_neuron_types <- function(con) {
  return(get_descendants(con, "CL:0000540"))
}

# =============================================================================
# 12. EXAMPLE USAGE / DEMO FUNCTION
# =============================================================================

run_demo <- function(con) {
  cat("\n========================================\n")
  cat("SemanticSQL CL Tutorial Demo\n")
  cat("========================================\n\n")
  
  # 1. Search for terms containing "neuron"
  cat("1. Searching for terms containing 'neuron':\n")
  neurons <- search_by_label(con, "neuron", limit = 10)
  print(neurons)
  
  cat("\n----------------------------------------\n")
  
  # 2. Get info about a specific neuron type
  cat("2. Getting info for 'neuron' (CL:0000540):\n")
  neuron_info <- get_term_info(con, "CL:0000540")
  cat("Label:", neuron_info$label, "\n")
  cat("Definition:", substr(neuron_info$definition, 1, 200), "...\n")
  
  cat("\n----------------------------------------\n")
  
  # 3. Get direct superclasses
  cat("3. Direct superclasses of neuron:\n")
  print(neuron_info$superclasses)
  
  cat("\n----------------------------------------\n")
  
  # 4. Get some descendants
  cat("4. Some descendants of neuron (first 10):\n")
  descendants <- get_descendants(con, "CL:0000540")
  print(head(descendants, 10))
  
  cat("\n----------------------------------------\n")
  
  # 5. Get ancestors
  cat("5. Ancestors of neuron:\n")
  ancestors <- get_ancestors(con, "CL:0000540")
  print(ancestors)
  
  cat("\n========================================\n")
  cat("Demo complete!\n")
  cat("========================================\n")
}

# =============================================================================
# USAGE EXAMPLE (uncomment to run):
# =============================================================================
# 
# # Connect to database
# con <- connect_to_cl("path/to/cl.db")
# 
# # List tables
# list_tables(con)
# 
# # Run demo
# run_demo(con)
# 
# # Custom queries
# search_by_label(con, "T cell")
# get_term_info(con, "CL:0000084")  # T cell
# get_ancestors(con, "CL:0000084")
# 
# # Disconnect
# dbDisconnect(con)
#
#cat("SemanticSQL CL Tutorial functions loaded.\n")
#cat("Use connect_to_cl('path/to/cl.db') to connect.\n")
#cat("Use run_demo(con) to see example queries.\n")
