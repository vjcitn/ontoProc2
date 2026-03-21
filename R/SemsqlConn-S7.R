
# =============================================================================
# SemanticSQL R Interface - S7 Class Implementation
# =============================================================================

#' SemsqlConn: S7 connection wrapper for SemanticSQL databases
#'
#' @description
#' An S7 class that encapsulates a SQLite connection to an ontology database
#' following the SemanticSQL schema. Provides methods for common ontology
#' queries including label lookup, ancestor/descendant traversal, and
#' relationship queries.
#'
#' Properties:
#' \describe{
#'   \item{con}{The DBI connection object (SQLiteConnection)}
#'   \item{db_path}{character(1) path to the SQLite database file}
#'   \item{ontology_prefix}{character(1) primary ontology prefix,
#'     e.g. \code{"CL"} for the Cell Ontology}
#' }
#' @import S7
#' @export
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
S4_register(SemsqlConn)

# =============================================================================
# CONSTRUCTOR
# =============================================================================

#' Create a SemsqlConn connection
#'
#' @description
#' Opens a connection to a SemanticSQL SQLite database, either by supplying
#' a direct file path or by referencing a short ontology name that is
#' retrieved and cached via \code{BiocFileCache}.
#'
#' @param db_path character(1) or NULL. Path to an existing SQLite database
#'   file. Either \code{db_path} or \code{ontology} must be supplied.
#' @param ontology_prefix character(1) or NULL. Primary CURIE prefix for the
#'   ontology (e.g. \code{"CL"}). If NULL and \code{ontology} is supplied,
#'   defaults to \code{toupper(ontology)}; otherwise auto-detected from the
#'   database.
#' @param ontology character(1) or NULL. Short name of an INCAtools ontology
#'   (e.g. \code{"cl"}, \code{"go"}). If supplied,
#'   \code{\link{retrieve_semsql_conn}} is called to locate or download the
#'   cached database.
#' @param cache a \code{BiocFileCache} instance used when \code{ontology} is
#'   supplied. Defaults to \code{BiocFileCache::BiocFileCache()}.
#' @param \dots passed to \code{\link{retrieve_semsql_conn}} and ultimately
#'   to \code{\link[utils]{download.file}}.
#' @return A \code{\link{SemsqlConn}} object.
#' @examples
#' \dontrun{
#' # by ontology short name (downloads if not cached)
#' conn <- semsql_connect(ontology = "cl")
#'
#' # by explicit path
#' conn <- semsql_connect(db_path = "/path/to/cl.db", ontology_prefix = "CL")
#' }
#' @export
semsql_connect <- function(db_path = NULL, ontology_prefix = NULL,
                           ontology = NULL,
                           cache = BiocFileCache::BiocFileCache(), ...) {
  if (!is.null(ontology)) {
    raw_con <- retrieve_semsql_conn(ontology, cache = cache, ...)
    db_path <- raw_con@dbname
    dbDisconnect(raw_con)
    if (is.null(ontology_prefix)) ontology_prefix <- toupper(ontology)
  }
  if (is.null(db_path)) stop("Supply either db_path or ontology")
  if (!file.exists(db_path)) {
    stop("Database file not found: ", db_path)
  }

  con <- dbConnect(RSQLite::SQLite(), db_path)

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

#' Disconnect a SemsqlConn from its database
#'
#' @param x A \code{SemsqlConn} object.
#' @param quiet logical(1) if TRUE suppresses the disconnection message
#'   (default FALSE).
#' @return The \code{SemsqlConn} object invisibly.
#' @export
disconnect <- new_generic("disconnect", "x")

#' Test whether a SemsqlConn has a valid open connection
#'
#' @param x A \code{SemsqlConn} object.
#' @return logical(1).
#' @export
is_connected <- new_generic("is_connected", "x")

#' List tables in a SemsqlConn database
#'
#' @param x A \code{SemsqlConn} object.
#' @return character vector of table names.
#' @export
list_tables <- new_generic("list_tables", "x")

#' Describe the columns of a table in a SemsqlConn database
#'
#' @param x A \code{SemsqlConn} object.
#' @param table_name character(1) name of the table.
#' @return data.frame with PRAGMA table_info output (columns: cid, name, type,
#'   notnull, dflt_value, pk).
#' @export
describe_table <- new_generic("describe_table", "x")

#' Retrieve the ontology prefix from a SemsqlConn
#'
#' @param x A \code{SemsqlConn} object.
#' @return character(1) the primary ontology prefix (e.g. \code{"CL"}).
#' @export
get_prefix <- new_generic("get_prefix", "x")

#' Search term labels in a SemsqlConn database
#'
#' @param x A \code{SemsqlConn} object.
#' @param pattern character(1) substring to match against rdfs:label values
#'   (SQL LIKE pattern, case-insensitive on most SQLite builds).
#' @param limit integer(1) maximum number of rows to return (default 20).
#' @return data.frame with columns \code{subject} and \code{label}.
#' @examples
#' \dontrun{
#' conn <- semsql_connect(ontology = "cl")
#' search_labels(conn, "neuron")
#' disconnect(conn)
#' }
#' @export
search_labels <- new_generic("search_labels", "x")

#' Get the rdfs:label for a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE, e.g. \code{"CL:0000540"}.
#' @return character(1) label, or \code{NA_character_} if not found.
#' @export
get_label <- new_generic("get_label", "x")

#' Get the text definition for a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @return character(1) definition text, or \code{NA_character_} if not found.
#' @export
get_definition <- new_generic("get_definition", "x")

#' Get synonyms for a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param type character(1) synonym scope: one of \code{"all"},
#'   \code{"exact"}, \code{"broad"}, \code{"narrow"}, \code{"related"}.
#' @return data.frame with columns \code{subject}, \code{predicate},
#'   \code{synonym}.
#' @export
get_synonyms <- new_generic("get_synonyms", "x")

#' Retrieve a summary of information about a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @return list with elements \code{id}, \code{label}, \code{definition},
#'   \code{synonyms}, \code{superclasses}, \code{subclasses}.
#' @export
get_term_info <- new_generic("get_term_info", "x")

#' Get direct edges in the ontology graph for a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param direction character(1) one of \code{"outgoing"}, \code{"incoming"},
#'   \code{"both"}.
#' @return data.frame with columns \code{subject}, \code{subject_label},
#'   \code{predicate}, \code{predicate_label}, \code{object},
#'   \code{object_label}.
#' @export
get_direct_edges <- new_generic("get_direct_edges", "x")

#' Get direct subclasses of a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @return data.frame with columns \code{id} and \code{label}, ordered by
#'   label.
#' @export
get_direct_subclasses <- new_generic("get_direct_subclasses", "x")

#' Get direct superclasses of a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @return data.frame with columns \code{id} and \code{label}, ordered by
#'   label.
#' @export
get_direct_superclasses <- new_generic("get_direct_superclasses", "x")

#' Get all ancestors of a term via entailed edges
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param predicates character vector of predicate CURIEs to follow.
#'   Defaults to \code{"rdfs:subClassOf"}. See \code{\link{PREDICATES}} for
#'   common values.
#' @param include_self logical(1) whether to include the term itself
#'   (default \code{FALSE}).
#' @return data.frame with columns \code{id}, \code{label}, \code{predicate}.
#' @examples
#' \dontrun{
#' conn <- semsql_connect(ontology = "cl")
#' get_ancestors(conn, "CL:0000540")
#' disconnect(conn)
#' }
#' @export
get_ancestors <- new_generic("get_ancestors", "x")

#' Get all descendants of a term via entailed edges
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param predicates character vector of predicate CURIEs to follow.
#'   Defaults to \code{"rdfs:subClassOf"}.
#' @param include_self logical(1) whether to include the term itself
#'   (default \code{FALSE}).
#' @return data.frame with columns \code{id}, \code{label}, \code{predicate}.
#' @export
get_descendants <- new_generic("get_descendants", "x")

#' Get OWL someValuesFrom restrictions for a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @return data.frame with columns \code{restriction_id}, \code{property},
#'   \code{property_label}, \code{filler}, \code{filler_label}.
#' @export
get_restrictions <- new_generic("get_restrictions", "x")

#' Find terms that have a given OWL someValuesFrom restriction
#'
#' @param x A \code{SemsqlConn} object.
#' @param property character(1) property CURIE
#'   (e.g. \code{"BFO:0000050"} for part-of).
#' @param filler character(1) filler class CURIE.
#' @param include_filler_descendants logical(1) if TRUE also match subclasses
#'   of \code{filler} (default \code{FALSE}).
#' @return data.frame with columns \code{id} and \code{label}.
#' @export
find_by_restriction <- new_generic("find_by_restriction", "x")

#' Find terms that are descendants of a superclass and have a given restriction
#'
#' @param x A \code{SemsqlConn} object.
#' @param superclass_id character(1) CURIE of the superclass.
#' @param relation_property character(1) property CURIE for the restriction.
#' @param related_to_id character(1) filler CURIE for the restriction.
#' @return data.frame with columns \code{id} and \code{label}.
#' @export
find_intersection <- new_generic("find_intersection", "x")

#' Count the number of descendants of a term
#'
#' @param x A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param predicate character(1) predicate to traverse
#'   (default \code{"rdfs:subClassOf"}).
#' @return integer(1).
#' @export
count_descendants <- new_generic("count_descendants", "x")

#' Count labeled terms grouped by CURIE prefix
#'
#' @param x A \code{SemsqlConn} object.
#' @return data.frame with columns \code{prefix} and \code{n}, ordered by
#'   \code{n} descending.
#' @export
count_by_prefix <- new_generic("count_by_prefix", "x")

#' Run an arbitrary SQL query against a SemsqlConn database
#'
#' @param x A \code{SemsqlConn} object.
#' @param sql character(1) SQL query string.
#' @return data.frame with query results.
#' @export
run_query <- new_generic("run_query", "x")

#' Display a detailed report of a SemsqlConn object
#'
#' @description
#' Displays a verbose, formatted representation of a \code{SemsqlConn} object
#' including connection status, database statistics (labeled terms, edges,
#' definitions), prefix breakdown, and available key tables. More informative
#' than \code{print()}, intended for interactive exploration.
#'
#' @param object A \code{SemsqlConn} object.
#' @return The \code{SemsqlConn} object invisibly.
#' @export
report <- new_generic("report", "object")

#' Reconnect a SemsqlConn to its database
#'
#' @description
#' Attempts to reconnect a disconnected \code{SemsqlConn} object to its
#' database. Returns a new \code{SemsqlConn}; the original cannot be modified
#' in place due to S7 value semantics.
#'
#' @param x A \code{SemsqlConn} object.
#' @return A new \code{SemsqlConn} object with an active connection.
#' @export
reconnect <- new_generic("reconnect", "x")

# =============================================================================
# CONNECTION MANAGEMENT METHODS
# =============================================================================

method(disconnect, SemsqlConn) <- function(x, quiet = FALSE) {
  if (dbIsValid(x@con)) {
    db_name <- basename(x@db_path)
    dbDisconnect(x@con)
    if (!quiet) message("Disconnected from '", db_name, "'")
  } else {
    if (!quiet) message("Connection already closed")
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

method(get_prefix, SemsqlConn) <- function(x) {
  x@ontology_prefix
}

method(run_query, SemsqlConn) <- function(x, sql) {
  dbGetQuery(x@con, sql)
}

method(reconnect, SemsqlConn) <- function(x) {
  if (is_connected(x)) {
    message("Already connected")
    return(x)
  }
  if (!file.exists(x@db_path)) {
    stop("Database file no longer exists: ", x@db_path)
  }
  semsql_connect(x@db_path, x@ontology_prefix)
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

method(get_synonyms, SemsqlConn) <- function(x, term_id,
    type = c("all", "exact", "broad", "narrow", "related")) {
  type <- match.arg(type)
  view_name <- switch(type,
    all      = "has_oio_synonym_statement",
    exact    = "has_exact_synonym_statement",
    broad    = "has_broad_synonym_statement",
    narrow   = "has_narrow_synonym_statement",
    related  = "has_related_synonym_statement"
  )
  query <- sprintf("
    SELECT subject, predicate, value AS synonym
    FROM %s
    WHERE subject = '%s'
  ", view_name, term_id)
  dbGetQuery(x@con, query)
}

method(get_term_info, SemsqlConn) <- function(x, term_id) {
  list(
    id          = term_id,
    label       = get_label(x, term_id),
    definition  = get_definition(x, term_id),
    synonyms    = get_synonyms(x, term_id),
    superclasses = get_direct_superclasses(x, term_id),
    subclasses  = get_direct_subclasses(x, term_id)
  )
}

# =============================================================================
# EDGE QUERY METHODS
# =============================================================================

method(get_direct_edges, SemsqlConn) <- function(x, term_id,
    direction = c("outgoing", "incoming", "both")) {
  direction <- match.arg(direction)
  where_clause <- switch(direction,
    outgoing = sprintf("e.subject = '%s'", term_id),
    incoming = sprintf("e.object = '%s'", term_id),
    both     = sprintf("e.subject = '%s' OR e.object = '%s'", term_id, term_id)
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
    predicates = "rdfs:subClassOf", include_self = FALSE) {
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
  if (!include_self && nrow(result) > 0) {
    result <- result[result$id != term_id, , drop = FALSE]
  }
  result
}

method(get_descendants, SemsqlConn) <- function(x, term_id,
    predicates = "rdfs:subClassOf", include_self = FALSE) {
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
    relation_property, related_to_id) {
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
  dbGetQuery(x@con, query)$n[1]
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
# PRINT / REPORT METHODS
# =============================================================================

#' setup print
#' @name print
#' @rdname print
#' @export
new_generic("print", "x")

#' Show method for SemsqlConn.
#' Concise one-line summary displayed when a \code{SemsqlConn} object is
#' auto-printed at the R prompt.
#' @name print
#' @rdname print
#' @param x A \code{SemsqlConn} object.
#' @export
S7::method(print, SemsqlConn) <- function(x) {
  if (!is_connected(x))
    stop("SemsqlConn object is disconnected; reconnect with semsql_connect()")
  n_labels <- dbGetQuery(x@con,
    "SELECT COUNT(*) AS n FROM rdfs_label_statement")$n
  cat("<SemsqlConn>",
      " prefix:", x@ontology_prefix,
      " | labeled terms:", format(n_labels, big.mark = ","),
      "\n")
  invisible(x)
}


#' longer display
#' @name report
#' @rdname report
#' @export
S7::method(report, SemsqlConn) <- function(object) {
  cat("\n")
  cat(strrep("=", 60), "\n")
  cat("SemsqlConn Object\n")
  cat(strrep("=", 60), "\n\n")

  cat("Connection Details:\n")
  cat(strrep("-", 40), "\n")
  cat("  Database path:   ", object@db_path, "\n")
  cat("  Ontology prefix: ", object@ontology_prefix, "\n")

  connected <- is_connected(object)
  status_symbol <- if (connected) "\u2713" else "\u2717"
  status_text   <- if (connected) "Connected" else "Disconnected"
  cat("  Status:          ", status_symbol, " ", status_text, "\n\n")

  if (!connected) {
    cat("(Connection closed - no further details available)\n\n")
    return(invisible(object))
  }

  cat("Database Statistics:\n")
  cat(strrep("-", 40), "\n")
  tryCatch({
    n <- dbGetQuery(object@con, "SELECT COUNT(*) AS n FROM rdfs_label_statement")$n
    cat("  Labeled terms:   ", format(n, big.mark = ","), "\n")
  }, error = function(e) cat("  Labeled terms:    (unavailable)\n"))
  tryCatch({
    n <- dbGetQuery(object@con, "SELECT COUNT(*) AS n FROM edge")$n
    cat("  Direct edges:    ", format(n, big.mark = ","), "\n")
  }, error = function(e) cat("  Direct edges:     (unavailable)\n"))
  tryCatch({
    n <- dbGetQuery(object@con, "SELECT COUNT(*) AS n FROM entailed_edge")$n
    cat("  Entailed edges:  ", format(n, big.mark = ","), "\n")
  }, error = function(e) cat("  Entailed edges:   (unavailable)\n"))
  tryCatch({
    n <- dbGetQuery(object@con,
      "SELECT COUNT(*) AS n FROM has_text_definition_statement")$n
    cat("  Definitions:     ", format(n, big.mark = ","), "\n")
  }, error = function(e) cat("  Definitions:      (unavailable)\n"))

  cat("\n")
  cat("Terms by Prefix (top 5):\n")
  cat(strrep("-", 40), "\n")
  tryCatch({
    top <- head(count_by_prefix(object), 5)
    for (i in seq_len(nrow(top)))
      cat(sprintf("  %-16s %s\n",
                  paste0(top$prefix[i], ":"),
                  format(top$n[i], big.mark = ",")))
  }, error = function(e) cat("  (unavailable)\n"))

  cat("\n")
  cat("Key Tables Available:\n")
  cat(strrep("-", 40), "\n")
  key_tables <- c(
    "rdfs_label_statement",
    "has_text_definition_statement",
    "edge",
    "entailed_edge",
    "rdfs_subclass_of_statement",
    "owl_some_values_from",
    "has_oio_synonym_statement"
  )
  all_tables <- list_tables(object)
  for (tbl in key_tables) {
    sym <- if (tbl %in% all_tables) "\u2713" else "\u2717"
    cat(" ", sym, "", tbl, "\n")
  }

  cat("\n")
  cat(strrep("=", 60), "\n")
  cat("Use methods like search_labels(), get_ancestors(), etc.\n")
  cat("Run ?SemsqlConn for documentation.\n")
  cat(strrep("=", 60), "\n\n")
  invisible(object)
}

# =============================================================================
# CONVENIENCE FUNCTIONS
# =============================================================================

#' Standard predicate CURIEs used in OBO ontologies
#'
#' @description
#' A named list of commonly used predicate CURIEs in OBO-format ontologies,
#' for use with \code{\link{get_ancestors}}, \code{\link{get_descendants}},
#' and related functions.
#'
#' @format A named list with elements \code{subclass_of}, \code{part_of},
#'   \code{has_part}, \code{develops_from}, \code{located_in},
#'   \code{has_characteristic}.
#' @examples
#' # Connect to the Cell Ontology and retrieve ancestors using part-of edges
#' conn <- semsql_connect(ontology = "cl")
#' # neuron (CL:0000540) ancestors via is-a and part-of
#' anc <- get_ancestors(conn, "CL:0000540",
#'   predicates = c(PREDICATES$subclass_of, PREDICATES$part_of))
#' head(anc)
#' disconnect(conn)
#' @export
PREDICATES <- list(
  subclass_of      = "rdfs:subClassOf",
  part_of          = "BFO:0000050",
  has_part         = "BFO:0000051",
  develops_from    = "RO:0002202",
  located_in       = "RO:0001025",
  has_characteristic = "RO:0000053"
)

#' Get ancestors traversing both is-a and part-of relationships
#'
#' @description
#' Convenience wrapper around \code{\link{get_ancestors}} that follows both
#' \code{rdfs:subClassOf} and \code{BFO:0000050} (part-of) edges.
#'
#' @param conn A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param include_self logical(1) whether to include the term itself
#'   (default \code{FALSE}).
#' @return data.frame with columns \code{id}, \code{label}, \code{predicate}.
#' @export
get_ancestors_partonomy <- function(conn, term_id, include_self = FALSE) {
  get_ancestors(conn, term_id,
                predicates = c(PREDICATES$subclass_of, PREDICATES$part_of),
                include_self = include_self)
}

#' Get descendants traversing both is-a and has-part relationships
#'
#' @description
#' Convenience wrapper around \code{\link{get_descendants}} that follows both
#' \code{rdfs:subClassOf} and \code{BFO:0000051} (has-part) edges.
#'
#' @param conn A \code{SemsqlConn} object.
#' @param term_id character(1) CURIE.
#' @param include_self logical(1) whether to include the term itself
#'   (default \code{FALSE}).
#' @return data.frame with columns \code{id}, \code{label}, \code{predicate}.
#' @export
get_descendants_partonomy <- function(conn, term_id, include_self = FALSE) {
  get_descendants(conn, term_id,
                  predicates = c(PREDICATES$subclass_of, PREDICATES$has_part),
                  include_self = include_self)
}

#' Execute code with an automatically managed SemsqlConn
#'
#' @description
#' Opens a connection, evaluates an expression with \code{conn} bound to the
#' open \code{SemsqlConn}, then closes the connection even if an error occurs.
#' Analogous to Python's context manager (\code{with} statement).
#'
#' @param db_path character(1) path to the SQLite database.
#' @param expr an expression to evaluate; \code{conn} is bound to the open
#'   \code{SemsqlConn} within this expression.
#' @return the value of \code{expr}.
#' @examples
#' \dontrun{
#' result <- with_connection("cl.db", {
#'   get_ancestors(conn, "CL:0000540")
#' })
#' }
#' @export
with_connection <- function(db_path, expr) {
  conn <- semsql_connect(db_path)
  on.exit(disconnect(conn, quiet = TRUE), add = TRUE)
  env <- new.env(parent = parent.frame())
  env$conn <- conn
  eval(substitute(expr), envir = env)
}

#' Run a demonstration of SemsqlConn capabilities
#'
#' @description
#' Runs a series of example queries against a \code{SemsqlConn} object using
#' the Cell Ontology neuron term (\code{CL:0000540}) as the example. Useful
#' for verifying a new connection is working correctly.
#'
#' @param conn A \code{SemsqlConn} object.
#' @return NULL invisibly, called for its side effects.
#' @examples
#' \dontrun{
#' conn <- semsql_connect(ontology = "cl")
#' run_demo(conn)
#' disconnect(conn)
#' }
#' @export
run_demo <- function(conn) {
  stopifnot(inherits(conn, "SemsqlConn"))

  cat("\n", strrep("=", 50), "\n", sep = "")
  cat("SemsqlConn Demo\n")
  cat(strrep("=", 50), "\n\n")

  cat("1. Searching for terms containing 'neuron':\n")
  neurons <- search_labels(conn, "neuron", limit = 5L)
  print(neurons)

  cat("\n", strrep("-", 40), "\n\n")

  cat("2. Term info for 'neuron' (CL:0000540):\n")
  info <- get_term_info(conn, "CL:0000540")
  cat("   Label:", info$label, "\n")
  cat("   Definition:", substr(info$definition, 1, 100), "...\n")

  cat("\n", strrep("-", 40), "\n\n")

  cat("3. Direct superclasses of neuron:\n")
  print(info$superclasses)

  cat("\n", strrep("-", 40), "\n\n")

  cat("4. All ancestors of neuron:\n")
  ancestors <- get_ancestors(conn, "CL:0000540")
  print(head(ancestors, 10))
  cat("   ... (", nrow(ancestors), " total ancestors)\n")

  cat("\n", strrep("-", 40), "\n\n")

  cat("5. Counting descendants:\n")
  n <- count_descendants(conn, "CL:0000540")
  cat("   Neuron has", n, "descendant cell types\n")

  cat("\n", strrep("=", 50), "\n")
  cat("Demo complete!\n")
  cat(strrep("=", 50), "\n")
  invisible(NULL)
}
