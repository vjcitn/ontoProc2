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

## Background

The S7 class design in this package was initiated by a request to
Anthropic Claude to use S7 in establishing code that mirrors the tasks
accomplished in the [INCAtools jupyter
notebook](https://github.com/INCATools/semantic-sql/blob/main/notebooks/SemanticSQL-Tutorial.ipynb).

### Searching in label text

The code of `search_labels` is:

``` r
library(S7)
method(search_labels, SemsqlConn)
```

    ## <S7_method> method(search_labels, ontoProc2::SemsqlConn)
    ## function (x, pattern, limit = 20L) 
    ## {
    ##     query <- sprintf("\n    SELECT subject, value AS label\n    FROM rdfs_label_statement\n    WHERE value LIKE '%%%s%%'\n    LIMIT %d\n  ", 
    ##         pattern, limit)
    ##     dbGetQuery(x@con, query)
    ## }
    ## <environment: namespace:ontoProc2>

### Exploring concept properties with ‘edge tables’

The INCAtools notebook discusses the fact that `rdfs_label_statement` is
a SQLite table “view”.

The notebook indicates that a SPARQL query on an RDF store for the
following computation would be “quite hard”. We want to find all the
“edges” leading from “enteric neuron”, which would constitute the set of
subject-predicate-object statements about this cell type with “enteric
neuron” as subject.

In this code we use the concept of a “CURIE” (Compact Uniform Resource
Identifier): a fixed length numerical identifier with a prefix
indicating the source ontology in which the ontologic concept is based.

``` r
if (!is_connected(clss)) clss = reconnect(clss)
entcurie = search_labels(clss, "enteric neuron") |> 
  filter(grepl("^CL", subject)) |> dplyr::select(subject) |> unlist()
entcurie
```

    ##      subject 
    ## "CL:0007011"

``` r
get_direct_edges(clss, entcurie)
```

    ##      subject  subject_label       predicate   predicate_label         object
    ## 1 CL:0007011 enteric neuron     BFO:0000050           part of UBERON:0002005
    ## 2 CL:0007011 enteric neuron     BFO:0000050           part of UBERON:0002005
    ## 3 CL:0007011 enteric neuron      RO:0002100 has soma location UBERON:0002005
    ## 4 CL:0007011 enteric neuron      RO:0002100 has soma location UBERON:0002005
    ## 5 CL:0007011 enteric neuron      RO:0002202     develops from     CL:0002607
    ## 6 CL:0007011 enteric neuron rdfs:subClassOf              <NA>     CL:0000029
    ## 7 CL:0007011 enteric neuron rdfs:subClassOf              <NA>     CL:0000107
    ##                          object_label
    ## 1              enteric nervous system
    ## 2              enteric nervous system
    ## 3              enteric nervous system
    ## 4              enteric nervous system
    ## 5 migratory enteric neural crest cell
    ## 6         neural crest derived neuron
    ## 7                    autonomic neuron

Here the underlying code is performing a join:

``` r
method(get_direct_edges, SemsqlConn)
```

    ## <S7_method> method(get_direct_edges, ontoProc2::SemsqlConn)
    ## function (x, term_id, direction = c("outgoing", "incoming", "both")) 
    ## {
    ##     direction <- match.arg(direction)
    ##     where_clause <- switch(direction, outgoing = sprintf("e.subject = '%s'", 
    ##         term_id), incoming = sprintf("e.object = '%s'", term_id), 
    ##         both = sprintf("e.subject = '%s' OR e.object = '%s'", 
    ##             term_id, term_id))
    ##     query <- sprintf("\n    SELECT\n      e.subject,\n      sl.value AS subject_label,\n      e.predicate,\n      pl.value AS predicate_label,\n      e.object,\n      ol.value AS object_label\n    FROM edge e\n    LEFT JOIN rdfs_label_statement sl ON e.subject = sl.subject\n    LEFT JOIN rdfs_label_statement pl ON e.predicate = pl.subject\n    LEFT JOIN rdfs_label_statement ol ON e.object = ol.subject\n    WHERE %s\n  ", 
    ##         where_clause)
    ##     dbGetQuery(x@con, query)
    ## }
    ## <environment: namespace:ontoProc2>

### Generalizing a concept: Ancestors

The notebook mentions that the “entailed edges” table includes all
statements that can be inferred from the application of base axioms of
the ontology.

``` r
get_ancestors(clss, entcurie)
```

    ##                id                            label       predicate
    ## 1     BFO:0000002                             <NA> rdfs:subClassOf
    ## 2     BFO:0000004                             <NA> rdfs:subClassOf
    ## 3     BFO:0000040                             <NA> rdfs:subClassOf
    ## 4  UBERON:0001062                anatomical entity rdfs:subClassOf
    ## 5  UBERON:0000061             anatomical structure rdfs:subClassOf
    ## 6      CL:0000107                 autonomic neuron rdfs:subClassOf
    ## 7      CL:0000000                             cell rdfs:subClassOf
    ## 8      CL:0000211         electrically active cell rdfs:subClassOf
    ## 9      CL:0000393     electrically responsive cell rdfs:subClassOf
    ## 10     CL:0000404      electrically signaling cell rdfs:subClassOf
    ## 12     CL:0000255                  eukaryotic cell rdfs:subClassOf
    ## 13 UBERON:0000465       material anatomical entity rdfs:subClassOf
    ## 14     CL:0002319                      neural cell rdfs:subClassOf
    ## 15     CL:0000029      neural crest derived neuron rdfs:subClassOf
    ## 16     CL:0000540                           neuron rdfs:subClassOf
    ## 17     CL:2000032 peripheral nervous system neuron rdfs:subClassOf

### Working with multiple ontologies

The INCAtools notebook includes an example of finding all neurons that
are part of the forebrain. This involves identifying CURIEs for
relations and anatomical structures, thus working with the relational
ontology (RO) and UBERON.

``` r
ub = semsql_connect(ontology="uberon")
```

    ## Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b87946edce89_uberon.db

    ## Primary ontology prefix: UBERON

``` r
ro = semsql_connect(ontology="ro")
```

    ## Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/1269f106cdd77_ro.db

    ## Primary ontology prefix: RO

First question: What’s the CURIE for “forebrain” in UBERON?

``` r
fbcur = search_labels(ub, "forebrain", limit=1000) |> filter(label=="forebrain") |>
  select(subject) |> unlist()
fbcur
```

    ##          subject 
    ## "UBERON:0001890"

Second question: What’s the CURIE for “has soma location” in RO?

``` r
loccur = search_labels(ro, "has soma location") |> select(subject) |> unlist()
loccur
```

    ##      subject 
    ## "RO:0002100"

What’s the CURIE for “neuron”?

``` r
ncur = search_labels(clss, "neuron", limit=1000) |> filter(label=="neuron") |>
  select(subject) |> unlist()
ncur
```

    ##      subject 
    ## "CL:0000540"

Now we use three steps to obtain the solution.

First, enumerate all cell types that are located in forebrain.

``` r
clinfb = tbl(clss@con, "entailed_edge") |> filter(predicate == loccur, object == fbcur) |> 
         select(subject) |> collect() |> unlist() 
length(clinfb)
```

    ## [1] 185

Second, filter these to those identified as ‘subclassOf’ “neuron”.

``` r
clisneur = tbl(clss@con, "entailed_edge") |> filter(predicate == "rdfs:subClassOf", object==ncur) |> 
         filter(subject %in% clinfb) |> select(subject) |> collect() |> unlist() 
length(clisneur)
```

    ## [1] 185

Finally, get the labels.

``` r
tbl(clss@con, "rdfs_label_statement") |> filter(subject %in% clisneur) |> 
         select(subject, value) |> collect() |> DT::datatable()
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
    ## [1] S7_0.2.1         rmarkdown_2.30   devtools_2.4.6   usethis_3.2.1   
    ## [5] DT_0.34.0        DBI_1.2.3        dplyr_1.2.0      ontoProc2_0.99.4
    ## [9] BiocStyle_2.39.0
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] xfun_0.56           bslib_0.10.0        httr2_1.2.2        
    ##  [4] remotes_2.5.0       htmlwidgets_1.6.4   ontologyPlot_1.7   
    ##  [7] vctrs_0.7.1         tools_4.6.0         crosstalk_1.2.2    
    ## [10] generics_0.1.4      stats4_4.6.0        curl_7.0.0         
    ## [13] tibble_3.3.1        RSQLite_2.4.6       blob_1.3.0         
    ## [16] pkgconfig_2.0.3     R.oo_1.27.1         dbplyr_2.5.2       
    ## [19] desc_1.4.3          graph_1.89.1        lifecycle_1.0.5    
    ## [22] compiler_4.6.0      textshaping_1.0.4   codetools_0.2-20   
    ## [25] htmltools_0.5.9     sass_0.4.10         yaml_2.3.12        
    ## [28] pillar_1.11.1       pkgdown_2.2.0       jquerylib_0.1.4    
    ## [31] ellipsis_0.3.2      R.utils_2.13.0      cachem_1.1.0       
    ## [34] sessioninfo_1.2.3   tidyselect_1.2.1    digest_0.6.39      
    ## [37] purrr_1.2.1         bookdown_0.46       paintmap_1.0       
    ## [40] fastmap_1.2.0       grid_4.6.0          cli_3.6.5          
    ## [43] magrittr_2.0.4      pkgbuild_1.4.8      utf8_1.2.6         
    ## [46] withr_3.0.2         filelock_1.0.3      rappdirs_0.3.4     
    ## [49] bit64_4.6.0-1       bit_4.6.0           otel_0.2.0         
    ## [52] ragg_1.5.1          R.methodsS3_1.8.2   memoise_2.0.1      
    ## [55] evaluate_1.0.5      knitr_1.51          BiocFileCache_3.1.0
    ## [58] rlang_1.1.7         ontologyIndex_2.12  glue_1.8.0         
    ## [61] Rgraphviz_2.55.0    BiocManager_1.30.27 BiocGenerics_0.57.0
    ## [64] pkgload_1.5.0       jsonlite_2.0.0      R6_2.6.1           
    ## [67] systemfonts_1.3.1   fs_1.6.6
