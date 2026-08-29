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

## Note

creation is detailed in unexported function makeBundledMaps

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
data("ncit_map", package = "ontoProc2")
head(ncit_map)
#>                    IAO:0000115                        NCIT:A1 
#>                   "definition"              "Role_Has_Domain" 
#>                       NCIT:A10                       NCIT:A11 
#>              "Has_CDRH_Parent"             "Has_NICHD_Parent" 
#>                       NCIT:A12                       NCIT:A13 
#>             "Has_Data_Element" "Related_To_Genetic_Biomarker" 
```

</div>

</div>

</div>
