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
ubss <- semsql_connect(ontology = "uberon")
report(ubss)
```

    ## 
    ## ============================================================ 
    ## SemsqlConn Object
    ## ============================================================ 
    ## 
    ## Connection Details:
    ## ---------------------------------------- 
    ##   Database path:    /home/runner/.cache/R/BiocFileCache/550d2d8c4dd2_uberon.db 
    ##   Ontology prefix:  UBERON 
    ##   Status:           ✓   Connected 
    ## 
    ## Database Statistics:
    ## ---------------------------------------- 
    ##   Labeled terms:    28,764 
    ##   Direct edges:     80,942 
    ##   Entailed edges:   6,421,630 
    ##   Definitions:      23,007 
    ## 
    ## Terms by Prefix (top 5):
    ## ---------------------------------------- 
    ##   UBERON:          16,067
    ##   GO:              7,433
    ##   CL:              1,477
    ##   _:               1,260
    ##   CHEBI:           917
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

ubcon <- ubss@con
head(dbListTables(ubcon))
```

    ## [1] "all_problems"                    "annotation_property_node"       
    ## [3] "anonymous_class_expression"      "anonymous_expression"           
    ## [5] "anonymous_individual_expression" "anonymous_property_expression"

``` r

tbl(ubcon, "statements")
```

    ## # A query:  ?? x 8
    ## # Database: sqlite 3.53.3 [/home/runner/.cache/R/BiocFileCache/550d2d8c4dd2_uberon.db]
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

uboi <- semsql_to_oi(ubcon)
```

    ## Warning in ontologyIndex::ontology_index(name = nn, parents = pl): Some parent
    ## terms not found: BFO:0000001, COB:0000502, CARO:0000000 (4 more)

``` r

uboi
```

    ## Ontology with 25854 terms
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
    ##  BFO:0000003 - occurrent
    ##  CHEBI:24433 - group
    ##  CHEBI:33250 - atom
    ##  BFO:0000002 - continuant
    ##  UBERON:0035943 - life cycle temporal boundary
    ##  CARO:0000007 - immaterial anatomical entity
    ##  ... 3 more

``` r

uboi$name[10364:10370]
```

    ## $`NCBITaxon:9935`
    ## [1] "Ovis"
    ## 
    ## $`NCBITaxon:9963`
    ## [1] "Caprinae"
    ## 
    ## $`NCBITaxon:9971`
    ## [1] "Pholidota"
    ## 
    ## $`NCBITaxon:9972`
    ## [1] "Manidae"
    ## 
    ## $`NCBITaxon:9975`
    ## [1] "Lagomorpha"
    ## 
    ## $`NCBITaxon:9989`
    ## [1] "Rodentia"
    ## 
    ## $`PATO:0000001`
    ## [1] "quality"

A sense of the variety of ontological cross-references present can be
given by tabling the tag prefixes.

``` r

prefs <- gsub(":.*", "", names(uboi$name))
table(prefs)
```

    ## prefs
    ##       BFO      BSPO      CARO     CHEBI        CL       COB        GO       IAO 
    ##        14        12         5       915      1474         5      7428         5 
    ##       NBO NCBITaxon      PATO        PR        RO    UBERON 
    ##        37       474       159       353         1     14972

By using the ancestors component we can obtain a view of is-a relations
(presumably developed from rdfs:subClassOf predicates). We’ve chosen as
terminal tags the tags for heart, kidney, and cortex of kidney.

``` r

onto_plot2(
  uboi,
  unlist(uboi$ancestors[c(
    "UBERON:0002189",
    "UBERON:0002113", "UBERON:0000948"
  )])
)
```

![](uberonpeek_files/figure-html/doplot-1.png)

## EFO and NCI thesaurus

On cursory inspection, the EFO ontology has considerable information
about anatomic locations of diseases.

We’ll use the entailed edges table in EFO to find all statements that
have ‘heart’ (UBERON:0000948) as object.

``` r

eforef <- semsql_connect(ontology = "efo") # 240 MB
```

    ## Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/555e52dd7164_efo.db

    ## Primary ontology prefix: EFO

``` r

