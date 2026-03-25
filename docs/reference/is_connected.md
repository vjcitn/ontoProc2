<div id="main" class="col-md-9" role="main">

# Test whether a SemsqlConn has a valid open connection

<div class="ref-description section level2">

Test whether a SemsqlConn has a valid open connection

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
is_connected(x, ...)
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

logical(1).

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
is_connected(goref)   # TRUE
#> [1] TRUE
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
is_connected(goref)   # FALSE
#> [1] FALSE
```

</div>

</div>

</div>
