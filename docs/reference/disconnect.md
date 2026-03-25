<div id="main" class="col-md-9" role="main">

# Disconnect a SemsqlConn from its database

<div class="ref-description section level2">

Disconnect a SemsqlConn from its database

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
disconnect(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   quiet:

    logical(1) if TRUE suppresses the disconnection message (default
    FALSE).

</div>

<div class="section level2">

## Value

The `SemsqlConn` object invisibly.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
