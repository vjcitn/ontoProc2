# Retrieve a summary of information about a term

Retrieve a summary of information about a term

## Usage

``` r
get_term_info(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

list with elements `id`, `label`, `definition`, `synonyms`,
`superclasses`, `subclasses`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
info <- get_term_info(goref, "GO:0006915")
info$label
#> [1] "apoptotic process"
info$superclasses
#>           id                 label
#> 1 GO:0012501 programmed cell death
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
