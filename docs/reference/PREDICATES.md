<div id="main" class="col-md-9" role="main">

# Standard predicate CURIEs used in OBO ontologies

<div class="ref-description section level2">

A named list of commonly used predicate CURIEs in OBO-format ontologies,
for use with `get_ancestors`, `get_descendants`, and related functions.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
PREDICATES
```

</div>

</div>

<div class="section level2">

## Format

A named list with elements `subclass_of`, `part_of`, `has_part`,
`develops_from`, `located_in`, `has_characteristic`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
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
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
