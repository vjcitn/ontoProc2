# celltoprotein -- connecting Cell and Protein Ontologies

## Introduction

In a pair of papers from the Ventner Institute, [Bakken et
al.](https://link.springer.com/article/10.1186/s12859-017-1977-1) and
[Aevermann et
al.](https://academic.oup.com/hmg/article/27/R1/R40/4953379) discuss
ontological implications of single-cell transcriptomics. A process of
cell type definition via “necessary and sufficient marker gene”
enumeration is introduced.

In this vignette we indicate how Cell Ontology, Relational Ontology, and
Protein Ontology can be connected to assess formal relationships between
declared cell types and plasma membrane features that can play a role in
cell type definition.

## Given a cell type, what proteins are noted as parts of its plasma membrane?

Connect to the relational ontology and search for CURIEs related to
“plasma membrane”.

``` r

library(ontoProc2)
library(DT)
ro <- semsql_connect(ontology = "ro")
search_labels(ro, "plasma membrane")
```

    ##      subject                           label
    ## 1 RO:0002104        has plasma membrane part
    ## 2 RO:0015015 has high plasma membrane amount
    ## 3 RO:0015016  has low plasma membrane amount

We have a helper resource for finding exact Cell Ontology names of cell
types.

``` r

data("tag2cn", package = "ontoProc2")
cd8reg <- grep("CD8-positive.*regulatory", tag2cn, value = TRUE)
cd8reg
```

    ##                                                   CL:0000795 
    ##                 "CD8-positive, alpha-beta regulatory T cell" 
    ##                                                   CL:0000919 
    ##  "CD8-positive, CD25-positive, alpha-beta regulatory T cell" 
    ##                                                   CL:0000920 
    ##  "CD8-positive, CD28-negative, alpha-beta regulatory T cell" 
    ##                                                   CL:0001041 
    ## "CD8-positive, CXCR3-positive, alpha-beta regulatory T cell"

Now with these cell type identifiers, we can search for the proteins
identified as “part of plasma membrane”. We need to use the CURIEs for
precision. THIS IS BLOCKED UNTIL WE HAVE A SUBSET OF PR DATA TO
ILLUSTRATE AS THE PR DOWNLOADS ARE TOO SLOW.

``` r

prtab <- get_present_pmp(names(cd8reg))
datatable(prtab)
```

## Given a protein, what cell types are asserted to possess it as a membrane part?

We pick two proteins and look for associated cell types. BLOCKED AS
ABOVE.

``` r

prs <- c("PR:000001094", "PR:000001380")
clk <- try(cells_with_pmp(prs))
if (inherits(clk, "try-error")) message("it is necessary to allow a large download of Protein Ontology for this chunk to run") else datatable(clk)
```

## Some details

The “entailed edge” table of the Semantic SQL representation of Cell
Ontology includes all assertions that are derivable from base axioms of
the ontology.

``` r

cl <- semsql_connect(ontology = "cl")
cl
```

    ## <SemsqlConn>  prefix: CL  | labeled terms: 21,544

``` r

library(dplyr)
tbl(cl@con, "entailed_edge")
```

    ## # A query:  ?? x 3
    ## # Database: sqlite 3.53.2 [/home/runner/.cache/R/BiocFileCache/51f2133945e9_cl.db]
    ##    subject        predicate       object        
    ##    <chr>          <chr>           <chr>         
    ##  1 UBERON:0001772 rdfs:subClassOf UBERON:0001772
    ##  2 GO:0051034     rdfs:subClassOf GO:0051033    
    ##  3 GO:0051033     rdfs:subClassOf GO:0051033    
    ##  4 UBERON:0018685 rdfs:subClassOf UBERON:0018685
    ##  5 GO:0106027     rdfs:subClassOf GO:0106027    
    ##  6 GO:0050679     rdfs:subClassOf GO:0050679    
    ##  7 GO:1901647     rdfs:subClassOf GO:0050679    
    ##  8 GO:1904692     rdfs:subClassOf GO:0050679    
    ##  9 GO:1905564     rdfs:subClassOf GO:0050679    
    ## 10 GO:0060054     rdfs:subClassOf GO:0050679    
    ## # ℹ more rows

``` r

tbl(cl@con, "entailed_edge") |> count()
```

    ## # A query:  ?? x 1
    ## # Database: sqlite 3.53.2 [/home/runner/.cache/R/BiocFileCache/51f2133945e9_cl.db]
    ##         n
    ##     <int>
    ## 1 3009615

We can look for statements that have “RO:0002104” as predicate:

``` r

tbl(cl@con, "entailed_edge") |>
  filter(predicate == "RO:0002104") |>
  as.data.frame() |>
  filter(grepl("PR:", object)) |>
  arrange(subject) |>
  datatable()
```

Disconnect databases.

``` r

disconnect(cl)
```

    ## Disconnected from '51f2133945e9_cl.db'

``` r

disconnect(ro)
```

    ## Disconnected from '54b186f9a5f_ro.db'

## Session information

``` r

sessionInfo()
```

    ## R version 4.6.1 (2026-06-24)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.4 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=C.UTF-8       LC_NUMERIC=C           LC_TIME=C.UTF-8       
    ##  [4] LC_COLLATE=C.UTF-8     LC_MONETARY=C.UTF-8    LC_MESSAGES=C.UTF-8   
    ##  [7] LC_PAPER=C.UTF-8       LC_NAME=C              LC_ADDRESS=C          
    ## [10] LC_TELEPHONE=C         LC_MEASUREMENT=C.UTF-8 LC_IDENTIFICATION=C   
    ## 
    ## time zone: UTC
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] dplyr_1.2.1       DT_0.34.0         ontoProc2_0.99.24 BiocStyle_2.40.0 
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] xfun_0.59           bslib_0.11.0        httr2_1.2.3        
    ##  [4] htmlwidgets_1.6.4   ontologyPlot_1.7    vctrs_0.7.3        
    ##  [7] tools_4.6.1         crosstalk_1.2.2     generics_0.1.4     
    ## [10] stats4_4.6.1        curl_7.1.0          tibble_3.3.1       
    ## [13] RSQLite_3.53.2      blob_1.3.0          pkgconfig_2.0.3    
    ## [16] R.oo_1.27.1         dbplyr_2.6.0        S7_0.2.2           
    ## [19] desc_1.4.3          graph_1.90.0        lifecycle_1.0.5    
    ## [22] compiler_4.6.1      textshaping_1.0.5   htmltools_0.5.9    
    ## [25] sass_0.4.10         yaml_2.3.12         pillar_1.11.1      
    ## [28] pkgdown_2.2.0       jquerylib_0.1.4     R.utils_2.13.0     
    ## [31] cachem_1.1.0        tidyselect_1.2.1    digest_0.6.39      
    ## [34] purrr_1.2.2         bookdown_0.47       paintmap_1.0       
    ## [37] fastmap_1.2.0       grid_4.6.1          cli_3.6.6          
    ## [40] magrittr_2.0.5      utf8_1.2.6          withr_3.0.3        
    ## [43] filelock_1.0.3      rappdirs_0.3.4      bit64_4.8.2        
    ## [46] rmarkdown_2.31      bit_4.6.0           otel_0.2.0         
    ## [49] ragg_1.5.2          R.methodsS3_1.8.2   memoise_2.0.1      
    ## [52] evaluate_1.0.5      knitr_1.51          BiocFileCache_3.2.0
    ## [55] rlang_1.2.0         ontologyIndex_2.12  glue_1.8.1         
    ## [58] DBI_1.3.0           Rgraphviz_2.56.0    BiocManager_1.30.27
    ## [61] xml2_1.6.0          BiocGenerics_0.58.1 jsonlite_2.0.0     
    ## [64] R6_2.6.1            systemfonts_1.3.2   fs_2.1.0
