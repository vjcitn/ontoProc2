<div id="main" class="col-md-9" role="main">

# Retrieve a summary of information about a term

<div class="ref-description section level2">

Retrieve a summary of information about a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_term_info(x, ...)
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

list with elements `id`, `label`, `definition`, `synonyms`,
`superclasses`, `subclasses`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
info <- get_term_info(goref, "GO:0006915")
info$label
#> [1] "apoptotic process"
info$superclasses
#>           id                 label
#> 1 GO:0012501 programmed cell death
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
