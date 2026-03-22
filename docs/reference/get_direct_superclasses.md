# Get direct superclasses of a term

Get direct superclasses of a term

## Usage

``` r
get_direct_superclasses(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

data.frame with columns `id` and `label`, ordered by label.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
get_direct_superclasses(goref, "GO:0006915")
#>           id                 label
#> 1 GO:0012501 programmed cell death
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
