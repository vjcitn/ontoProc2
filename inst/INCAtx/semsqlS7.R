# =============================================================================
# SemanticSQL R Interface - S7 Class Implementation
# =============================================================================
# An S7 class wrapper for querying ontologies via SQLite databases
# following the SemanticSQL schema.
# =============================================================================

library(DBI)
library(RSQLite)
library(S7)
library(ontoProc2)

con = retrieve_semsql_conn("cl")
pa = con@dbname
obj = semsql_connect(pa)

# =============================================================================
# CLASS DEFINITION
# =============================================================================

#' SemsqlConn - A connection wrapper for SemanticSQL databases
#' 
#' @description
#' An S7 class that encapsulates a SQLite connection to an ontology database
#' following the SemanticSQL schema. Provides methods for common ontology
#' queries including label lookup, ancestor/descendant traversal, and
#' relationship queries.
#'
#' @slot con The DBI connection object
#' @slot db_path Path to the SQLite database file
#' @slot ontology_prefix Primary ontology prefix (e.g., "CL" for Cell Ontology
SemsqlConn <- new_class(

"SemsqlConn",
  properties = list(
    con = class_any,
    db_path = class_character,
    ontology_prefix = class_character
  ),
  validator = function(self) {
    if (!inherits(self@con, "SQLiteConnection")) {
      return("@con must be a SQLiteConnection object")
    }
    if (!dbIsValid(self@con)) {
      return("Database connection is not valid")
    }
    NULL
  }
)

# =============================================================================
# CONSTRUCTOR FUNCTION
# =============================================================================

#' Create a new SemsqlConn connection
#'
#' @param db_path Path to the SQLite database file
#' @param ontology_prefix Primary prefix for the ontology (default: auto-detect)
#' @return A SemsqlConn object
#' @export
semsql_connect <- function(db_path, ontology_prefix = NULL) {
  if (!file.exists(db_path)) {
    stop("Database file not found: ", db_path)
  }
  
con <- dbConnect(RSQLite::SQLite(), db_path)
  
  # Auto-detect ontology prefix if not provided
  if (is.null(ontology_prefix)) {
    prefix_query <- "
      SELECT SUBSTR(subject, 1, INSTR(subject, ':') - 1) AS prefix,
             COUNT(*) AS n
      FROM rdfs_label_statement
      WHERE subject LIKE '%:%'
      GROUP BY prefix
      ORDER BY n DESC
      LIMIT 1
    "
    result <- dbGetQuery(con, prefix_query)
    ontology_prefix <- if (nrow(result) > 0) result$prefix[1] else ""
  }
  
  message("Connected to SemanticSQL database: ", db_path)
  message("Primary ontology prefix: ", ontology_prefix)
  
  SemsqlConn(
    con = con,
    db_path = db_path,
    ontology_prefix = ontology_prefix
  )
}

# =============================================================================
# GENERICS
# =============================================================================

# Connection management
disconnect <- new_generic("disconnect", "x")
is_connected <- new_generic("is_connected", "x")
list_tables <- new_generic("list_tables", "x")
describe_table <- new_generic("describe_table", "x")

# Basic queries
search_labels <- new_generic("search_labels", "x")
get_label <- new_generic("get_label", "x")
get_definition <- new_generic("get_definition", "x")
get_synonyms <- new_generic("get_synonyms", "x")
get_term_info <- new_generic("get_term_info", "x")

# Edge/relationship queries
get_direct_edges <- new_generic("get_direct_edges", "x")
get_direct_subclasses <- new_generic("get_direct_subclasses", "x")
get_direct_superclasses <- new_generic("get_direct_superclasses", "x")

# Entailed (transitive) queries
get_ancestors <- new_generic("get_ancestors", "x")
get_descendants <- new_generic("get_descendants", "x")

# OWL restriction queries
get_restrictions <- new_generic("get_restrictions", "x")
find_by_restriction <- new_generic("find_by_restriction", "x")

# Complex queries
find_intersection <- new_generic("find_intersection", "x")

# Statistics
count_descendants <- new_generic("count_descendants", "x")
count_by_prefix <- new_generic("count_by_prefix", "x")

# Utility
run_query <- new_generic("run_query", "x")

# =============================================================================
# CONNECTION MANAGEMENT METHODS
# =============================================================================

method(disconnect, SemsqlConn) <- function(x) {
  if (dbIsValid(x@con)) {
    dbDisconnect(x@con)
    message("Disconnected from database")
  }
  invisible(x)
}

