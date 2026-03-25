<div id="main" class="col-md-9" role="main">

# a named vector with values rdfs labels in NCI thesaurus, and names the corresponding formal ontology tags

<div class="ref-description section level2">

a named vector with values rdfs labels in NCI thesaurus, and names the
corresponding formal ontology tags

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
data(ncit_map)
```

</div>

</div>

<div class="section level2">

## Format

named character vector

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
data("ncit_map", package="ontoProc2")
ncit_map["EFO:1000899"]
#>               EFO:1000899 
#> "diastolic heart failure" 
```

</div>

</div>

</div>
