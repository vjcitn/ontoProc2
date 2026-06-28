# Count the number of descendants of a term

Count the number of descendants of a term

## Usage

``` r
count_descendants(x, term_id, predicate = "rdfs:subClassOf", ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- predicate:

  character(1) predicate to traverse (default `"rdfs:subClassOf"`).

- ...:

  not used

## Value

integer(1).

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/198344128ff6_go.db
#> Primary ontology prefix: GO
count_descendants(goref, "GO:0006915") # all apoptosis subtypes
#> [1] 72
disconnect(goref)
#> Disconnected from '198344128ff6_go.db'
```
