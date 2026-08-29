<div id="main" class="col-md-9" role="main">

# Create a SemsqlConn connection

<div class="ref-description section level2">

Opens a connection to a SemanticSQL SQLite database, either by supplying
a direct file path or by referencing a short ontology name that is
retrieved and cached via `BiocFileCache`.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

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

</div>

</div>

<div class="section level2">

## Arguments

-   db\_path:

    character(1) or NULL. Path to an existing SQLite database file.
    Either `db_path` or `ontology` must be supplied.

-   ontology\_prefix:

    character(1) or NULL. Primary CURIE prefix for the ontology (e.g.
    `"CL"`). If NULL and `ontology` is supplied, defaults to
    `toupper(ontology)`; otherwise auto-detected from the database.

-   ontology:

    character(1) or NULL. Short name of an INCAtools ontology (e.g.
    `"cl"`, `"go"`). If supplied, `retrieve_semsql_conn()` is called to
    locate or download the cached database.

-   cache:

    a `BiocFileCache` instance used when `ontology` is supplied.
    Defaults to `BiocFileCache::BiocFileCache()`.

-   validate:

    logical(1) if TRUE (the default value) the ontology code is checked
    against available Semantic SQL resources at INCAtools. Set to FALSE
    if using off line.

-   ...:

    passed to `retrieve_semsql_conn()` and ultimately to
    `utils::download.file()`.

</div>

<div class="section level2">

## Value

A `SemsqlConn()` object.

</div>

<div class="section level2">

## Note

The connection has flag `SQLITE_RO` for read-only access. There will be
an attempt to validate the `ontology` tag that is supplied, against all
available Semantic SQL resources available at INCAtools bucket. Function
fails if a match cannot be made, which in general requires network
access.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
# by ontology short name (downloads if not cached)
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
goref
#> <SemsqlConn>  prefix: GO  | labeled terms: 88,356 
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
