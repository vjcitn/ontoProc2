<div id="main" class="col-md-9" role="main">

# celltoprotein -- connecting Cell and Protein Ontologies

<div class="section level2">

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

</div>

<div class="section level2">

## Given a cell type, what proteins are noted as parts of its plasma membrane?

Connect to the relational ontology and search for CURIEs related to
“plasma membrane”.

<div id="cb1" class="sourceCode">

``` r
library(ontoProc2)
library(DT)
ro <- semsql_connect(ontology = "ro")
search_labels(ro, "plasma membrane")
```

</div>

    ##      subject                           label
    ## 1 RO:0002104        has plasma membrane part
    ## 2 RO:0015015 has high plasma membrane amount
    ## 3 RO:0015016  has low plasma membrane amount

We have a helper resource for finding exact Cell Ontology names of cell
types.

<div id="cb3" class="sourceCode">

``` r
data("tag2cn", package = "ontoProc2")
cd8reg <- grep("CD8-positive.*regulatory", tag2cn, value = TRUE)
cd8reg
```

</div>

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

<div id="cb5" class="sourceCode">

``` r
prtab <- get_present_pmp(names(cd8reg))
datatable(prtab)
```

</div>

</div>

<div class="section level2">

## Given a protein, what cell types are asserted to possess it as a membrane part?

We pick two proteins and look for associated cell types. BLOCKED AS
ABOVE.

<div id="cb6" class="sourceCode">

``` r
prs <- c("PR:000001094", "PR:000001380")
clk <- try(cells_with_pmp(prs))
if (inherits(clk, "try-error")) message("it is necessary to allow a large download of Protein Ontology for this chunk to run") else datatable(clk)
```

</div>

</div>

<div class="section level2">

## Some details

The “entailed edge” table of the Semantic SQL representation of Cell
Ontology includes all assertions that are derivable from base axioms of
the ontology.

<div id="cb7" class="sourceCode">

``` r
cl <- semsql_connect(ontology = "cl")
cl
```

</div>

    ## <SemsqlConn>  prefix: CL  | labeled terms: 21,544

<div id="cb9" class="sourceCode">

``` r
library(dplyr)
tbl(cl@con, "entailed_edge")
```

</div>

    ## # A query:  ?? x 3
    ## # Database: sqlite 3.53.3 [/Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/235e3797d178_cl.db]
    ##    subject        predicate       object        
    ##    <chr>          <chr>           <chr>         
    ##  1 GO:1904522     rdfs:subClassOf GO:1904522    
    ##  2 UBERON:0019190 rdfs:subClassOf UBERON:0019190
    ##  3 UBERON:0001772 rdfs:subClassOf UBERON:0001772
    ##  4 GO:0051034     rdfs:subClassOf GO:0051033    
    ##  5 GO:0051033     rdfs:subClassOf GO:0051033    
    ##  6 GO:0050679     rdfs:subClassOf GO:0050679    
    ##  7 GO:1901647     rdfs:subClassOf GO:0050679    
    ##  8 GO:1904692     rdfs:subClassOf GO:0050679    
    ##  9 GO:1905564     rdfs:subClassOf GO:0050679    
    ## 10 GO:0060054     rdfs:subClassOf GO:0050679    
    ## # ℹ more rows

<div id="cb11" class="sourceCode">

``` r
tbl(cl@con, "entailed_edge") |> count()
```

</div>

    ## # A query:  ?? x 1
    ## # Database: sqlite 3.53.3 [/Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/235e3797d178_cl.db]
    ##         n
    ##     <int>
    ## 1 3009615

We can look for statements that have “RO:0002104” as predicate:

<div id="cb13" class="sourceCode">

``` r
tbl(cl@con, "entailed_edge") |>
  filter(predicate == "RO:0002104") |>
  as.data.frame() |>
  filter(grepl("PR:", object)) |>
  arrange(subject) |>
  datatable()
```

</div>

<div id="htmlwidget-ac96cb3ee4656e2e9ec3"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

Disconnect databases.

<div id="cb14" class="sourceCode">

``` r
disconnect(cl)
```

</div>

    ## Disconnected from '235e3797d178_cl.db'

<div id="cb16" class="sourceCode">

``` r
disconnect(ro)
```

</div>

    ## Disconnected from '53b7a3ff554_ro.db'

</div>

<div class="section level2">

## Session information

<div id="cb18" class="sourceCode">

``` r
sessionInfo()
```

</div>

    ## R version 4.6.1 (2026-06-24)
    ## Platform: aarch64-apple-darwin23
    ## Running under: macOS Sequoia 15.7.7
    ## 
    ## Matrix products: default
    ## BLAS:   /Library/Frameworks/R.framework/Versions/4.6/Resources/lib/libRblas.0.dylib 
    ## LAPACK: /Library/Frameworks/R.framework/Versions/4.6/Resources/lib/libRlapack.dylib;  LAPACK version 3.12.1
    ## 
    ## locale:
    ## [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
    ## 
    ## time zone: America/New_York
    ## tzcode source: internal
    ## 
    ## attached base packages:
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] dplyr_1.2.1       DT_0.34.0         ontoProc2_0.99.31 BiocStyle_2.41.0 
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] utf8_1.2.6           sass_0.4.10          generics_0.1.4      
    ##  [4] xml2_1.6.0           RSQLite_3.53.3       digest_0.6.39       
    ##  [7] magrittr_2.0.5       evaluate_1.0.5       grid_4.6.1          
    ## [10] bookdown_0.47        fastmap_1.2.0        blob_1.3.0          
    ## [13] R.oo_1.27.1          jsonlite_2.0.0       ontologyIndex_2.12  
    ## [16] R.utils_2.13.0       ontologyPlot_1.7     graph_1.91.0        
    ## [19] DBI_1.3.0            BiocManager_1.30.27  purrr_1.2.2         
    ## [22] crosstalk_1.2.2      Rgraphviz_2.57.0     httr2_1.3.0         
    ## [25] textshaping_1.0.5    jquerylib_0.1.4      paintmap_1.0        
    ## [28] cli_3.6.6            rlang_1.3.0          dbplyr_2.6.0        
    ## [31] R.methodsS3_1.8.2    bit64_4.8.4          withr_3.0.3         
    ## [34] cachem_1.1.0         yaml_2.3.12          otel_0.2.0          
    ## [37] tools_4.6.1          memoise_2.0.1        filelock_1.0.3      
    ## [40] BiocGenerics_0.59.12 curl_7.1.0           vctrs_0.7.3         
    ## [43] R6_2.6.1             stats4_4.6.1         BiocFileCache_3.3.0 
    ## [46] lifecycle_1.0.5      fs_2.1.0             htmlwidgets_1.6.4   
    ## [49] bit_4.6.0            ragg_1.5.2           pkgconfig_2.0.3     
    ## [52] desc_1.4.3           pkgdown_2.2.1        bslib_0.12.0        
    ## [55] pillar_1.11.1        glue_1.8.1           systemfonts_1.3.2   
    ## [58] xfun_0.60            tibble_3.3.1         tidyselect_1.2.1    
    ## [61] knitr_1.51           htmltools_0.5.9      rmarkdown_2.31      
    ## [64] compiler_4.6.1       S7_0.2.2

</div>

</div>
