<div id="main" class="col-md-9" role="main">

# Get OWL someValuesFrom restrictions for a term

<div class="ref-description section level2">

Get OWL someValuesFrom restrictions for a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_restrictions(x, ...)
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

data.frame with columns `restriction_id`, `property`, `property_label`,
`filler`, `filler_label`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
# mitochondrion (GO:0005739) has part-of restrictions to cell
get_restrictions(goref, "GO:0005739")
#>   restriction_id    property property_label         filler filler_label
#> 1 _:riog00106045 BFO:0000050        part of     GO:0005737    cytoplasm
#> 2 _:riog00106045 BFO:0000050        part of     GO:0005737    cytoplasm
#> 3 _:riog00106046  RO:0002162       in taxon NCBITaxon:2759    Eukaryota
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
