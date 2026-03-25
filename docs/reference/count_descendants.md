<div id="main" class="col-md-9" role="main">

# Count the number of descendants of a term

<div class="ref-description section level2">

Count the number of descendants of a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
count_descendants(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

-   predicate:

    character(1) predicate to traverse (default `"rdfs:subClassOf"`).

</div>

<div class="section level2">

## Value

integer(1).

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
count_descendants(goref, "GO:0006915")  # all apoptosis subtypes
#> [1] 72
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
