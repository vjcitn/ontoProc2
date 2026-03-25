<div id="main" class="col-md-9" role="main">

# Reconnect a SemsqlConn to its database

<div class="ref-description section level2">

Attempts to reconnect a disconnected `SemsqlConn` object to its
database. Returns a new `SemsqlConn`; the original cannot be modified in
place due to S7 value semantics.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
reconnect(x, ...)
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

A new `SemsqlConn` object with an active connection.

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
goref <- reconnect(goref)
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
