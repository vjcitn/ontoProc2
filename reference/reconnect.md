# Reconnect a SemsqlConn to its database

Attempts to reconnect a disconnected `SemsqlConn` object to its
database. Returns a new `SemsqlConn`; the original cannot be modified in
place due to S7 value semantics.

## Usage

``` r
reconnect(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- ...:

  not used

## Value

A new `SemsqlConn` object with an active connection.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/19c72ffbcde9_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from '19c72ffbcde9_go.db'
goref <- reconnect(goref)
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/19c72ffbcde9_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from '19c72ffbcde9_go.db'
```
