<div id="main" class="col-md-9" role="main">

# Run an arbitrary SQL query against a SemsqlConn database

<div class="ref-description section level2">

Run an arbitrary SQL query against a SemsqlConn database

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
run_query(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   sql:

    character(1) SQL query string.

</div>

<div class="section level2">

## Value

data.frame with query results.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
run_query(goref,
  "SELECT subject, value AS label FROM rdfs_label_statement LIMIT 5")
#>       subject             label
#> 1 IAO:0000115        definition
#> 2 IAO:0000115        definition
#> 3 IAO:0000116       editor note
#> 4 IAO:0000233 term tracker item
#> 5 IAO:0000233 term tracker item
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
