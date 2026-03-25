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
ro = semsql_connect(ontology="ro") 
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
data("tag2cn", package="ontoProc2")
cd8reg = grep("CD8-positive.*regulatory", tag2cn, value=TRUE)
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
precision

<div id="cb5" class="sourceCode">

``` r
prtab = get_present_pmp(names(cd8reg))
library(DT)
datatable(prtab)
```

</div>

<div id="htmlwidget-ac96cb3ee4656e2e9ec3"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

</div>

<div class="section level2">

## Given a protein, what cell types are asserted to possess it as a membrane part?

We pick two proteins and look for associated cell types.

<div id="cb6" class="sourceCode">

``` r
prs = c("PR:000001094", "PR:000001380")
clk = cells_with_pmp(prs)
datatable(clk)
```

</div>

<div id="htmlwidget-e5c8c404fe174e4c81bd"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

</div>

<div class="section level2">

## Some details

The “entailed edge” table of the Semantic SQL representation of Cell
Ontology includes all assertions that are derivable from base axioms of
the ontology.

<div id="cb7" class="sourceCode">

``` r
cl = semsql_connect(ontology="cl")
cl
```

</div>

    ## <SemsqlConn>  prefix: CL  | labeled terms: 22,298

<div id="cb9" class="sourceCode">

``` r
library(dplyr)
tbl(cl@con, "entailed_edge")
```

</div>

    ## # Source:   table<`entailed_edge`> [?? x 3]
    ## # Database: sqlite 3.51.2 [/Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e27456c620_cl.db]
    ##    subject        predicate       object        
    ##    <chr>          <chr>           <chr>         
    ##  1 UBERON:0001772 rdfs:subClassOf UBERON:0001772
    ##  2 UBERON:0019190 rdfs:subClassOf UBERON:0019190
    ##  3 GO:0051034     rdfs:subClassOf GO:0051033    
    ##  4 GO:0051033     rdfs:subClassOf GO:0051033    
    ##  5 GO:1904522     rdfs:subClassOf GO:1904522    
    ##  6 UBERON:0018685 rdfs:subClassOf UBERON:0018685
    ##  7 GO:0106027     rdfs:subClassOf GO:0106027    
    ##  8 GO:0050679     rdfs:subClassOf GO:0050679    
    ##  9 GO:1901647     rdfs:subClassOf GO:0050679    
    ## 10 GO:1904692     rdfs:subClassOf GO:0050679    
    ## # ℹ more rows

<div id="cb11" class="sourceCode">

``` r
tbl(cl@con, "entailed_edge") |> count()
```

</div>

    ## # Source:   SQL [?? x 1]
    ## # Database: sqlite 3.51.2 [/Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e27456c620_cl.db]
    ##         n
    ##     <int>
    ## 1 2966269

We can look for statements that have “RO:0002104” as predicate:

<div id="cb13" class="sourceCode">

``` r
tbl(cl@con, "entailed_edge") |> filter(predicate=="RO:0002104") |>
  as.data.frame() |> filter(grepl("PR:", object)) |> arrange(subject) |>
  datatable()
```

</div>

<div id="htmlwidget-36aa3d2a04d42bbc2145"
class="datatables html-widget html-fill-item"
style="width:100%;height:auto;">

</div>

</div>

</div>
