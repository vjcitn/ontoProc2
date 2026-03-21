# ontoProc2 -- leveraging semantic SQL for ontology analysis in Bioconductor

## Introduction

The ontoProc2 package has two aims:

- to give convenient access to the ontologies that are transformed to
  “semantic SQL” in the [INCAtools semantic sql
  project](https://github.com/INCATools/semantic-sql);
- to simplify operations that have been available in
  [ontoProc](https://git.bioconductor.org/packages/ontoProc), which will
  be deprecated in 2027.

## Acquiring ontologies

### Make a connection

The best way to work with an ontology in this system is to use
`semsql_connect`. The `ontology` argument will be a short string that
the INCAtools project uses as part of the filename for the ontology. For
Gene Ontology, the string is “go”.

``` r
library(ontoProc2)
goss = semsql_connect(ontology="go")
goss
```

    ## <SemsqlConn>  prefix: GO  | labeled terms: 88,356

### Make a report

The `report` method provides details.

``` r
report(goss)
```

    ## 
    ## ============================================================ 
    ## SemsqlConn Object
    ## ============================================================ 
    ## 
    ## Connection Details:
    ## ---------------------------------------- 
    ##   Database path:    /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db 
    ##   Ontology prefix:  GO 
    ##   Status:           ✓   Connected 
    ## 
    ## Database Statistics:
    ## ---------------------------------------- 
    ##   Labeled terms:    88,356 
    ##   Direct edges:     214,146 
    ##   Entailed edges:   9,336,957 
    ##   Definitions:      55,200 
    ## 
    ## Terms by Prefix (top 5):
    ## ---------------------------------------- 
    ##   GO:              48,251
    ##   CHEBI:           23,969
    ##   _:               7,497
    ##   UBERON:          4,783
    ##   CL:              1,307
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

### Probe the back end

The back end is SQLite. We can enumerate the tables available:

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(DBI)
allt = dbListTables(goss@con)
length(allt)
```

    ## [1] 100

``` r
head(allt)
```

    ## [1] "all_problems"                    "annotation_property_node"       
    ## [3] "anonymous_class_expression"      "anonymous_expression"           
    ## [5] "anonymous_individual_expression" "anonymous_property_expression"

### Use tidy methods

Individual tables are readily accessible.

``` r
library(DT)
tbl(goss@con, "statements")
```

    ## # Source:   table<`statements`> [?? x 8]
    ## # Database: sqlite 3.51.2 [/home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db]
    ##    stanza                 subject predicate object value datatype language graph
    ##    <chr>                  <chr>   <chr>     <chr>  <chr> <chr>    <chr>    <chr>
    ##  1 obo:go/extensions/go-… obo:go… owl:vers… NA     2026… NA       NA       NA   
    ##  2 obo:go/extensions/go-… obo:go… oio:hasO… NA     1.2   NA       NA       NA   
    ##  3 obo:go/extensions/go-… obo:go… oio:defa… NA     gene… NA       NA       NA   
    ##  4 obo:go/extensions/go-… obo:go… dcterms:… cc:by… NA    NA       NA       NA   
    ##  5 obo:go/extensions/go-… obo:go… dce:title NA     Gene… NA       NA       NA   
    ##  6 obo:go/extensions/go-… obo:go… dce:desc… NA     The … NA       NA       NA   
    ##  7 obo:go/extensions/go-… obo:go… IAO:0000… GO:00… NA    NA       NA       NA   
    ##  8 obo:go/extensions/go-… obo:go… IAO:0000… GO:00… NA    NA       NA       NA   
    ##  9 obo:go/extensions/go-… obo:go… IAO:0000… GO:00… NA    NA       NA       NA   
    ## 10 obo:go/extensions/go-… obo:go… owl:vers… obo:g… NA    NA       NA       NA   
    ## # ℹ more rows

``` r
tbl(goss@con, "statements") |> head(20) |> as.data.frame() |> datatable()
```

To investigate the ontology, searching through RDF labels is a natural
approach.

``` r
search_labels(goss, "apoptosis") |> head() |> datatable()
```

Additional filtering could be useful here to focus on GO terms. The
`_riog...` labels have special roles in RDF inference, and this will be
addressed in vignettes to be added in the future.

Let’s improve the query:

``` r
search_labels(goss, "apoptosis") |> filter(grepl("^GO:", subject)) |> head() |> datatable()
```

Clearly it will be valuable to filter away obsolete terms. We will
investigate the use of edge tables to accomplish this in a future
vignette.

## Transformation to ontology_index instances

The [ontologyX
suite](https://academic.oup.com/bioinformatics/article/33/7/1104/2843897)
of Daniel Greene and colleagues provides very convenient ontology
handling functions. We can transform the SQLite data to this format.
We’ll illustrate with cell ontology.

``` r
clss = semsql_connect(ontology="cl")
```

    ## Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b242134f3ccd_cl.db

    ## Primary ontology prefix: CL

``` r
cloi = semsql_to_oi(clss@con)
```

    ## Warning in ontologyIndex::ontology_index(name = nn, parents = pl): Some parent
    ## terms not found: BFO:0000002, BFO:0000004, SO:0000704 (16 more)

``` r
cloi
```

    ## Ontology with 18801 terms
    ## 
    ## Properties:
    ##  id: character
    ##  name: list
    ##  parents: list
    ##  children: list
    ##  ancestors: list
    ##  obsolete: logical
    ## Roots:
    ##  UBERON:0000105 - life cycle stage
    ##  GO:0008150 - biological_process
    ##  GO:0003674 - molecular_function
    ##  UBERON:0000465 - material anatomical entity
    ##  UBERON:0000466 - immaterial anatomical entity
    ##  GO:0005575 - cellular_component
    ##  PATO:0000001 - quality
    ##  PR:000010543 - myeloperoxidase
    ##  IAO:0000027 - data item
    ##  NCBITaxon:131567 - cellular organisms
    ##  ... 940 more

A convenience function assists with visualizations:

``` r
onto_plot2(cloi, c("CL:0000624", "CL:0000492", "CL:0000793", "CL:0000803"))
```

![](ontoProc2_files/figure-html/dopl-1.png)

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
    ## [1] DT_0.34.0        DBI_1.2.3        dplyr_1.2.0      ontoProc2_0.99.3
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
