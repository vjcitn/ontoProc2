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
  validate = TRUE,
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
  [`retrieve_semsql_conn()`](https://github.com/vjcitn/ontoProc2/reference/retrieve_semsql_conn.md)
  is called to locate or download the cached database.

- cache:

  a `BiocFileCache` instance used when `ontology` is supplied. Defaults
  to
  [`BiocFileCache::BiocFileCache()`](https://rdrr.io/pkg/BiocFileCache/man/BiocFileCache-class.html).

- validate:

  logical(1) if TRUE (the default value) the ontology code is checked
  against available Semantic SQL resources at INCAtools. Set to FALSE if
  using off line.

- ...:

  passed to
  [`retrieve_semsql_conn()`](https://github.com/vjcitn/ontoProc2/reference/retrieve_semsql_conn.md)
  and ultimately to
  [`utils::download.file()`](https://rdrr.io/r/utils/download.file.html).

## Value

A
[`SemsqlConn()`](https://github.com/vjcitn/ontoProc2/reference/SemsqlConn.md)
object.

## Note

The connection has flag `SQLITE_RO` for read-only access. There will be
an attempt to validate the `ontology` tag that is supplied, against all
available Semantic SQL resources available at INCAtools bucket. Function
fails if a match cannot be made, which in general requires network
access.

## Examples

``` r
# by ontology short name (downloads if not cached)
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/19c5d28c62_go.db
#> Primary ontology prefix: GO
goref
#> <SemsqlConn>  prefix: GO  | labeled terms: 88,849 
disconnect(goref)
#> Disconnected from '19c5d28c62_go.db'
```
