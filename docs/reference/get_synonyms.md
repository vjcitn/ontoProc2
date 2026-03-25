<div id="main" class="col-md-9" role="main">

# Get synonyms for a term

<div class="ref-description section level2">

Get synonyms for a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_synonyms(x, ...)
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
#> [1] subject   predicate synonym  
#> <0 rows> (or 0-length row.names)
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
