# Run an arbitrary SQL query against a SemsqlConn database

Run an arbitrary SQL query against a SemsqlConn database

## Usage

``` r
run_query(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- sql:

  character(1) SQL query string.

## Value

data.frame with query results.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
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
#> Disconnected from 'b24227f056f7_go.db'
```
