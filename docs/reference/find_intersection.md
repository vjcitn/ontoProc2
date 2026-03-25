<div id="main" class="col-md-9" role="main">

# Find terms that are descendants of a superclass and have a given restriction

<div class="ref-description section level2">

Find terms that are descendants of a superclass and have a given
restriction

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
find_intersection(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   superclass\_id:

    character(1) CURIE of the superclass.

-   relation\_property:

    character(1) property CURIE for the restriction.

-   related\_to\_id:

    character(1) filler CURIE for the restriction.

</div>

<div class="section level2">

## Value

data.frame with columns `id` and `label`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
# CC terms (GO:0005575) that are part_of nucleus (GO:0005634)
find_intersection(goref, "GO:0005575", "BFO:0000050", "GO:0005634")
#>            id                              label
#> 1  GO:1990469      Rhino-Deadlock-Cutoff Complex
#> 2  GO:0046818                 dense nuclear body
#> 3  GO:0035843                  endonuclear canal
#> 4  GO:0140510             mitotic nuclear bridge
#> 5  GO:0005635                   nuclear envelope
#> 6  GO:0042405             nuclear inclusion body
#> 7  GO:0031981                      nuclear lumen
#> 8  GO:0005880                nuclear microtubule
#> 9  GO:0140513 nuclear protein-containing complex
#> 10 GO:0110093               nucleus lagging edge
#> 11 GO:0110092               nucleus leading edge
#> 12 GO:0000943       retrotransposon nucleocapsid
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
