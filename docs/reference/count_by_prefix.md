# Count labeled terms grouped by CURIE prefix

Count labeled terms grouped by CURIE prefix

## Usage

``` r
count_by_prefix(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

## Value

data.frame with columns `prefix` and `n`, ordered by `n` descending.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
count_by_prefix(goref)
#>       prefix     n
#> 1         GO 48251
#> 2      CHEBI 23969
#> 3          _  7497
#> 4     UBERON  4783
#> 5         CL  1307
#> 6  NCBITaxon  1029
#> 7         PR   361
#> 8         PO   268
#> 9         RO   243
#> 10       OBA   151
#> 11        SO   137
#> 12       obo   111
#> 13    DDANAT    65
#> 14      ENVO    38
#> 15       FAO    33
#> 16      PATO    30
#> 17       oio    23
#> 18       BFO    23
#> 19       IAO    18
#> 20       OPL    13
#> 21       COB     5
#> 22       OBI     1
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
