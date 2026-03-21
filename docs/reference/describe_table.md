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
