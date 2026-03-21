# Search term labels in a SemsqlConn database

Search term labels in a SemsqlConn database

## Usage

``` r
search_labels(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- pattern:

  character(1) substring to match against rdfs:label values (SQL LIKE
  pattern, case-insensitive on most SQLite builds).

- limit:

  integer(1) maximum number of rows to return (default 20).

## Value

data.frame with columns `subject` and `label`.

## Examples

``` r
if (FALSE) { # \dontrun{
conn <- semsql_connect(ontology = "cl")
search_labels(conn, "neuron")
disconnect(conn)
} # }
```
