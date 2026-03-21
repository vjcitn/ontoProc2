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
# Connect to the Cell Ontology and retrieve ancestors using part-of edges
conn <- semsql_connect(ontology = "cl")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b242134f3ccd_cl.db
#> Primary ontology prefix: CL
# neuron (CL:0000540) ancestors via is-a and part-of
anc <- get_ancestors(conn, "CL:0000540",
  predicates = c(PREDICATES$subclass_of, PREDICATES$part_of))
head(anc)
#>               id             label       predicate
#> 1    BFO:0000002              <NA>     BFO:0000050
#> 2    BFO:0000004              <NA>     BFO:0000050
#> 3    BFO:0000040              <NA>     BFO:0000050
#> 4    BFO:0000004              <NA> rdfs:subClassOf
#> 5    BFO:0000040              <NA> rdfs:subClassOf
#> 6 UBERON:0001062 anatomical entity     BFO:0000050
disconnect(conn)
#> Disconnected from 'b242134f3ccd_cl.db'
```
