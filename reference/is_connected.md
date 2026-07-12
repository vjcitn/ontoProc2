# Test whether a SemsqlConn has a valid open connection

Test whether a SemsqlConn has a valid open connection

## Usage

``` r
is_connected(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- ...:

  not used

## Value

logical(1).

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/52084dd590e8_go.db
#> Primary ontology prefix: GO
is_connected(goref) # TRUE
#> [1] TRUE
disconnect(goref)
#> Disconnected from '52084dd590e8_go.db'
is_connected(goref) # FALSE
#> [1] FALSE
```
