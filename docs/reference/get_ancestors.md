# Get all ancestors of a term via entailed edges

Get all ancestors of a term via entailed edges

## Usage

``` r
get_ancestors(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- predicates:

  character vector of predicate CURIEs to follow. Defaults to
  `"rdfs:subClassOf"`. See
  [`PREDICATES`](https://github.com/vjcitn/ontoProc2/reference/PREDICATES.md)
  for common values.

- include_self:

  logical(1) whether to include the term itself (default `FALSE`).

## Value

data.frame with columns `id`, `label`, `predicate`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
get_ancestors(goref, "GO:0006915")
#>            id                 label       predicate
#> 2  GO:0008150    biological_process rdfs:subClassOf
#> 3  GO:0008219            cell death rdfs:subClassOf
#> 4  GO:0009987      cellular process rdfs:subClassOf
#> 5 BFO:0000003             occurrent rdfs:subClassOf
#> 6 BFO:0000015               process rdfs:subClassOf
#> 7  GO:0012501 programmed cell death rdfs:subClassOf
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
