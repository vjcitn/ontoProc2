# Describe the columns of a table in a SemsqlConn database

Describe the columns of a table in a SemsqlConn database

## Usage

``` r
describe_table(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- table_name:

  character(1) name of the table.

## Value

data.frame with PRAGMA table_info output (columns: cid, name, type,
notnull, dflt_value, pk).

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
describe_table(goref, "rdfs_label_statement")
#>   cid      name type notnull dflt_value pk
#> 1   0    stanza TEXT       0         NA  0
#> 2   1   subject TEXT       0         NA  0
#> 3   2 predicate TEXT       0         NA  0
#> 4   3    object TEXT       0         NA  0
#> 5   4     value TEXT       0         NA  0
#> 6   5  datatype TEXT       0         NA  0
#> 7   6  language TEXT       0         NA  0
#> 8   7     graph TEXT       0         NA  0
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
