# a named vector with mapping from CURIE to cell type phrase for CL.owl of 2025-12-17

a named vector with mapping from CURIE to cell type phrase for CL.owl of
2025-12-17

## Usage

``` r
data(tag2cn)
```

## Format

names character vector

## Examples

``` r
data("tag2cn", package = "ontoProc2")
tag2cn[c("CL:0000000", "CL:0000006")]
#>               CL:0000000               CL:0000006 
#>                   "cell" "neuronal receptor cell" 
```
