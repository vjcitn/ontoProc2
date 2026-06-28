# Retrieve the ontology prefix from a SemsqlConn

Retrieve the ontology prefix from a SemsqlConn

## Usage

``` r
get_prefix(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- ...:

  not used

## Value

character(1) the primary ontology prefix (e.g. `"GO"`).

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/1988cc470f_go.db
#> Primary ontology prefix: GO
get_prefix(goref)
#> [1] "GO"
disconnect(goref)
#> Disconnected from '1988cc470f_go.db'
```
