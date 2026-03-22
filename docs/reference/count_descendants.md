# Count the number of descendants of a term

Count the number of descendants of a term

## Usage

``` r
count_descendants(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- predicate:

  character(1) predicate to traverse (default `"rdfs:subClassOf"`).

## Value

integer(1).

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
count_descendants(goref, "GO:0006915")  # all apoptosis subtypes
#> [1] 72
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
