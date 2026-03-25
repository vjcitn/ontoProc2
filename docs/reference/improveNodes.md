<div id="main" class="col-md-9" role="main">

# inject linefeeds for node names for graph, with textual annotation from ontology

<div class="ref-description section level2">

inject linefeeds for node names for graph, with textual annotation from
ontology

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
improveNodes(g, ont)
```

</div>

</div>

<div class="section level2">

## Arguments

-   g:

    graphNEL instance

-   ont:

    instance of ontology from ontologyIndex

</div>

<div class="section level2">

## Value

graphNEL instance

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
requireNamespace("Rgraphviz")
requireNamespace("graph")
clcon = retrieve_semsql_conn("cl")
cl = semsql_to_oi(clcon)
#> Warning: Some parent terms not found: BFO:0000002, BFO:0000004, SO:0000704 (16 more)
cl3k = c("CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556")
p3k = ontologyPlot::onto_plot(cl, cl3k)
gnel = make_graphNEL_from_ontology_plot(p3k)
head(graph::nodes(gnel)) # before improving
#> [1] "CL:0000255" "CL:0000988" "CL:0000842" "CL:0000542" "CL:0000791"
#> [6] "CL:0000492"
gnel = improveNodes(gnel, cl)
head(graph::nodes(gnel))
#> [1] "eukaryotic\ncell\nCL:0000255"           
#> [2] "hematopoietic\ncell\nCL:0000988"        
#> [3] "mononuclear\nleukocyte\nCL:0000842"     
#> [4] "lymphocyte\nCL:0000542"                 
#> [5] "mature\nalpha-beta T cell\nCL:0000791"  
#> [6] "CD4-positive\nhelper T cell\nCL:0000492"
```

</div>

</div>

</div>
