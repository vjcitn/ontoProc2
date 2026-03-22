# Standard predicate CURIEs used in OBO ontologies

A named list of commonly used predicate CURIEs in OBO-format ontologies,
for use with
[`get_ancestors`](https://github.com/vjcitn/ontoProc2/reference/get_ancestors.md),
[`get_descendants`](https://github.com/vjcitn/ontoProc2/reference/get_descendants.md),
and related functions.

## Usage

``` r
PREDICATES
```

## Format

A named list with elements `subclass_of`, `part_of`, `has_part`,
`develops_from`, `located_in`, `has_characteristic`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
# apoptotic process (GO:0006915) ancestors via is-a and part-of
anc <- get_ancestors(goref, "GO:0006915",
  predicates = c(PREDICATES$subclass_of, PREDICATES$part_of))
head(anc)
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
