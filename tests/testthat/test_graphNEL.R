library(ontoProc2)

test_that("graphNEL functions succeed", {
 requireNamespace("Rgraphviz")
 requireNamespace("graph")
 clcon <- retrieve_semsql_conn("cl")
 expect_warning(cl <- semsql_to_oi(clcon)) # some parents not found, so warning thrown
 expect_true(inherits(cl, "ontology_index"))
 cl3k <- c(
   "CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556"
 )
 p3k <- ontologyPlot::onto_plot(cl, cl3k)
 expect_true(inherits(p3k, "ontology_plot"))
 gnel <- make_graphNEL_from_ontology_plot(p3k)
 expect_true(inherits(gnel, "graphNEL"))
 head(graph::nodes(gnel)) # before improving
 gnel <- improve_nodes(gnel, cl)
 expect_true(length(grep("alpha-beta", graph::nodes(gnel)))>0)
})

