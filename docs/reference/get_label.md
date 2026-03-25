<div id="main" class="col-md-9" role="main">

# Get the rdfs:label for a term

<div class="ref-description section level2">

Get the rdfs:label for a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_label(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE, e.g. `"GO:0006915"`.

</div>

<div class="section level2">

## Value

character(1) label, or `NA_character_` if not found.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_label(goref, "GO:0006915")  # "apoptotic process"
#> [1] "apoptotic process"
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
