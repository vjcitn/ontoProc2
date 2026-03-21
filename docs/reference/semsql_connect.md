# Create a SemsqlConn connection

Opens a connection to a SemanticSQL SQLite database, either by supplying
a direct file path or by referencing a short ontology name that is
retrieved and cached via `BiocFileCache`.

## Usage

``` r
semsql_connect(
  db_path = NULL,
  ontology_prefix = NULL,
  ontology = NULL,
  cache = BiocFileCache::BiocFileCache(),
  ...
)
```

## Arguments

- db_path:

  character(1) or NULL. Path to an existing SQLite database file. Either
  `db_path` or `ontology` must be supplied.

- ontology_prefix:

  character(1) or NULL. Primary CURIE prefix for the ontology (e.g.
  `"CL"`). If NULL and `ontology` is supplied, defaults to
  `toupper(ontology)`; otherwise auto-detected from the database.

- ontology:

  character(1) or NULL. Short name of an INCAtools ontology (e.g.
  `"cl"`, `"go"`). If supplied,
  [`retrieve_semsql_conn`](https://github.com/vjcitn/ontoProc2/reference/retrieve_semsql_conn.md)
  is called to locate or download the cached database.

- cache:

  a `BiocFileCache` instance used when `ontology` is supplied. Defaults
  to
  [`BiocFileCache::BiocFileCache()`](https://rdrr.io/pkg/BiocFileCache/man/BiocFileCache-class.html).

- ...:

  passed to
  [`retrieve_semsql_conn`](https://github.com/vjcitn/ontoProc2/reference/retrieve_semsql_conn.md)
  and ultimately to
  [`download.file`](https://rdrr.io/r/utils/download.file.html).

## Value

A
[`SemsqlConn`](https://github.com/vjcitn/ontoProc2/reference/SemsqlConn.md)
object.

## Examples

``` r
if (FALSE) { # \dontrun{
# by ontology short name (downloads if not cached)
conn <- semsql_connect(ontology = "cl")

# by explicit path
conn <- semsql_connect(db_path = "/path/to/cl.db", ontology_prefix = "CL")
} # }
```
