<div id="main" class="col-md-9" role="main">

# Get the text definition for a term

<div class="ref-description section level2">

Get the text definition for a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_definition(x, ...)
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

character(1) definition text, or `NA_character_` if not found.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_definition(goref, "GO:0006915")
#> [1] "A programmed cell death process which begins when a cell receives an internal (e.g. DNA damage) or external signal (e.g. an extracellular death ligand), and proceeds through a series of biochemical events (signaling pathway phase) which trigger an execution phase. The execution phase is the last step of an apoptotic process, and is typically characterized by rounding-up of the cell, retraction of pseudopodes, reduction of cellular volume (pyknosis), chromatin condensation, nuclear fragmentation (karyorrhexis), plasma membrane blebbing and fragmentation of the cell into apoptotic bodies. When the execution phase is completed, the cell has died."
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
