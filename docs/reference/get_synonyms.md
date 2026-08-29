<div id="main" class="col-md-9" role="main">

# Get synonyms for a term

<div class="ref-description section level2">

Get synonyms for a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_synonyms(
  x,
  term_id,
  type = c("all", "exact", "broad", "narrow", "related"),
  ...
)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

-   type:

    character(1) synonym scope: one of `"all"`, `"exact"`, `"broad"`,
    `"narrow"`, `"related"`.

-   ...:

    not used

</div>

<div class="section level2">

## Value

data.frame with columns `subject`, `predicate`, `synonym`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_synonyms(goref, "GO:0006915")
#>       subject             predicate                                 synonym
#> 1  GO:0006915   oio:hasBroadSynonym                            cell suicide
#> 2  GO:0006915   oio:hasBroadSynonym                        cellular suicide
#> 3  GO:0006915   oio:hasExactSynonym                    apoptotic cell death
#> 4  GO:0006915   oio:hasExactSynonym         apoptotic programmed cell death
#> 5  GO:0006915   oio:hasExactSynonym      programmed cell death by apoptosis
#> 6  GO:0006915  oio:hasNarrowSynonym                 activation of apoptosis
#> 7  GO:0006915  oio:hasNarrowSynonym                               apoptosis
#> 8  GO:0006915  oio:hasNarrowSynonym                     apoptosis signaling
#> 9  GO:0006915  oio:hasNarrowSynonym                       apoptotic program
#> 10 GO:0006915  oio:hasNarrowSynonym            type I programmed cell death
#> 11 GO:0006915 oio:hasRelatedSynonym            apoptosis activator activity
#> 12 GO:0006915 oio:hasRelatedSynonym caspase-dependent programmed cell death
#> 13 GO:0006915 oio:hasRelatedSynonym                 commitment to apoptosis
#> 14 GO:0006915 oio:hasRelatedSynonym                  induction of apoptosis
#> 15 GO:0006915 oio:hasRelatedSynonym           induction of apoptosis by p53
#> 16 GO:0006915 oio:hasRelatedSynonym  signaling (initiator) caspase activity
get_synonyms(goref, "GO:0006915", type = "exact")
#>      subject           predicate                            synonym
#> 1 GO:0006915 oio:hasExactSynonym               apoptotic cell death
#> 2 GO:0006915 oio:hasExactSynonym    apoptotic programmed cell death
#> 3 GO:0006915 oio:hasExactSynonym programmed cell death by apoptosis
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
