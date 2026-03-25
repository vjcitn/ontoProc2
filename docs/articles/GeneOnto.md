<div id="main" class="col-md-9" role="main">

# Using ontoProc2 with Gene Ontology

<div class="section level2">

## Introduction

Bioconductor’s main interface to Gene Ontology is the GO.db package,
which leverages AnnotationDbi. These are very bespoke facilities. In
this vignette we consider some of the additional details that can be
accessed while working with semantic SQL.

The `statements` table is fundamental.

<div id="cb1" class="sourceCode">

``` r
library(ontoProc2)
library(DT)
library(GO.db)
library(dplyr)
gg = retrieve_semsql_conn("go")
chk1 = tbl(gg, "statements") |> head() |> as.data.frame()
datatable(chk1)
```

</div>

<div id="htmlwidget-ac96cb3ee4656e2e9ec3"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

For a single GO id, the statements available are:

<div id="cb2" class="sourceCode">

``` r
lk1 = tbl(gg, "statements") |> filter(subject == "GO:0018942") |> as.data.frame()
datatable(lk1)
```

</div>

<div id="htmlwidget-e5c8c404fe174e4c81bd"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

</div>

<div class="section level2">

## Basic comparison of semantic SQL resource to GO.db

We begin by filtering the semantic SQL representation of GO to remove
explicitly deprecated terms.

<div id="cb3" class="sourceCode">

``` r
godep = tbl(gg, "statements") |> filter(str_like(subject, "GO:%"), (predicate == "owl:deprecated")) |> 
    select(subject) |> distinct() |> pull() 
semgo = tbl(gg, "statements") |> filter(str_like(subject, "GO:%")) |> select(subject) |>
    distinct() |> pull()
gok = setdiff(semgo, godep)  # non-deprecated ids in semantic SQL
```

</div>

Now we isolate the IDs presented in GO.db but not in non-deprecated IDs
in semantic SQL.

<div id="cb4" class="sourceCode">

``` r
inbioconly = setdiff(keys(GO.db), gok)
ibco = AnnotationDbi::select(GO.db, keys=inbioconly, columns=c("GOID", "TERM"))
```

</div>

    ## 'select()' returned 1:1 mapping between keys and columns

<div id="cb6" class="sourceCode">

``` r
dim(ibco)
```

</div>

    ## [1] 1257    2

<div id="cb8" class="sourceCode">

``` r
datatable(head(ibco))
```

</div>

<div id="htmlwidget-36aa3d2a04d42bbc2145"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

Here’s one example:

<div id="cb9" class="sourceCode">

``` r
tmp = ibco[1,"GOID"]
tbl(gg, "statements") |> select(subject, predicate, object, value) |>
    filter(subject == tmp) |> as.data.frame() |> datatable()
```

</div>

<div id="htmlwidget-febe03efa1a2d8d52a86"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

Here’s an example of a term in semantic SQL but not in GO.db:

<div id="cb10" class="sourceCode">

``` r
insemonly = setdiff(gok, keys(GO.db))
tmp = insemonly[1]
tbl(gg, "statements") |> select(subject, predicate, object, value) |>
    filter(subject == tmp) |> as.data.frame() |> datatable()
```

</div>

<div id="htmlwidget-1fb4450895fe099f74a1"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

The discussion of ‘obsoleting’ <GO:0018942> at
<https://github.com/geneontology/go-ontology/issues/27153> illuminates
some of the negotiations needed for term exclusion/inclusion.

</div>

<div class="section level2">

## Session information

<div id="cb11" class="sourceCode">

``` r
sessionInfo()
```

</div>

    ## R Under development (unstable) (2026-02-16 r89423)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /home/vincent/R-dev-dist/lib/R/lib/libRblas.so 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## time zone: America/New_York
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ##  [1] dplyr_1.2.0          GO.db_3.22.0         AnnotationDbi_1.73.0
    ##  [4] IRanges_2.45.0       S4Vectors_0.49.0     Biobase_2.71.0      
    ##  [7] BiocGenerics_0.57.0  generics_0.1.4       DT_0.34.0           
    ## [10] ontoProc2_0.99.2     BiocStyle_2.39.0    
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] KEGGREST_1.51.1     xfun_0.56           bslib_0.10.0       
    ##  [4] httr2_1.2.2         htmlwidgets_1.6.4   ontologyPlot_1.7   
    ##  [7] crosstalk_1.2.2     vctrs_0.7.1         tools_4.6.0        
    ## [10] curl_7.0.0          tibble_3.3.1        RSQLite_2.4.6      
    ## [13] blob_1.3.0          pkgconfig_2.0.3     R.oo_1.27.1        
    ## [16] dbplyr_2.5.2        S7_0.2.1            desc_1.4.3         
    ## [19] graph_1.89.1        lifecycle_1.0.5     compiler_4.6.0     
    ## [22] Biostrings_2.79.4   textshaping_1.0.4   Seqinfo_1.1.0      
    ## [25] htmltools_0.5.9     sass_0.4.10         yaml_2.3.12        
    ## [28] crayon_1.5.3        pillar_1.11.1       pkgdown_2.2.0      
    ## [31] jquerylib_0.1.4     R.utils_2.13.0      cachem_1.1.0       
    ## [34] tidyselect_1.2.1    digest_0.6.39       purrr_1.2.1        
    ## [37] bookdown_0.46       paintmap_1.0        fastmap_1.2.0      
    ## [40] grid_4.6.0          cli_3.6.5           magrittr_2.0.4     
    ## [43] withr_3.0.2         filelock_1.0.3      rappdirs_0.3.4     
    ## [46] bit64_4.6.0-1       XVector_0.51.0      rmarkdown_2.30     
    ## [49] httr_1.4.8          bit_4.6.0           otel_0.2.0         
    ## [52] png_0.1-8           ragg_1.5.1          R.methodsS3_1.8.2  
    ## [55] memoise_2.0.1       evaluate_1.0.5      knitr_1.51         
    ## [58] BiocFileCache_3.1.0 rlang_1.1.7         ontologyIndex_2.12 
    ## [61] glue_1.8.0          DBI_1.2.3           Rgraphviz_2.55.0   
    ## [64] BiocManager_1.30.27 jsonlite_2.0.0      R6_2.6.1           
    ## [67] systemfonts_1.3.1   fs_1.6.6

</div>

</div>
