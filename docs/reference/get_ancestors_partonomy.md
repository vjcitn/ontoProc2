# Get ancestors traversing both is-a and part-of relationships

Convenience wrapper around
[`get_ancestors`](https://github.com/vjcitn/ontoProc2/reference/get_ancestors.md)
that follows both `rdfs:subClassOf` and `BFO:0000050` (part-of) edges.

## Usage

``` r
get_ancestors_partonomy(conn, term_id, include_self = FALSE)
```

## Arguments

- conn:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- include_self:

  logical(1) whether to include the term itself (default `FALSE`).

## Value

data.frame with columns `id`, `label`, `predicate`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
get_ancestors_partonomy(goref, "GO:0005739")  # mitochondrion
#>                id                                    label       predicate
#> 1  UBERON:0001062                        anatomical entity     BFO:0000050
#> 2  UBERON:0001062                        anatomical entity rdfs:subClassOf
#> 3  UBERON:0000061                     anatomical structure     BFO:0000050
#> 4  UBERON:0000061                     anatomical structure rdfs:subClassOf
#> 5      CL:0000000                                     cell     BFO:0000050
#> 6      GO:0110165            cellular anatomical structure     BFO:0000050
#> 7      GO:0110165            cellular anatomical structure rdfs:subClassOf
#> 8      GO:0005575                       cellular_component     BFO:0000050
#> 9      GO:0005575                       cellular_component rdfs:subClassOf
#> 10    BFO:0000002                               continuant     BFO:0000050
#> 11    BFO:0000002                               continuant rdfs:subClassOf
#> 12     GO:0005737                                cytoplasm     BFO:0000050
#> 13    BFO:0000004                   independent continuant     BFO:0000050
#> 14    BFO:0000004                   independent continuant rdfs:subClassOf
#> 15     GO:0005622       intracellular anatomical structure     BFO:0000050
#> 16     GO:0043231 intracellular membrane-bounded organelle rdfs:subClassOf
#> 17     GO:0043229                  intracellular organelle rdfs:subClassOf
#> 18 UBERON:0000465               material anatomical entity     BFO:0000050
#> 19 UBERON:0000465               material anatomical entity rdfs:subClassOf
#> 20    BFO:0000040                          material entity     BFO:0000050
#> 21    BFO:0000040                          material entity rdfs:subClassOf
#> 22     GO:0043227               membrane-bounded organelle rdfs:subClassOf
#> 24     GO:0043226                                organelle rdfs:subClassOf
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
