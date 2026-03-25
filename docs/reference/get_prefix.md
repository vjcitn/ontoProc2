<div id="main" class="col-md-9" role="main">

# Retrieve the ontology prefix from a SemsqlConn

<div class="ref-description section level2">

Retrieve the ontology prefix from a SemsqlConn

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_prefix(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

</div>

<div class="section level2">

## Value

character(1) the primary ontology prefix (e.g. `"GO"`).

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_prefix(goref)
#> [1] "GO"
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
