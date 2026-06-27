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
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/51f25f664001_go.db
#> Primary ontology prefix: GO
get_prefix(goref)
#> [1] "GO"
disconnect(goref)
#> Disconnected from '51f25f664001_go.db'
```
