<div id="main" class="col-md-9" role="main">

# high-level use of graph/Rgraphviz for rendering ontology relations

<div class="ref-description section level2">

high-level use of graph/Rgraphviz for rendering ontology relations

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
onto_plot2(ont, terms2use, cex = 0.8, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   ont:

    instance of ontology from ontologyIndex

-   terms2use:

    character vector

-   cex:

    numeric(1) defaults to .8, supplied to Rgraphviz::graph.par

-   ...:

    passed to onto\_plot of ontologyPlot

</div>

<div class="section level2">

## Value

graphNEL instance (invisibly)

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
clcon = retrieve_semsql_conn("cl")
cl = semsql_to_oi(clcon)
#> Warning: Some parent terms not found: BFO:0000002, BFO:0000004, SO:0000704 (16 more)
cl3k = c("CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556")
onto_plot2(cl, cl3k)
```

</div>

</div>

</div>
