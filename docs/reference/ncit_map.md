# a named vector with values rdfs labels in NCI thesaurus, and names the corresponding formal ontology tags

a named vector with values rdfs labels in NCI thesaurus, and names the
corresponding formal ontology tags

## Usage

``` r
data(ncit_map)
```

## Format

named character vector

## Examples

``` r
data("ncit_map", package="ontoProc2")
ncit_map["EFO:1000899"]
#>               EFO:1000899 
#> "diastolic heart failure" 
```
