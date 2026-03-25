<div id="main" class="col-md-9" role="main">

# Get all ancestors of a term via entailed edges

<div class="ref-description section level2">

Get all ancestors of a term via entailed edges

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_ancestors(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

-   predicates:

    character vector of predicate CURIEs to follow. Defaults to
    `"rdfs:subClassOf"`. See `PREDICATES` for common values.

-   include\_self:

    logical(1) whether to include the term itself (default `FALSE`).

</div>

<div class="section level2">

## Value

data.frame with columns `id`, `label`, `predicate`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
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
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
