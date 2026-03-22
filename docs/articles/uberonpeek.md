# uberonpeek -- a look at UBERON ontology, etc., with ontoProc2

## Introduction

The ontoProc2 package is designed to give convenient access to the
ontologies that are transformed to “semantic SQL” in the INCAtools
project.

We’ll start by retrieving the current UBERON ontology and examining some
tables and “statements”.

``` r
library(ontoProc2)
library(DBI)
library(dplyr)
ubss = semsql_connect(ontology="uberon")
report(ubss)
```

    ## 
    ## ============================================================ 
    ## SemsqlConn Object
    ## ============================================================ 
    ## 
    ## Connection Details:
    ## ---------------------------------------- 
    ##   Database path:    /home/vincent/.cache/R/BiocFileCache/b87946edce89_uberon.db 
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

``` r
ubcon = ubss@con
head(dbListTables(ubcon))
```

    ## [1] "all_problems"                    "annotation_property_node"       
    ## [3] "anonymous_class_expression"      "anonymous_expression"           
    ## [5] "anonymous_individual_expression" "anonymous_property_expression"

``` r
tbl(ubcon, "statements")
```

    ## # Source:   table<`statements`> [?? x 8]
    ## # Database: sqlite 3.51.2 [/home/vincent/.cache/R/BiocFileCache/b87946edce89_uberon.db]
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

## Parent-child relations

CRAN’s ontologyIndex package provides a familiar representation that
simplifies visualization.

``` r
uboi = semsql_to_oi(ubcon)
```

    ## Warning in ontologyIndex::ontology_index(name = nn, parents = pl): Some parent
    ## terms not found: BFO:0000001, CARO:0000000, CHEBI:24431 (5 more)

``` r
uboi
```

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

``` r
uboi$name[10364:10370]
```

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

``` r
prefs = gsub(":.*", "", names(uboi$name))
table(prefs)
```

    ## prefs
    ##       BFO      BSPO      CARO     CHEBI        CL        GO       IAO       NBO 
    ##        14        12         5       912      1470      7427         5        37 
    ## NCBITaxon      PATO        PR        RO    UBERON 
    ##       473       159       333         1     14675

By using the ancestors component we can obtain a view of is-a relations
(presumably developed from rdfs:subClassOf predicates). We’ve chosen as
terminal tags the tags for heart, kidney, and cortex of kidney.

``` r
onto_plot2(uboi, 
  unlist(uboi$ancestors[c("UBERON:0002189", 
     "UBERON:0002113", "UBERON:0000948")]))
```

![](uberonpeek_files/figure-html/doplot-1.png)

## EFO and NCI thesaurus

On cursory inspection, the EFO ontology has considerable information
about anatomic locations of diseases.

We’ll use the entailed edges table in EFO to find all statements that
have ‘heart’ (UBERON:0000948) as object.

``` r
eforef = semsql_connect(ontology="efo")  # 240 MB
```

    ## Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b8797df8124_efo.db

    ## Primary ontology prefix: EFO

``` r
#nciref = semsql_connect("ncit")  # > 500MB, block
htab = tbl(eforef@con, "entailed_edge") |> 
  filter(object == "UBERON:0000948") |> as.data.frame() 
head(htab)
```

    ##          subject       predicate         object
    ## 1 UBERON:0000948 rdfs:subClassOf UBERON:0000948
    ## 2  OBA:VT0000266      RO:0002502 UBERON:0000948
    ## 3    EFO:0003896      RO:0002502 UBERON:0000948
    ## 4    OBA:2050102      RO:0002502 UBERON:0000948
    ## 5    OBA:0006021      RO:0002502 UBERON:0000948
    ## 6  OBA:VT0004063      RO:0002502 UBERON:0000948

It is tedious to see these formal tags. We have assembled a simple
character vector map that covers many tags.

``` r
data(ncit_map)
head(ncit_map)
```

    ##           IAO:0000112           IAO:0000114           IAO:0000115 
    ##    "example of usage" "has curation status"          "definition" 
    ##           IAO:0000116           IAO:0000117           IAO:0000232 
    ##         "editor note"         "term editor"        "curator note"

What are the predicates of the heart table above?

``` r
ncit_map[unique(htab$predicate)]
```

    ##                            <NA>                      RO:0002502 
    ##                              NA                    "depends on" 
    ##                     IAO:0000136                            <NA> 
    ##                      "is_about"                              NA 
    ##                     BFO:0000066                      RO:0001025 
    ##                     "occurs in"                    "located_in" 
    ##                      RO:0002131                      RO:0002314 
    ##                      "overlaps"            "inheres in part of" 
    ##                     EFO:0000784                     BFO:0000050 
    ##          "has_disease_location"                       "part_of" 
    ##                      RO:0000052                      RO:0004027 
    ##                    "inheres_in" "disease has inflammation site"

To enumerate and decode the terms with disease location (EFO:0000784) in
heart, we have

``` r
library(dplyr)
library(DT)
hdis = ncit_map[ unlist(htab |> dplyr::filter(predicate == "EFO:0000784") 
   |> dplyr::select(subject)) ]
datatable(data.frame(tag=names(hdis), value=as.character(hdis)))
```

## Session information

``` r
sessionInfo()
```

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
    ## [1] stats     graphics  grDevices utils     datasets  methods   base     
    ## 
    ## other attached packages:
    ## [1] DT_0.34.0        dplyr_1.2.0      DBI_1.2.3        ontoProc2_0.99.4
    ## [5] BiocStyle_2.39.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] utf8_1.2.6          rappdirs_0.3.4      sass_0.4.10        
    ##  [4] generics_0.1.4      RSQLite_2.4.6       digest_0.6.39      
    ##  [7] magrittr_2.0.4      evaluate_1.0.5      grid_4.6.0         
    ## [10] bookdown_0.46       fastmap_1.2.0       blob_1.3.0         
    ## [13] R.oo_1.27.1         jsonlite_2.0.0      ontologyIndex_2.12 
    ## [16] R.utils_2.13.0      ontologyPlot_1.7    graph_1.89.1       
    ## [19] BiocManager_1.30.27 purrr_1.2.1         crosstalk_1.2.2    
    ## [22] Rgraphviz_2.55.0    httr2_1.2.2         textshaping_1.0.4  
    ## [25] jquerylib_0.1.4     paintmap_1.0        cli_3.6.5          
    ## [28] rlang_1.1.7         dbplyr_2.5.2        R.methodsS3_1.8.2  
    ## [31] bit64_4.6.0-1       withr_3.0.2         cachem_1.1.0       
    ## [34] yaml_2.3.12         otel_0.2.0          tools_4.6.0        
    ## [37] memoise_2.0.1       filelock_1.0.3      BiocGenerics_0.57.0
    ## [40] curl_7.0.0          vctrs_0.7.1         R6_2.6.1           
    ## [43] stats4_4.6.0        BiocFileCache_3.1.0 lifecycle_1.0.5    
    ## [46] fs_1.6.6            htmlwidgets_1.6.4   bit_4.6.0          
    ## [49] ragg_1.5.1          pkgconfig_2.0.3     desc_1.4.3         
    ## [52] pkgdown_2.2.0       pillar_1.11.1       bslib_0.10.0       
    ## [55] glue_1.8.0          systemfonts_1.3.1   xfun_0.56          
    ## [58] tibble_3.3.1        tidyselect_1.2.1    knitr_1.51         
    ## [61] htmltools_0.5.9     rmarkdown_2.30      compiler_4.6.0     
    ## [64] S7_0.2.1
