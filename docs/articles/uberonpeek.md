<div id="main" class="col-md-9" role="main">

# uberonpeek -- a look at UBERON ontology, etc., with ontoProc2

<div class="section level2">

## Introduction

The ontoProc2 package is designed to give convenient access to the
ontologies that are transformed to “semantic SQL” in the INCAtools
project.

We’ll start by retrieving the current UBERON ontology and examining some
tables and “statements”.

<div id="cb1" class="sourceCode">

``` r
library(ontoProc2)
library(DBI)
library(dplyr)
ubss <- semsql_connect(ontology = "uberon")
report(ubss)
```

</div>

    ## 
    ## ============================================================ 
    ## SemsqlConn Object
    ## ============================================================ 
    ## 
    ## Connection Details:
    ## ---------------------------------------- 
    ##   Database path:    /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e22de1c3cc_uberon.db 
    ##   Ontology prefix:  UBERON 
    ##   Status:           ✓   Connected 
    ## 
    ## Database Statistics:
    ## ---------------------------------------- 
    ##   Labeled terms:    28,420 
    ##   Direct edges:     80,252 
    ##   Entailed edges:   5,312,269 
    ##   Definitions:      22,660 
    ## 
    ## Terms by Prefix (top 5):
    ## ---------------------------------------- 
    ##   UBERON:          15,770
    ##   GO:              7,428
    ##   CL:              1,473
    ##   _:               1,260
    ##   CHEBI:           915
    ## 
    ## Key Tables Available:
    ## ---------------------------------------- 
    ##   ✓  rdfs_label_statement 
    ##   ✓  has_text_definition_statement 
    ##   ✓  edge 
    ##   ✓  entailed_edge 
    ##   ✓  rdfs_subclass_of_statement 
    ##   ✓  owl_some_values_from 
    ##   ✓  has_oio_synonym_statement 
    ## 
    ## ============================================================ 
    ## Use methods like search_labels(), get_ancestors(), etc.
    ## Run ?SemsqlConn for documentation.
    ## ============================================================

<div id="cb3" class="sourceCode">

``` r
ubcon <- ubss@con
head(dbListTables(ubcon))
```

</div>

    ## [1] "all_problems"                    "annotation_property_node"       
    ## [3] "anonymous_class_expression"      "anonymous_expression"           
    ## [5] "anonymous_individual_expression" "anonymous_property_expression"

<div id="cb5" class="sourceCode">

``` r
tbl(ubcon, "statements")
```

</div>

    ## # A query:  ?? x 8
    ## # Database: sqlite 3.53.3 [/Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e22de1c3cc_uberon.db]
    ##    stanza         subject        predicate  object value datatype language graph
    ##    <chr>          <chr>          <chr>      <chr>  <chr> <chr>    <chr>    <chr>
    ##  1 obo:uberon.owl obo:uberon.owl foaf:home… NA     http… xsd:any… NA       NA   
    ##  2 obo:uberon.owl obo:uberon.owl rdfs:comm… NA     Aure… NA       NA       NA   
    ##  3 obo:uberon.owl obo:uberon.owl oio:treat… NA     ZFS … NA       NA       NA   
    ##  4 obo:uberon.owl obo:uberon.owl oio:treat… NA     ZFA … NA       NA       NA   
    ##  5 obo:uberon.owl obo:uberon.owl oio:treat… NA     XAO … NA       NA       NA   
    ##  6 obo:uberon.owl obo:uberon.owl oio:treat… NA     WBls… NA       NA       NA   
    ##  7 obo:uberon.owl obo:uberon.owl oio:treat… NA     WBbt… NA       NA       NA   
    ##  8 obo:uberon.owl obo:uberon.owl oio:treat… NA     TGMA… NA       NA       NA   
    ##  9 obo:uberon.owl obo:uberon.owl oio:treat… NA     TAO … NA       NA       NA   
    ## 10 obo:uberon.owl obo:uberon.owl oio:treat… NA     TADS… NA       NA       NA   
    ## # ℹ more rows

</div>

<div class="section level2">

## Parent-child relations

CRAN’s ontologyIndex package provides a familiar representation that
simplifies visualization.

<div id="cb7" class="sourceCode">

``` r
uboi <- semsql_to_oi(ubcon)
```

</div>

    ## Warning in ontologyIndex::ontology_index(name = nn, parents = pl): Some parent
    ## terms not found: BFO:0000001, CARO:0000000, CHEBI:24431 (5 more)

<div id="cb9" class="sourceCode">

``` r
uboi
```

</div>

    ## Ontology with 25523 terms
    ## 
    ## Properties:
    ##  id: character
    ##  name: list
    ##  parents: list
    ##  children: list
    ##  ancestors: list
    ##  obsolete: logical
    ## Roots:
    ##  CHEBI:24432 - biological role
    ##  CHEBI:51086 - chemical role
    ##  CHEBI:33232 - application
    ##  CHEBI:23367 - molecular entity
    ##  CHEBI:24433 - group
    ##  BFO:0000002 - continuant
    ##  CHEBI:33250 - atom
    ##  BFO:0000003 - occurrent
    ##  CARO:0000007 - immaterial anatomical entity
    ##  CHEBI:36340 - fermion
    ##  ... 9 more

