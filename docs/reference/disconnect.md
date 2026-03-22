# Disconnect a SemsqlConn from its database

Disconnect a SemsqlConn from its database

## Usage

``` r
disconnect(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- quiet:

  logical(1) if TRUE suppresses the disconnection message (default
  FALSE).

## Value

The `SemsqlConn` object invisibly.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
