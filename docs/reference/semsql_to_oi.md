# produce an ontology_index instance from semantic sql sqlite connection

produce an ontology_index instance from semantic sql sqlite connection

## Usage

``` r
semsql_to_oi(con)
```

## Arguments

- con:

  DBI::dbConnect value for sqlite table

## Value

result of ontologyIndex::ontology_index evaluated for the labels and
parent-child relations in tables statements and edge of the semantic sql
resource

## Examples

``` r
if (FALSE) { # \dontrun{
conn <- semsql_connect(ontology = "aio")
oi <- suppressWarnings(semsql_to_oi(conn@con))
names(oi)
} # }
```