<div id="cb11" class="sourceCode">

``` r
uboi$name[10364:10370]
```

</div>

    ## $`PATO:0000070`
    ## [1] "amount"
    ## 
    ## $`PATO:0000136`
    ## [1] "closure"
    ## 
    ## $`PATO:0000141`
    ## [1] "structure"
    ## 
    ## $`PATO:0000150`
    ## [1] "texture"
    ## 
    ## $`PATO:0000169`
    ## [1] "viability"
    ## 
    ## $`PATO:0000261`
    ## [1] "maturity"
    ## 
    ## $`PATO:0000322`
    ## [1] "red"

A sense of the variety of ontological cross-references present can be
given by tabling the tag prefixes.

<div id="cb13" class="sourceCode">

``` r
prefs <- gsub(":.*", "", names(uboi$name))
table(prefs)
```

</div>

    ## prefs
    ##       BFO      BSPO      CARO     CHEBI        CL        GO       IAO       NBO 
    ##        14        12         5       912      1470      7427         5        37 
    ## NCBITaxon      PATO        PR        RO    UBERON 
    ##       473       159       333         1     14675

By using the ancestors component we can obtain a view of is-a relations
(presumably developed from rdfs:subClassOf predicates). We’ve chosen as
terminal tags the tags for heart, kidney, and cortex of kidney.

<div id="cb15" class="sourceCode">

``` r
onto_plot2(
  uboi,
  unlist(uboi$ancestors[c(
    "UBERON:0002189",
    "UBERON:0002113", "UBERON:0000948"
  )])
)
```

</div>

![](uberonpeek_files/figure-html/doplot-1.png)

</div>

<div class="section level2">

## Bridging to MONDO for disease terminology

With our knowledge of the tag for “heart”, we can enumerate formal terms
for diseases affecting this organ.

<div id="cb16" class="sourceCode">

``` r
mon = semsql_connect(ontology="mondo")
```

</div>

    ## Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/129ea231d7f31_mondo.db

    ## Primary ontology prefix: MONDO

<div id="cb19" class="sourceCode">

``` r
tbl(mon@con, "entailed_edge") |> 
   filter(object == "UBERON:0000948") |> 
   filter(subject %like% "MONDO%") |> 
   inner_join( tbl(mon@con, "rdfs_label_statement"), by="subject") |> 
   as.data.frame() |> select(subject, value) |> distinct() |> DT::datatable()
```

</div>

<div id="htmlwidget-ac96cb3ee4656e2e9ec3"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

</div>

<div class="section level2">

## Bridging to CL for cell type enumeration

<div id="cb20" class="sourceCode">

``` r
cl = semsql_connect(ontology="cl")
```

</div>

    ## Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/235e3797d178_cl.db

    ## Primary ontology prefix: CL

<div id="cb23" class="sourceCode">

``` r
tbl(ubcon, "entailed_edge") |> 
   filter(object == "UBERON:0000948") |> 
   filter(subject %like% "CL:%") |> 
   inner_join( tbl(cl@con, "rdfs_label_statement"), by="subject", copy="temp-table") |> 
   as.data.frame() |> select(subject, value) |> distinct() |> DT::datatable()
```

</div>

<div id="htmlwidget-e5c8c404fe174e4c81bd"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

Exercise: create a map from cardiac diseases to associated cardiac cell
types.

</div>

<div class="section level2">

## Session information

<div id="cb24" class="sourceCode">

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
    ## [1] dplyr_1.2.1       DBI_1.3.0         ontoProc2_0.99.31 BiocStyle_2.41.0 
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] utf8_1.2.6           sass_0.4.10          generics_0.1.4      
    ##  [4] xml2_1.6.0           RSQLite_3.53.3       digest_0.6.39       
    ##  [7] magrittr_2.0.5       evaluate_1.0.5       grid_4.6.1          
    ## [10] bookdown_0.47        fastmap_1.2.0        blob_1.3.0          
    ## [13] R.oo_1.27.1          jsonlite_2.0.0       ontologyIndex_2.12  
    ## [16] R.utils_2.13.0       ontologyPlot_1.7     graph_1.91.0        
    ## [19] BiocManager_1.30.27  purrr_1.2.2          crosstalk_1.2.2     
    ## [22] Rgraphviz_2.57.0     httr2_1.3.0          textshaping_1.0.5   
    ## [25] jquerylib_0.1.4      paintmap_1.0         cli_3.6.6           
    ## [28] rlang_1.3.0          dbplyr_2.6.0         R.methodsS3_1.8.2   
    ## [31] bit64_4.8.4          withr_3.0.3          cachem_1.1.0        
    ## [34] yaml_2.3.12          otel_0.2.0           tools_4.6.1         
    ## [37] memoise_2.0.1        DT_0.34.0            filelock_1.0.3      
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