method(is_connected, SemsqlConn) <- function(x) {
  dbIsValid(x@con)
}

method(list_tables, SemsqlConn) <- function(x) {
  dbListTables(x@con)
}

method(describe_table, SemsqlConn) <- function(x, table_name) {
  query <- sprintf("PRAGMA table_info(%s)", table_name)
  dbGetQuery(x@con, query)
}

method(run_query, SemsqlConn) <- function(x, sql) {
  dbGetQuery(x@con, sql)
}

# =============================================================================
# BASIC QUERY METHODS
# =============================================================================

method(search_labels, SemsqlConn) <- function(x, pattern, limit = 20L) {
  query <- sprintf("
    SELECT subject, value AS label
    FROM rdfs_label_statement
    WHERE value LIKE '%%%s%%'
    LIMIT %d
  ", pattern, limit)
  
  dbGetQuery(x@con, query)
}

method(get_label, SemsqlConn) <- function(x, term_id) {
  query <- sprintf("
    SELECT subject, value AS label
    FROM rdfs_label_statement
    WHERE subject = '%s'
  ", term_id)
  
  result <- dbGetQuery(x@con, query)
  if (nrow(result) == 0) return(NA_character_)
  result$label[1]
}

method(get_definition, SemsqlConn) <- function(x, term_id) {
  query <- sprintf("
    SELECT subject, value AS definition
    FROM has_text_definition_statement
    WHERE subject = '%s'
  ", term_id)
  
  result <- dbGetQuery(x@con, query)
  if (nrow(result) == 0) return(NA_character_)
  result$definition[1]
}

method(get_synonyms, SemsqlConn) <- function(x, term_id, type = c("all", "exact", "broad", "narrow", "related")) {
  type <- match.arg(type)
  
  view_name <- switch(type,
    all = "has_oio_synonym_statement",
    exact = "has_exact_synonym_statement",
    broad = "has_broad_synonym_statement",
    narrow = "has_narrow_synonym_statement",
    related = "has_related_synonym_statement"
  )
  
  query <- sprintf("
    SELECT subject, predicate, value AS synonym
    FROM %s
    WHERE subject = '%s'
  ", view_name, term_id)
  
  dbGetQuery(x@con, query)
}

method(get_term_info, SemsqlConn) <- function(x, term_id) {
  label <- get_label(x, term_id)
  definition <- get_definition(x, term_id)
  synonyms <- get_synonyms(x, term_id)
  superclasses <- get_direct_superclasses(x, term_id)
  subclasses <- get_direct_subclasses(x, term_id)
  
  list(
    id = term_id,
    label = label,
    definition = definition,
    synonyms = synonyms,
    superclasses = superclasses,
    subclasses = subclasses
  )
}

# =============================================================================
# EDGE QUERY METHODS
# =============================================================================

method(get_direct_edges, SemsqlConn) <- function(x, term_id, direction = c("outgoing", "incoming", "both")) {
  direction <- match.arg(direction)
  
  where_clause <- switch(direction,
    outgoing = sprintf("e.subject = '%s'", term_id),
    incoming = sprintf("e.object = '%s'", term_id),
    both = sprintf("e.subject = '%s' OR e.object = '%s'", term_id, term_id)
  )
  
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
    WHERE %s
  ", where_clause)
  
  dbGetQuery(x@con, query)
}

method(get_direct_subclasses, SemsqlConn) <- function(x, term_id) {
  query <- sprintf("
    SELECT 
      e.subject AS id,
      l.value AS label
    FROM edge e
    LEFT JOIN rdfs_label_statement l ON e.subject = l.subject
    WHERE e.object = '%s'
      AND e.predicate = 'rdfs:subClassOf'
    ORDER BY l.value
  ", term_id)
  
  dbGetQuery(x@con, query)
}

method(get_direct_superclasses, SemsqlConn) <- function(x, term_id) {
  query <- sprintf("
    SELECT 
      e.object AS id,
      l.value AS label
    FROM edge e
    LEFT JOIN rdfs_label_statement l ON e.object = l.subject
    WHERE e.subject = '%s'
      AND e.predicate = 'rdfs:subClassOf'
    ORDER BY l.value
  ", term_id)
  
  dbGetQuery(x@con, query)
}

# =============================================================================
# ENTAILED (TRANSITIVE) QUERY METHODS
# =============================================================================

method(get_ancestors, SemsqlConn) <- function(x, term_id, 
                                               predicates = "rdfs:subClassOf",
                                               include_self = FALSE) {
  pred_list <- paste0("'", predicates, "'", collapse = ", ")
  
  query <- sprintf("
    SELECT 
      ee.object AS id,
      l.value AS label,
      ee.predicate
    FROM entailed_edge ee
    LEFT JOIN rdfs_label_statement l ON ee.object = l.subject
    WHERE ee.subject = '%s'
      AND ee.predicate IN (%s)
    ORDER BY l.value
  ", term_id, pred_list)
  
  result <- dbGetQuery(x@con, query)
  
  # Filter out self if not requested
if (!include_self && nrow(result) > 0) {
    result <- result[result$id != term_id, , drop = FALSE]
  }
  
  result
}

method(get_descendants, SemsqlConn) <- function(x, term_id, 
                                                 predicates = "rdfs:subClassOf",
                                                 include_self = FALSE) {
  pred_list <- paste0("'", predicates, "'", collapse = ", ")
  
  query <- sprintf("
    SELECT 
      ee.subject AS id,
      l.value AS label,
      ee.predicate
    FROM entailed_edge ee
    LEFT JOIN rdfs_label_statement l ON ee.subject = l.subject
    WHERE ee.object = '%s'
      AND ee.predicate IN (%s)
    ORDER BY l.value
  ", term_id, pred_list)
  
  result <- dbGetQuery(x@con, query)
  
  # Filter out self if not requested
  if (!include_self && nrow(result) > 0) {
    result <- result[result$id != term_id, , drop = FALSE]
  }
  
  result
}

# =============================================================================
# OWL RESTRICTION QUERY METHODS
# =============================================================================

method(get_restrictions, SemsqlConn) <- function(x, term_id) {
  query <- sprintf("
    SELECT 
      svf.id AS restriction_id,
      svf.on_property AS property,
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
  
  dbGetQuery(x@con, query)
}

method(find_by_restriction, SemsqlConn) <- function(x, property, filler, 
                                                     include_filler_descendants = FALSE) {
  if (include_filler_descendants) {
    # Include classes that have restriction to filler or any of its descendants
    query <- sprintf("
      SELECT DISTINCT
        sc.subject AS id,
        cl.value AS label
      FROM rdfs_subclass_of_statement sc
      JOIN owl_some_values_from svf ON sc.object = svf.id
      LEFT JOIN rdfs_label_statement cl ON sc.subject = cl.subject
      WHERE svf.on_property = '%s'
        AND svf.filler IN (
          SELECT subject FROM entailed_edge
          WHERE object = '%s' AND predicate = 'rdfs:subClassOf'
          UNION SELECT '%s'
        )
      ORDER BY cl.value
    ", property, filler, filler)
  } else {
    query <- sprintf("
      SELECT DISTINCT
        sc.subject AS id,
        cl.value AS label
      FROM rdfs_subclass_of_statement sc
      JOIN owl_some_values_from svf ON sc.object = svf.id
      LEFT JOIN rdfs_label_statement cl ON sc.subject = cl.subject
      WHERE svf.on_property = '%s'
        AND svf.filler = '%s'
      ORDER BY cl.value
    ", property, filler)
  }
  
  dbGetQuery(x@con, query)
}

# =============================================================================
# COMPLEX QUERY METHODS
# =============================================================================

method(find_intersection, SemsqlConn) <- function(x, superclass_id, 
                                                   relation_property, 
                                                   related_to_id) {
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
      d.subject AS id,
      l.value AS label
    FROM descendants d
    JOIN related r ON d.subject = r.subject
    LEFT JOIN rdfs_label_statement l ON d.subject = l.subject
    ORDER BY l.value
  ", superclass_id, relation_property, related_to_id, related_to_id)
  
  dbGetQuery(x@con, query)
}

# =============================================================================
# STATISTICS METHODS
# =============================================================================

method(count_descendants, SemsqlConn) <- function(x, term_id, 
                                                   predicate = "rdfs:subClassOf") {
  query <- sprintf("
    SELECT COUNT(DISTINCT subject) AS n
    FROM entailed_edge
    WHERE object = '%s'
      AND predicate = '%s'
  ", term_id, predicate)
  
  result <- dbGetQuery(x@con, query)
  result$n[1]
}

method(count_by_prefix, SemsqlConn) <- function(x) {
  query <- "
    SELECT 
      SUBSTR(subject, 1, INSTR(subject, ':') - 1) AS prefix,
      COUNT(*) AS n
    FROM rdfs_label_statement
    WHERE subject LIKE '%:%'
    GROUP BY prefix
    ORDER BY n DESC
  "
  
  dbGetQuery(x@con, query)
}

# =============================================================================
# PRINT METHOD
# =============================================================================

method(print, SemsqlConn) <- function(x, ...) {
  cat("<SemsqlConn>\n")
  cat("  Database:", x@db_path, "\n")
  cat("  Prefix:", x@ontology_prefix, "\n")
  cat("  Connected:", is_connected(x), "\n")
  invisible(x)
}

# =============================================================================
# CONVENIENCE FUNCTIONS FOR COMMON PREDICATES
# =============================================================================

#' Standard predicate CURIEs used in OBO ontologies
PREDICATES <- list(
  subclass_of = "rdfs:subClassOf",
  part_of = "BFO:0000050",
  has_part = "BFO:0000051",
  develops_from = "RO:0002202",
  located_in = "RO:0001025",
  has_characteristic = "RO:0000053"
)

#' Get ancestors including part-of relationships
#' 
#' Convenience wrapper for get_ancestors with is-a and part-of predicates
get_ancestors_partonomy <- function(conn, term_id, include_self = FALSE) {
  get_ancestors(conn, term_id, 
                predicates = c(PREDICATES$subclass_of, PREDICATES$part_of),
                include_self = include_self)
}

#' Get descendants including has-part relationships
get_descendants_partonomy <- function(conn, term_id, include_self = FALSE) {
  get_descendants(conn, term_id,
                  predicates = c(PREDICATES$subclass_of, PREDICATES$has_part),
                  include_self = include_self)
}

# =============================================================================
# DEMO FUNCTION
# =============================================================================

#' Run a demonstration of SemsqlConn capabilities
#' 
#' @param conn A SemsqlConn object
#' @export
run_demo <- function(conn) {
  stopifnot(inherits(conn, "SemsqlConn"))
  
  cat("\n", strrep("=", 50), "\n", sep = "")
  cat("SemsqlConn Demo\n")
  cat(strrep("=", 50), "\n\n")
  
  # 1. Search for terms
  cat("1. Searching for terms containing 'neuron':\n")
  neurons <- search_labels(conn, "neuron", limit = 5L)
  print(neurons)
  
  cat("\n", strrep("-", 40), "\n\n")
  
  # 2. Get term info
  cat("2. Term info for 'neuron' (CL:0000540):\n")
  info <- get_term_info(conn, "CL:0000540")
  cat("   Label:", info$label, "\n")
  cat("   Definition:", substr(info$definition, 1, 100), "...\n")
  
  cat("\n", strrep("-", 40), "\n\n")
  
  # 3. Get superclasses
  cat("3. Direct superclasses of neuron:\n")
  print(info$superclasses)
  
  cat("\n", strrep("-", 40), "\n\n")
  
  # 4. Get ancestors
  cat("4. All ancestors of neuron:\n")
  ancestors <- get_ancestors(conn, "CL:0000540")
  print(head(ancestors, 10))
  cat("   ... (", nrow(ancestors), " total ancestors)\n")
  
  cat("\n", strrep("-", 40), "\n\n")
  
  # 5. Count descendants
  cat("5. Counting descendants:\n")
  n <- count_descendants(conn, "CL:0000540")
  cat("   Neuron has", n, "descendant cell types\n")
  
  cat("\n", strrep("=", 50), "\n")
  cat("Demo complete!\n")
  cat(strrep("=", 50), "\n")
}

# =============================================================================
# USAGE EXAMPLE
# =============================================================================
# 
# # Connect to database
# conn <- semsql_connect("path/to/cl.db")
# 
# # Print connection info
# print(conn)
# 
# # Run demo
# run_demo(conn)
# 
# # Search for terms
# search_labels(conn, "T cell")
# 
# # Get term information
# get_term_info(conn, "CL:0000084")
# 
# # Get ancestors
# get_ancestors(conn, "CL:0000084")
# 
# # Get ancestors including part-of
# get_ancestors_partonomy(conn, "CL:0000084")
# 
# # Find cells by restriction (e.g., cells "part of" some structure)
# find_by_restriction(conn, "BFO:0000050", "UBERON:0000955")  # part of brain
# 
# # Disconnect when done
# disconnect(conn)

cat("SemsqlConn S7 class loaded.\n")
cat("Use semsql_connect('path/to/db') to create a connection.\n")
