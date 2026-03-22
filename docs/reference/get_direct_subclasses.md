# Get direct subclasses of a term

Get direct subclasses of a term

## Usage

``` r
get_direct_subclasses(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

data.frame with columns `id` and `label`, ordered by label.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
# direct children of "apoptotic process" (GO:0006915)
get_direct_subclasses(goref, "GO:0006915")
#>            id                                                        label
#> 1  GO:0043276                                                      anoikis
#> 2  GO:0071839                        apoptotic process in bone marrow cell
#> 3  GO:0140208 apoptotic process in response to mitochondrial fragmentation
#> 4  GO:1902742                    apoptotic process involved in development
#> 5  GO:0072577                           endothelial cell apoptotic process
#> 6  GO:1904019                            epithelial cell apoptotic process
#> 7  GO:1904606                                   fat cell apoptotic process
#> 8  GO:0044346                                 fibroblast apoptotic process
#> 9  GO:0034349                                 glial cell apoptotic process
#> 10 GO:1902489                                hepatoblast apoptotic process
#> 11 GO:0006925                          inflammatory cell apoptotic process
#> 12 GO:0071887                                  leukocyte apoptotic process
#> 13 GO:1902362                                 melanocyte apoptotic process
#> 14 GO:0097152                           mesenchymal cell apoptotic process
#> 15 GO:0010657                                muscle cell apoptotic process
#> 16 GO:0033028                               myeloid cell apoptotic process
#> 17 GO:1904516                         myofibroblast cell apoptotic process
#> 18 GO:0051402                                     neuron apoptotic process
#> 19 GO:1990009                               retinal cell apoptotic process
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
