# produce INCAtools distribution URL

produce INCAtools distribution URL

## Usage

``` r
semsql_url(ontology = "efo")
```

## Arguments

- ontology:

  short string that is the prefix to .db.gz in the bbop-sqlite
  collection

## Value

a string with URL for INCAtools resource

## Examples

``` r
semsql_url("cl")
#> [1] "https://s3.amazonaws.com/bbop-sqlite/cl.db.gz"
```
