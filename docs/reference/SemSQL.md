# constructor for SemSQL instance

constructor for SemSQL instance

check aspects of SemSQL object

## Usage

``` r
SemSQL(conn, resource)
```

## Arguments

- conn:

  SQLiteConnection

- resource:

  character tag

## Value

SemSQL instance

## Examples

``` r
gg = retrieve_semsql_conn("go")
ngo = SemSQL(gg, "GO")
ngo
#> SemanticSQL interface for GO
#> There are 2801704 statements.
```
