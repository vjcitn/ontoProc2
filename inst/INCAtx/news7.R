#result <- with_connection("cl.db", {
#  get_ancestors(conn, "CL:0000540")
#})
# Connection automatically closed, even if an error occurred

# =============================================================================
# SemsqlConn S7 Methods - show and disconnect
# =============================================================================
# Supplementary methods for the SemsqlConn class.
# Source this file after loading semsql_s7.R
# =============================================================================

library(S7)

# =============================================================================
# SHOW METHOD
# =============================================================================

#' Show method for SemsqlConn
#' 
#' @description
#' Displays a detailed, informative representation of a SemsqlConn object,
#' including connection status, database statistics, and available tables.
#' This is more verbose than print() and intended for interactive exploration.

show <- new_generic("show", "object")

method(show, SemsqlConn) <- function(object) {
  # Header
cat("\n")
  cat(strrep("=", 60), "\n")
  cat("SemsqlConn Object\n")
  cat(strrep("=", 60), "\n\n")
  
# Connection info
  cat("Connection Details:\n")
  cat(strrep("-", 40), "\n")
  cat("  Database path:
", object@db_path, "\n")
  cat("  Ontology prefix: ", object@ontology_prefix, "\n")
  
  connected <- is_connected(object)
  status_symbol <- if (connected) "\u2713" else "\u2717"
  status_text <- if (connected) "Connected" else "Disconnected"
  cat("  Status:          ", status_symbol, " ", status_text, "\n\n")
  
  if (!connected) {
    cat("(Connection closed - no further details available)\n\n")
    return(invisible(object))
  }
  
  # Database statistics
  cat("Database Statistics:\n")
  cat(strrep("-", 40), "\n")
  
  # Count total terms with labels
  tryCatch({
    n_labels <- dbGetQuery(object@con, 
      "SELECT COUNT(*) AS n FROM rdfs_label_statement")$n
    cat("  Labeled terms:   ", format(n_labels, big.mark = ","), "\n")
  }, error = function(e) {
    cat("  Labeled terms:    (unavailable)\n")
  })
  
  # Count edges
  tryCatch({
    n_edges <- dbGetQuery(object@con, 
      "SELECT COUNT(*) AS n FROM edge")$n
    cat("  Direct edges:    ", format(n_edges, big.mark = ","), "\n")
  }, error = function(e) {
    cat("  Direct edges:     (unavailable)\n")
  })
  
  # Count entailed edges
  tryCatch({
    n_entailed <- dbGetQuery(object@con, 
      "SELECT COUNT(*) AS n FROM entailed_edge")$n
    cat("  Entailed edges:  ", format(n_entailed, big.mark = ","), "\n")
  }, error = function(e) {
    cat("  Entailed edges:   (unavailable)\n")
  })
  
  # Count definitions
  tryCatch({
    n_defs <- dbGetQuery(object@con, 
      "SELECT COUNT(*) AS n FROM has_text_definition_statement")$n
    cat("  Definitions:     ", format(n_defs, big.mark = ","), "\n")
  }, error = function(e) {
    cat("  Definitions:      (unavailable)\n")
  })
  
  cat("\n")
  
  # Prefix breakdown
  cat("Terms by Prefix (top 5):\n")
  cat(strrep("-", 40), "\n")
  tryCatch({
    prefixes <- count_by_prefix(object)
    top_prefixes <- head(prefixes, 5)
    for (i in seq_len(nrow(top_prefixes))) {
      cat(sprintf("  %-16s %s\n", 
                  paste0(top_prefixes$prefix[i], ":"),
                  format(top_prefixes$n[i], big.mark = ",")))
    }
  }, error = function(e) {
    cat("  (unavailable)\n")
  })
  
  cat("\n")
  
  # Key tables available
  cat("Key Tables Available:\n")
  cat(strrep("-", 40), "\n")
  
  key_tables <- c(
    "rdfs_label_statement",
    "has_text_definition_statement
",
    "edge",
    "entailed_edge",
    "rdfs_subclass_of_statement",
    "owl_some_values_from",
    "has_oio_synonym_statement"
  )
  
  all_tables <- list_tables(object)
  
  for (tbl in key_tables) {
    exists_symbol <- if (tbl %in% all_tables) "\u2713" else "\u2717"
    cat("
 ", exists_symbol, "", tbl, "\n")
  }
  
  cat("\n")
  cat(strrep("=", 60), "\n")
  cat("Use methods like search_labels(), get_ancestors(), etc.\n")
  cat("Run ?SemsqlConn for documentation.\n")
  cat(strrep("=", 60), "\n\n")
  
  invisible(object)
}

# =============================================================================
# DISCONNECT METHOD
# =============================================================================
#' Disconnect method for SemsqlConn
#' 
#' @description
#' Safely closes the database connection associated with a SemsqlConn object.
#' After disconnection, most methods will no longer work until a new
#' connection is established.
#' 
#' @param x A SemsqlConn object
#' @param quiet Logical; if TRUE, suppresses the disconnection message
#' @return The SemsqlConn object (invisibly), with closed connection
#' 
#' @details
#' This method checks if the connection is still valid before attempting
#' to disconnect. It is safe to call multiple times - subsequent calls
#' on an already-disconnected object will simply report that fact.
#' 
#' After disconnecting, the SemsqlConn object still exists but its
#' connection slot (@con) is no longer valid. To reconnect, create a
#' new SemsqlConn object with semsql_connect().

# Note: disconnect generic is already defined in main script
# We redefine the method here with additional features

method(disconnect, SemsqlConn) <- function(x, quiet = FALSE) {
  if (dbIsValid(x@con)) {
    # Get some info before disconnecting
    db_name <- basename(x@db_path)
    
    # Perform disconnection
    dbDisconnect(x@con)
    
    if (!quiet) {
      message("Disconnected from '", db_name, "'")
    }
  } else {
    if (!quiet) {
      message("Connection already closed")
    }
  }
  
  invisible(x)
}

# =============================================================================
# ADDITIONAL HELPER: reconnect
# =============================================================================

#' Reconnect to database
#' 
#' @description
#' Attempts to reconnect a disconnected SemsqlConn object to its database.
#' Returns a new SemsqlConn object (the original cannot be modified in place
#' due to S7's immutability).
#' 
#' @param x A SemsqlConn object
#' @return A new SemsqlConn object with an active connection

reconnect <- new_generic("reconnect", "x")

method(reconnect, SemsqlConn) <- function(x) {
  if (is_connected(x)) {
    message("Already connected")
    return(x)
  }
  
  if (!file.exists(x@db_path)) {
    stop("Database file no longer exists: ", x@db_path)
  }
  
  # Create new connection
  semsql_connect(x@db_path, x@ontology_prefix)
}

# =============================================================================
# CONTEXT MANAGER PATTERN: with_connection
# =============================================================================

#' Execute code with automatic disconnection
#' 
#' @description
#' A helper function that ensures the database connection is properly
#' closed after executing a block of code, even if an error occurs.
#' Similar to Python's context manager pattern.
#' 
#' @param db_path Path to the SQLite database
#' @param expr An expression to evaluate with the connection
#' @return The result of evaluating expr
#' 
#' @examples
#' \dontrun{
#' result <- with_connection("cl.db", {
#'   ancestors <- get_ancestors(conn, "CL:0000540")
#'   descendants <- get_descendants(conn, "CL:0000540")
#'   list(ancestors = ancestors, descendants = descendants)
#' })
#' }

with_connection <- function(db_path, expr) {
  conn <- semsql_connect(db_path)
  on.exit(disconnect(conn, quiet = TRUE), add = TRUE)
  
  # Make conn available in the expression's environment
  env <- new.env(parent = parent.frame())
  env$conn <- conn
  
  eval(substitute(expr), envir = env)
}

# =============================================================================
# MESSAGE ON LOAD
# =============================================================================

cat("SemsqlConn methods loaded: show(), disconnect(), reconnect()\n")
cat("Also available: with_connection() for automatic cleanup\n")

