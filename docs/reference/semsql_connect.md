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
    `"cl"`, `"go"`). If supplied, `retrieve_semsql_conn` is called to
    locate or download the cached database.

-   cache:

    a `BiocFileCache` instance used when `ontology` is supplied.
    Defaults to `BiocFileCache::BiocFileCache()`.

-   ...:

    passed to `retrieve_semsql_conn` and ultimately to `download.file`.

</div>

<div class="section level2">

## Value

A `SemsqlConn` object.

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
