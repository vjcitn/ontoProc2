<div id="main" class="col-md-9" role="main">

# Get direct superclasses of a term

<div class="ref-description section level2">

Get direct superclasses of a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_direct_superclasses(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

</div>

<div class="section level2">

## Value

data.frame with columns `id` and `label`, ordered by label.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_direct_superclasses(goref, "GO:0006915")
#>           id                 label
#> 1 GO:0012501 programmed cell death
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
