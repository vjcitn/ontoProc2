`%||%` <- function(a, b) if (!is.null(a) && nzchar(a)) a else b

#' retrieve and cache all filenames of Semantic SQL ontologies available, checking for updated
#' content relative to cache via ETag
#' @param url source address
#' @param bfc an instance of BiocFileCache
#' @param rname a string to use to identify the cached listing
#' @param timeout_connect passed to httr2::req_options connecttimeout parameter
#' @param timeout_total passed to httr2::req_options seconds parameter
#' @note There is no real etag discipline for the metadata, so full metadata
#' content is extracted on each call, digested, and compared to digest in cache.
#' Cache is updated when there is a discrepancy, except there is a guard against
#' rewriting cache with corrupted or zero-length data at endpoint.  Note this
#' code was negotiated at length with claude.ai Sonnet 4.6.
#' @examples
#' gzs = bbop_sqlite_db_gz()
#' head(gzs)
#' length(gzs)
#' @export
bbop_sqlite_db_gz <- function(
    url             = "https://s3.amazonaws.com/bbop-sqlite",
    bfc             = BiocFileCache::BiocFileCache(),
    rname           = "bbop_sqlite_listing",
    timeout_connect = 5,
    timeout_total   = 15) {

  # --- 1. Check cache --------------------------------------------------------
  hits       <- BiocFileCache::bfcquery(bfc, rname, field = "rname", exact = TRUE)
  have_cache <- nrow(hits) == 1L

  # --- 2. Try to fetch fresh listing -----------------------------------------
  xml_text     <- NULL
  current_hash <- NULL

  xml_text <- tryCatch({
    message("Fetching bucket listing...")
    txt <- httr2::request(url) |>
      httr2::req_options(connecttimeout = timeout_connect) |>
      httr2::req_timeout(seconds = timeout_total) |>
      httr2::req_perform() |>
      httr2::resp_body_string()
    current_hash <- digest::digest(txt, algo = "md5")
    txt
  }, error = function(e) {
    if (have_cache) {
      message("Could not reach ", url, "; using cached listing.")
      NULL
    } else {
      stop("Could not reach ", url, " and no cached listing exists. ",
           "Connect to the internet and retry.", call. = FALSE)
    }
  })

  # --- 3. Validate, compare hash, update cache only if safe ------------------
  if (!is.null(xml_text)) {

    # Parse and validate new content before touching anything
    new_keys <- tryCatch({
      doc <- xml2::read_xml(xml_text)
      ns  <- xml2::xml_ns(doc)
      tryCatch(
        xml2::xml_text(xml2::xml_find_all(doc, "//d1:Key", ns)),
        error = function(e)
          xml2::xml_text(xml2::xml_find_all(doc, "//*[local-name()='Key']"))
      )
    }, error = function(e) character(0))

    if (length(new_keys) == 0L) {
      warning("Freshly fetched listing contains no keys; ",
              if (have_cache) "retaining existing cache." else "nothing to cache.")
      if (!have_cache) return(character(0))
      # fall through to parse from existing cache below
      xml_text <- NULL

    } else {
      # Good content confirmed; now decide whether cache needs updating
      needs_update <- TRUE

      if (have_cache) {
        cached_path <- BiocFileCache::bfcrpath(bfc, rname)
        hash_path   <- paste0(cached_path, ".hash")

        if (file.exists(hash_path)) {
          cached_hash <- readLines(hash_path, warn = FALSE)
          if (length(cached_hash) == 1L && cached_hash == current_hash) {
            message("Content hash matches; using cached listing.")
            needs_update <- FALSE
          } else {
            message("Content changed (", length(new_keys), " keys found); ",
                    "updating cache.")
            file.remove(hash_path)
            BiocFileCache::bfcremove(bfc, hits$rid)
          }
        } else {
          message("No hash sidecar; updating cache.")
          BiocFileCache::bfcremove(bfc, hits$rid)
        }
      }

      if (needs_update) {
        cached_path <- BiocFileCache::bfcnew(bfc, rname, ext = ".xml")
        writeLines(xml_text, cached_path)
        writeLines(current_hash, paste0(cached_path, ".hash"))
        message("Cached with hash: ", current_hash)
      }
    }
  }

  # --- 4. Parse from cache and filter ----------------------------------------
  cached_path <- BiocFileCache::bfcrpath(bfc, rname)
  doc  <- xml2::read_xml(paste(readLines(cached_path, warn = FALSE), collapse = "\n"))
  ns   <- xml2::xml_ns(doc)

  keys <- tryCatch(
    xml2::xml_text(xml2::xml_find_all(doc, "//d1:Key", ns)),
    error = function(e)
      xml2::xml_text(xml2::xml_find_all(doc, "//*[local-name()='Key']"))
  )

  keys[grepl("\\.db\\.gz$", keys)]
}

