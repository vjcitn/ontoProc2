# Get the rdfs:label for a term

Get the rdfs:label for a term

## Usage

``` r
get_label(x, term_id, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE, e.g. `"GO:0006915"`.

- ...:

  not used

## Value

character(1) label, or `NA_character_` if not found.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/51f25f664001_go.db
#> Primary ontology prefix: GO
get_label(goref, "GO:0006915") # "apoptotic process"
#>      subject             label
#> 1 GO:0006915 apoptotic process
disconnect(goref)
#> Disconnected from '51f25f664001_go.db'
```
