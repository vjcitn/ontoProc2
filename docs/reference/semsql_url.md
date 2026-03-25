<div id="main" class="col-md-9" role="main">

# produce INCAtools distribution URL

<div class="ref-description section level2">

produce INCAtools distribution URL

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
semsql_url(ontology = "efo")
```

</div>

</div>

<div class="section level2">

## Arguments

-   ontology:

    short string that is the prefix to .db.gz in the bbop-sqlite
    collection

</div>

<div class="section level2">

## Value

a string with URL for INCAtools resource

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
semsql_url("cl")
#> [1] "https://s3.amazonaws.com/bbop-sqlite/cl.db.gz"
```

</div>

</div>

</div>