# nciref = semsql_connect("ncit")  # > 500MB, block
htab <- tbl(eforef@con, "entailed_edge") |>
  filter(object == "UBERON:0000948") |>
  as.data.frame()
head(htab)
```

    ##          subject       predicate         object
    ## 1 UBERON:0000948 rdfs:subClassOf UBERON:0000948
    ## 2    EFO:0009285     IAO:0000136 UBERON:0000948
    ## 3    EFO:0600032     IAO:0000136 UBERON:0000948
    ## 4    EFO:0008398     IAO:0000136 UBERON:0000948
    ## 5    EFO:0009291     IAO:0000136 UBERON:0000948
    ## 6    EFO:0009290     IAO:0000136 UBERON:0000948

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

    ##                            <NA>                     IAO:0000136 
    ##                              NA                      "is_about" 
    ##                            <NA>                      RO:0002502 
    ##                              NA                    "depends on" 
    ##                     BFO:0000066                      RO:0002131 
    ##                     "occurs in"                      "overlaps" 
    ##                      RO:0001025                      RO:0002314 
    ##                    "located_in"            "inheres in part of" 
    ##                     BFO:0000050                     EFO:0000784 
    ##                       "part_of"          "has_disease_location" 
    ##                      RO:0000052                      RO:0004027 
    ##                    "inheres_in" "disease has inflammation site"

To enumerate and decode the terms with disease location (EFO:0000784) in
heart, we have

``` r

library(dplyr)
library(DT)
hdis <- ncit_map[unlist(htab |> dplyr::filter(predicate == "EFO:0000784")
  |> dplyr::select(subject))]
datatable(data.frame(tag = names(hdis), value = as.character(hdis)))
```

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
    ## [1] DT_0.34.0         dplyr_1.2.1       DBI_1.3.0         ontoProc2_0.99.25
    ## [5] BiocStyle_2.40.0 
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] xfun_0.60           bslib_0.11.0        httr2_1.2.3        
    ##  [4] htmlwidgets_1.6.4   ontologyPlot_1.7    vctrs_0.7.3        
    ##  [7] tools_4.6.1         crosstalk_1.2.2     generics_0.1.4     
    ## [10] stats4_4.6.1        curl_7.1.0          tibble_3.3.1       
    ## [13] RSQLite_3.53.3      blob_1.3.0          pkgconfig_2.0.3    
    ## [16] R.oo_1.27.1         dbplyr_2.6.0        S7_0.2.2           
    ## [19] desc_1.4.3          graph_1.90.0        lifecycle_1.0.5    
    ## [22] compiler_4.6.1      textshaping_1.0.5   htmltools_0.5.9    
    ## [25] sass_0.4.10         yaml_2.3.12         pillar_1.11.1      
    ## [28] pkgdown_2.2.1       jquerylib_0.1.4     R.utils_2.13.0     
    ## [31] cachem_1.1.0        tidyselect_1.2.1    digest_0.6.39      
    ## [34] purrr_1.2.2         bookdown_0.47       paintmap_1.0       
    ## [37] fastmap_1.2.0       grid_4.6.1          cli_3.6.6          
    ## [40] magrittr_2.0.5      utf8_1.2.6          withr_3.0.3        
    ## [43] filelock_1.0.3      rappdirs_0.3.4      bit64_4.8.2        
    ## [46] rmarkdown_2.31      bit_4.6.0           otel_0.2.0         
    ## [49] ragg_1.5.2          R.methodsS3_1.8.2   memoise_2.0.1      
    ## [52] evaluate_1.0.5      knitr_1.51          BiocFileCache_3.2.0
    ## [55] rlang_1.3.0         ontologyIndex_2.12  glue_1.8.1         
    ## [58] Rgraphviz_2.56.0    BiocManager_1.30.27 xml2_1.6.0         
    ## [61] BiocGenerics_0.58.1 jsonlite_2.0.0      R6_2.6.1           
    ## [64] systemfonts_1.3.2   fs_2.1.0
