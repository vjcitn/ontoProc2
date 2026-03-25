<div id="main" class="col-md-9" role="main">

# obtain graphNEL from ontology\_plot instance of ontologyPlot

<div class="ref-description section level2">

obtain graphNEL from ontology\_plot instance of ontologyPlot

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
make_graphNEL_from_ontology_plot(x)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    instance of S3 class ontology\_plot

</div>

<div class="section level2">

## Value

instance of S4 graphNEL class

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
# \donttest{
requireNamespace("Rgraphviz")
requireNamespace("graph")
clcon = retrieve_semsql_conn("cl")
cl = semsql_to_oi(clcon)
#> Warning: Some parent terms not found: BFO:0000002, BFO:0000004, SO:0000704 (16 more)
cl3k = c("CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556")
p3k = ontologyPlot::onto_plot(cl, cl3k)
gnel = make_graphNEL_from_ontology_plot(p3k)
gnel = improveNodes(gnel, cl)
graph::graph.par(list(nodes=list(shape="plaintext", cex=.8)))
gnel = Rgraphviz::layoutGraph(gnel)
Rgraphviz::renderGraph(gnel)

# }
```

</div>

</div>

</div>
