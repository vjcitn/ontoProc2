<div id="main" class="col-md-9" role="main">

# Get direct edges in the ontology graph for a term

<div class="ref-description section level2">

Get direct edges in the ontology graph for a term

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_direct_edges(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

-   direction:

    character(1) one of `"outgoing"`, `"incoming"`, `"both"`.

</div>

<div class="section level2">

## Value

data.frame with columns `subject`, `subject_label`, `predicate`,
`predicate_label`, `object`, `object_label`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_direct_edges(goref, "GO:0006915")
#>      subject     subject_label       predicate predicate_label          object
#> 1 GO:0006915 apoptotic process      RO:0002162        in taxon NCBITaxon:33154
#> 2 GO:0006915 apoptotic process      RO:0002224     starts with      GO:0097190
#> 3 GO:0006915 apoptotic process      RO:0002224     starts with      GO:0097190
#> 4 GO:0006915 apoptotic process      RO:0002230       ends with      GO:0097194
#> 5 GO:0006915 apoptotic process      RO:0002230       ends with      GO:0097194
#> 6 GO:0006915 apoptotic process rdfs:subClassOf            <NA>      GO:0012501
#>                   object_label
#> 1                 Opisthokonta
#> 2  apoptotic signaling pathway
#> 3  apoptotic signaling pathway
#> 4 execution phase of apoptosis
#> 5 execution phase of apoptosis
#> 6        programmed cell death
get_direct_edges(goref, "GO:0006915", direction = "both")
#>       subject                                                subject_label
#> 1  GO:0006915                                            apoptotic process
#> 2  GO:0006915                                            apoptotic process
#> 3  GO:0006915                                            apoptotic process
#> 4  GO:0006915                                            apoptotic process
#> 5  GO:0006915                                            apoptotic process
#> 6  GO:0006915                                            apoptotic process
#> 7  GO:0006925                          inflammatory cell apoptotic process
#> 8  GO:0008637                              apoptotic mitochondrial changes
#> 9  GO:0008637                              apoptotic mitochondrial changes
#> 10 GO:0010657                                muscle cell apoptotic process
#> 11 GO:0016505   peptidase activator activity involved in apoptotic process
#> 12 GO:0016505   peptidase activator activity involved in apoptotic process
#> 13 GO:0033028                               myeloid cell apoptotic process
#> 14 GO:0033668              symbiont-mediated suppression of host apoptosis
#> 15 GO:0033668              symbiont-mediated suppression of host apoptosis
#> 16 GO:0034349                                 glial cell apoptotic process
#> 17 GO:0042981                              regulation of apoptotic process
#> 18 GO:0042981                              regulation of apoptotic process
#> 19 GO:0043065                     positive regulation of apoptotic process
#> 20 GO:0043065                     positive regulation of apoptotic process
#> 21 GO:0043066                     negative regulation of apoptotic process
#> 22 GO:0043066                     negative regulation of apoptotic process
#> 23 GO:0043276                                                      anoikis
#> 24 GO:0044346                                 fibroblast apoptotic process
#> 25 GO:0051402                                     neuron apoptotic process
#> 26 GO:0052150             symbiont-mediated perturbation of host apoptosis
#> 27 GO:0052151               symbiont-mediated activation of host apoptosis
#> 28 GO:0052151               symbiont-mediated activation of host apoptosis
#> 29 GO:0071839                        apoptotic process in bone marrow cell
#> 30 GO:0071887                                  leukocyte apoptotic process
#> 31 GO:0072577                           endothelial cell apoptotic process
#> 32 GO:0097152                           mesenchymal cell apoptotic process
#> 33 GO:0097190                                  apoptotic signaling pathway
#> 34 GO:0097190                                  apoptotic signaling pathway
#> 35 GO:0097194                                 execution phase of apoptosis
#> 36 GO:0097194                                 execution phase of apoptosis
#> 37 GO:0140208 apoptotic process in response to mitochondrial fragmentation
#> 38 GO:1902362                                 melanocyte apoptotic process
#> 39 GO:1902489                                hepatoblast apoptotic process
#> 40 GO:1902742                    apoptotic process involved in development
#> 41 GO:1904019                            epithelial cell apoptotic process
#> 42 GO:1904516                         myofibroblast cell apoptotic process
#> 43 GO:1904606                                   fat cell apoptotic process
#> 44 GO:1990009                               retinal cell apoptotic process
#>          predicate                          predicate_label          object
#> 1       RO:0002162                                 in taxon NCBITaxon:33154
#> 2       RO:0002224                              starts with      GO:0097190
#> 3       RO:0002224                              starts with      GO:0097190
#> 4       RO:0002230                                ends with      GO:0097194
#> 5       RO:0002230                                ends with      GO:0097194
#> 6  rdfs:subClassOf                                     <NA>      GO:0012501
#> 7  rdfs:subClassOf                                     <NA>      GO:0006915
#> 8      BFO:0000050                                  part of      GO:0006915
#> 9      BFO:0000050                                  part of      GO:0006915
#> 10 rdfs:subClassOf                                     <NA>      GO:0006915
#> 11     BFO:0000050                                  part of      GO:0006915
#> 12     BFO:0000050                                  part of      GO:0006915
#> 13 rdfs:subClassOf                                     <NA>      GO:0006915
#> 14      RO:0012014 negatively regulates in another organism      GO:0006915
#> 15      RO:0012014 negatively regulates in another organism      GO:0006915
#> 16 rdfs:subClassOf                                     <NA>      GO:0006915
#> 17      RO:0002211                                regulates      GO:0006915
#> 18      RO:0002211                                regulates      GO:0006915
#> 19      RO:0002213                     positively regulates      GO:0006915
#> 20      RO:0002213                     positively regulates      GO:0006915
#> 21      RO:0002212                     negatively regulates      GO:0006915
#> 22      RO:0002212                     negatively regulates      GO:0006915
#> 23 rdfs:subClassOf                                     <NA>      GO:0006915
#> 24 rdfs:subClassOf                                     <NA>      GO:0006915
#> 25 rdfs:subClassOf                                     <NA>      GO:0006915
#> 26      RO:0002010            regulates in another organism      GO:0006915
#> 27      RO:0012013 positively regulates in another organism      GO:0006915
#> 28      RO:0012013 positively regulates in another organism      GO:0006915
#> 29 rdfs:subClassOf                                     <NA>      GO:0006915
#> 30 rdfs:subClassOf                                     <NA>      GO:0006915
#> 31 rdfs:subClassOf                                     <NA>      GO:0006915
#> 32 rdfs:subClassOf                                     <NA>      GO:0006915
#> 33     BFO:0000050                                  part of      GO:0006915
#> 34     BFO:0000050                                  part of      GO:0006915
#> 35     BFO:0000050                                  part of      GO:0006915
#> 36     BFO:0000050                                  part of      GO:0006915
#> 37 rdfs:subClassOf                                     <NA>      GO:0006915
#> 38 rdfs:subClassOf                                     <NA>      GO:0006915
#> 39 rdfs:subClassOf                                     <NA>      GO:0006915
#> 40 rdfs:subClassOf                                     <NA>      GO:0006915
#> 41 rdfs:subClassOf                                     <NA>      GO:0006915
#> 42 rdfs:subClassOf                                     <NA>      GO:0006915
#> 43 rdfs:subClassOf                                     <NA>      GO:0006915
#> 44 rdfs:subClassOf                                     <NA>      GO:0006915
#>                    object_label
#> 1                  Opisthokonta
#> 2   apoptotic signaling pathway
#> 3   apoptotic signaling pathway
#> 4  execution phase of apoptosis
#> 5  execution phase of apoptosis
#> 6         programmed cell death
#> 7             apoptotic process
#> 8             apoptotic process
#> 9             apoptotic process
#> 10            apoptotic process
#> 11            apoptotic process
#> 12            apoptotic process
#> 13            apoptotic process
#> 14            apoptotic process
#> 15            apoptotic process
#> 16            apoptotic process
#> 17            apoptotic process
#> 18            apoptotic process
#> 19            apoptotic process
#> 20            apoptotic process
#> 21            apoptotic process
#> 22            apoptotic process
#> 23            apoptotic process
#> 24            apoptotic process
#> 25            apoptotic process
#> 26            apoptotic process
#> 27            apoptotic process
#> 28            apoptotic process
#> 29            apoptotic process
#> 30            apoptotic process
#> 31            apoptotic process
#> 32            apoptotic process
#> 33            apoptotic process
#> 34            apoptotic process
#> 35            apoptotic process
#> 36            apoptotic process
#> 37            apoptotic process
#> 38            apoptotic process
#> 39            apoptotic process
#> 40            apoptotic process
#> 41            apoptotic process
#> 42            apoptotic process
#> 43            apoptotic process
#> 44            apoptotic process
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
