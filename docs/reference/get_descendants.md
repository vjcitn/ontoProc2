<div id="main" class="col-md-9" role="main">

# Get all descendants of a term via entailed edges

<div class="ref-description section level2">

Get all descendants of a term via entailed edges

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_descendants(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

-   predicates:

    character vector of predicate CURIEs to follow. Defaults to
    `"rdfs:subClassOf"`.

-   include\_self:

    logical(1) whether to include the term itself (default `FALSE`).

</div>

<div class="section level2">

## Value

data.frame with columns `id`, `label`, `predicate`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_descendants(goref, "GO:0006915")
#>            id
#> 1  GO:0001783
#> 2  GO:0002516
#> 3  GO:1902484
#> 4  GO:0070231
#> 5  GO:1905398
#> 6  GO:1905397
#> 7  GO:0070238
#> 8  GO:0071948
#> 9  GO:0006924
#> 10 GO:0043276
#> 12 GO:0071839
#> 13 GO:0140208
#> 14 GO:1902262
#> 15 GO:1902742
#> 16 GO:1902263
#> 17 GO:0003277
#> 18 GO:0003278
#> 19 GO:0061364
#> 20 GO:0060057
#> 21 GO:0060561
#> 22 GO:0003275
#> 23 GO:0010659
#> 24 GO:0002342
#> 25 GO:1902488
#> 26 GO:0060885
#> 27 GO:1990010
#> 28 GO:0097048
#> 29 GO:0072577
#> 30 GO:1904019
#> 31 GO:1990134
#> 32 GO:1902217
#> 33 GO:1904606
#> 34 GO:0044346
#> 35 GO:0034349
#> 36 GO:1904700
#> 37 GO:1902489
#> 38 GO:0097284
#> 39 GO:0110088
#> 40 GO:0006925
#> 41 GO:0097283
#> 42 GO:1990086
#> 43 GO:0071887
#> 44 GO:0070227
#> 45 GO:0071888
#> 46 GO:0033024
#> 47 GO:0002901
#> 48 GO:1902362
#> 49 GO:0097152
#> 50 GO:1900200
#> 51 GO:1901145
#> 52 GO:0097049
#> 53 GO:0010657
#> 54 GO:0033028
#> 55 GO:1904516
#> 56 GO:0070246
#> 57 GO:0051402
#> 58 GO:0001781
#> 59 GO:0045476
#> 60 GO:0097252
#> 61 GO:1905584
#> 62 GO:0002454
#> 63 GO:1903210
#> 64 GO:1902482
#> 65 GO:1990009
#> 66 GO:0097474
#> 67 GO:0097473
#> 68 GO:0034390
#> 69 GO:0010658
#> 70 GO:0070242
#> 71 GO:0097050
#> 72 GO:1905288
#>                                                                        label
#> 1                                                   B cell apoptotic process
#> 2                                                            B cell deletion
#> 3                                             Sertoli cell apoptotic process
#> 4                                                   T cell apoptotic process
#> 5                activated CD4-positive, alpha-beta T cell apoptotic process
#> 6                activated CD8-positive, alpha-beta T cell apoptotic process
#> 7                                     activated T cell autonomous cell death
#> 8                                activation-induced B cell apoptotic process
#> 9                                   activation-induced cell death of T cells
#> 10                                                                   anoikis
#> 12                                     apoptotic process in bone marrow cell
#> 13              apoptotic process in response to mitochondrial fragmentation
#> 14                  apoptotic process involved in blood vessel morphogenesis
#> 15                                 apoptotic process involved in development
#> 16               apoptotic process involved in embryonic digit morphogenesis
#> 17           apoptotic process involved in endocardial cushion morphogenesis
#> 18                         apoptotic process involved in heart morphogenesis
#> 19                                  apoptotic process involved in luteolysis
#> 20                    apoptotic process involved in mammary gland involution
#> 21                               apoptotic process involved in morphogenesis
#> 22                 apoptotic process involved in outflow tract morphogenesis
#> 23                                     cardiac muscle cell apoptotic process
#> 24                                                   central B cell deletion
#> 25                                           cholangiocyte apoptotic process
#> 26                 clearance of cells from fusion plate by apoptotic process
#> 27                               compound eye retinal cell apoptotic process
#> 28                                          dendritic cell apoptotic process
#> 29                                        endothelial cell apoptotic process
#> 30                                         epithelial cell apoptotic process
#> 31 epithelial cell apoptotic process involved in palatal shelf morphogenesis
#> 32                                             erythrocyte apoptotic process
#> 33                                                fat cell apoptotic process
#> 34                                              fibroblast apoptotic process
#> 35                                              glial cell apoptotic process
#> 36                                          granulosa cell apoptotic process
#> 37                                             hepatoblast apoptotic process
#> 38                                              hepatocyte apoptotic process
#> 39                                      hippocampal neuron apoptotic process
#> 40                                       inflammatory cell apoptotic process
#> 41                                            keratinocyte apoptotic process
#> 42                                         lens fiber cell apoptotic process
#> 43                                               leukocyte apoptotic process
#> 44                                              lymphocyte apoptotic process
#> 45                                              macrophage apoptotic process
#> 46                                               mast cell apoptotic process
#> 47                                           mature B cell apoptotic process
#> 48                                              melanocyte apoptotic process
#> 49                                        mesenchymal cell apoptotic process
#> 50    mesenchymal cell apoptotic process involved in metanephros development
#> 51      mesenchymal cell apoptotic process involved in nephron morphogenesis
#> 52                                            motor neuron apoptotic process
#> 53                                             muscle cell apoptotic process
#> 54                                            myeloid cell apoptotic process
#> 55                                      myofibroblast cell apoptotic process
#> 56                                     natural killer cell apoptotic process
#> 57                                                  neuron apoptotic process
#> 58                                              neutrophil apoptotic process
#> 59                                              nurse cell apoptotic process
#> 60                                         oligodendrocyte apoptotic process
#> 61                                         outer hair cell apoptotic process
#> 62                                                peripheral B cell deletion
#> 63                                                podocyte apoptotic process
#> 64                                       regulatory T cell apoptotic process
#> 65                                            retinal cell apoptotic process
#> 66                                       retinal cone cell apoptotic process
#> 67                                        retinal rod cell apoptotic process
#> 68                                      smooth muscle cell apoptotic process
#> 69                                    striated muscle cell apoptotic process
#> 70                                               thymocyte apoptotic process
#> 71                                  type B pancreatic cell apoptotic process
#> 72                  vascular associated smooth muscle cell apoptotic process
#>          predicate
#> 1  rdfs:subClassOf
#> 2  rdfs:subClassOf
#> 3  rdfs:subClassOf
#> 4  rdfs:subClassOf
#> 5  rdfs:subClassOf
#> 6  rdfs:subClassOf
#> 7  rdfs:subClassOf
#> 8  rdfs:subClassOf
#> 9  rdfs:subClassOf
#> 10 rdfs:subClassOf
#> 12 rdfs:subClassOf
#> 13 rdfs:subClassOf
#> 14 rdfs:subClassOf
#> 15 rdfs:subClassOf
#> 16 rdfs:subClassOf
#> 17 rdfs:subClassOf
#> 18 rdfs:subClassOf
#> 19 rdfs:subClassOf
#> 20 rdfs:subClassOf
#> 21 rdfs:subClassOf
#> 22 rdfs:subClassOf
#> 23 rdfs:subClassOf
#> 24 rdfs:subClassOf
#> 25 rdfs:subClassOf
#> 26 rdfs:subClassOf
#> 27 rdfs:subClassOf
#> 28 rdfs:subClassOf
#> 29 rdfs:subClassOf
#> 30 rdfs:subClassOf
#> 31 rdfs:subClassOf
#> 32 rdfs:subClassOf
#> 33 rdfs:subClassOf
#> 34 rdfs:subClassOf
#> 35 rdfs:subClassOf
#> 36 rdfs:subClassOf
#> 37 rdfs:subClassOf
#> 38 rdfs:subClassOf
#> 39 rdfs:subClassOf
#> 40 rdfs:subClassOf
#> 41 rdfs:subClassOf
#> 42 rdfs:subClassOf
#> 43 rdfs:subClassOf
#> 44 rdfs:subClassOf
#> 45 rdfs:subClassOf
#> 46 rdfs:subClassOf
#> 47 rdfs:subClassOf
#> 48 rdfs:subClassOf
#> 49 rdfs:subClassOf
#> 50 rdfs:subClassOf
#> 51 rdfs:subClassOf
#> 52 rdfs:subClassOf
#> 53 rdfs:subClassOf
#> 54 rdfs:subClassOf
#> 55 rdfs:subClassOf
#> 56 rdfs:subClassOf
#> 57 rdfs:subClassOf
#> 58 rdfs:subClassOf
#> 59 rdfs:subClassOf
#> 60 rdfs:subClassOf
#> 61 rdfs:subClassOf
#> 62 rdfs:subClassOf
#> 63 rdfs:subClassOf
#> 64 rdfs:subClassOf
#> 65 rdfs:subClassOf
#> 66 rdfs:subClassOf
#> 67 rdfs:subClassOf
#> 68 rdfs:subClassOf
#> 69 rdfs:subClassOf
#> 70 rdfs:subClassOf
#> 71 rdfs:subClassOf
#> 72 rdfs:subClassOf
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
