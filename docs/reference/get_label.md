# Get the rdfs:label for a term

Get the rdfs:label for a term

## Usage

``` r
get_label(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE, e.g. `"GO:0006915"`.

## Value

character(1) label, or `NA_character_` if not found.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
get_label(goref, "GO:0006915")  # "apoptotic process"
#> [1] "apoptotic process"
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
