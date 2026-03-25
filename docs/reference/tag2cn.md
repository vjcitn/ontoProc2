<div id="main" class="col-md-9" role="main">

# a named vector with mapping from CURIE to cell type phrase for CL.owl of 2025-12-17

<div class="ref-description section level2">

a named vector with mapping from CURIE to cell type phrase for CL.owl of
2025-12-17

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
data(tag2cn)
```

</div>

</div>

<div class="section level2">

## Format

names character vector

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
data("tag2cn", package="ontoProc2")
tag2cn[c("CL:0000000", "CL:0000006")]
#>               CL:0000000               CL:0000006 
#>                   "cell" "neuronal receptor cell" 
```

</div>

</div>

</div>
