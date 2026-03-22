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

## Value

A new `SemsqlConn` object with an active connection.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
goref <- reconnect(goref)
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
