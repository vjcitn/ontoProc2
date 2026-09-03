# ggraph/graphlayouts-based alternatives to onto_plot2 (Rgraphviz-free)

#' Visual parameters for ggraph-based ontology plots
#'
#' Returns a named list of default visual parameters consumed by
#' `onto_plot2_sugiyama` and `onto_plot2_stress`. Modify individual fields
#' before passing to control the appearance without touching every argument.
#'
#' @param label_size numeric(1) node label text size, default 3
#' @param edge_colour character(1) edge colour, default "grey60"
#' @param arrow_length_mm numeric(1) arrowhead length in mm, default 3
#' @param end_cap_mm numeric(1) radius mm of circular buffer at arrow tip
#'   (controls clearance between arrowhead and node text), default 10
#' @param node_colour character(1) node text colour, default "black"
#' @param bg_fill character(1) plot background fill colour, default "white"
#' @param arc_strength numeric(1) curvature of arcs in stress layout
#'   (0 = straight), default 0.15
#' @param node_fill character(1) fill colour for node label boxes in stress
#'   layout, default "steelblue"
#' @param label_corner_r numeric(1) corner rounding radius in lines for node
#'   label boxes in stress layout, default 0.3
#' @return named list of visual parameters
#' @examples
#' p <- onto_plot2_params()
#' p$end_cap_mm <- 14
#' p$edge_colour <- "navy"
#' clcon <- retrieve_semsql_conn("cl")
#' cl <- semsql_to_oi(clcon)
#' cl3k <- c(
#'   "CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
#'   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556"
#' )
#' onto_plot2_sugiyama(cl, cl3k, params = p)
#' @export
onto_plot2_params <- function(
    label_size = 3,
    edge_colour = "grey60",
    arrow_length_mm = 3,
    end_cap_mm = 10,
    node_colour = "black",
    bg_fill = "white",
    arc_strength = 0.15,
    node_fill = "steelblue",
    label_corner_r = 0.3) {
  list(
    label_size = label_size,
    edge_colour = edge_colour,
    arrow_length_mm = arrow_length_mm,
    end_cap_mm = end_cap_mm,
    node_colour = node_colour,
    bg_fill = bg_fill,
    arc_strength = arc_strength,
    node_fill = node_fill,
    label_corner_r = label_corner_r
  )
}

#' Convert an ontology_plot instance to an igraph object
#' @importFrom igraph graph_from_adjacency_matrix V V<-
#' @param x instance of S3 class ontology_plot (from ontologyPlot::onto_plot)
#' @return an igraph directed graph
#' @examples
#' requireNamespace("igraph")
#' clcon <- retrieve_semsql_conn("cl")
#' cl <- semsql_to_oi(clcon)
#' cl3k <- c(
#'   "CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
#'   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556"
#' )
#' p3k <- ontologyPlot::onto_plot(cl, cl3k)
#' ig <- make_igraph_from_ontology_plot(p3k)
#' ig
#' @export
make_igraph_from_ontology_plot <- function(x) {
  igraph::graph_from_adjacency_matrix(
    x[["adjacency_matrix"]],
    mode = "directed"
  )
}

#' Add term labels as a vertex attribute to an ontology igraph
#' @importFrom igraph V V<-
#' @param g igraph directed graph whose vertex names are ontology term IDs
#' @param ont ontology_index instance (from ontologyIndex)
#' @param sep character(1) separator between term name and ID, defaults to "\n"
#' @return igraph with a "label" vertex attribute
#' @examples
#' requireNamespace("igraph")
#' clcon <- retrieve_semsql_conn("cl")
#' cl <- semsql_to_oi(clcon)
#' cl3k <- c(
#'   "CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
#'   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556"
#' )
#' p3k <- ontologyPlot::onto_plot(cl, cl3k)
#' ig <- make_igraph_from_ontology_plot(p3k)
#' ig <- label_igraph_nodes(ig, cl)
#' igraph::V(ig)$label
#' @export
label_igraph_nodes <- function(g, ont, sep = "\n") {
  ids <- igraph::V(g)$name
  term_names <- ont$name[ids]
  igraph::V(g)$label <- paste0(term_names, sep, ids)
  g
}

#' Plot ontology relations using ggraph with a Sugiyama (hierarchical) layout
#'
#' Produces a ggplot2-based directed graph using ggraph and igraph's Sugiyama
#' layout, which respects the DAG structure of ontology hierarchies.
#' Visual parameters are controlled via `onto_plot2_params()`.
#'
#' @importFrom igraph graph_from_adjacency_matrix V V<-
#' @import ggraph
#' @import ggplot2
#' @param ont ontology_index instance (from ontologyIndex / semsql_to_oi)
#' @param terms2use character vector of ontology term IDs to include
#' @param params named list of visual parameters from `onto_plot2_params()`
#' @param ... passed to ontologyPlot::onto_plot
#' @return a ggplot object (printed as a side effect); the igraph is returned
#'   invisibly
#' @examples
#' clcon <- retrieve_semsql_conn("cl")
#' cl <- semsql_to_oi(clcon)
#' cl3k <- c(
#'   "CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
#'   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556"
#' )
#' onto_plot2_sugiyama(cl, cl3k)
#' @export
onto_plot2_sugiyama <- function(ont, terms2use, params = onto_plot2_params(),
                                ...) {
  pl <- ontologyPlot::onto_plot(ont, terms2use, ...)
  g <- make_igraph_from_ontology_plot(pl)
  g <- label_igraph_nodes(g, ont)
  p <- ggraph::ggraph(g, layout = "sugiyama") +
    ggraph::geom_edge_link(
      colour = params$edge_colour,
      arrow = grid::arrow(
        length = grid::unit(params$arrow_length_mm, "mm"),
        type = "closed"
      ),
      end_cap = ggraph::circle(params$end_cap_mm, "mm")
    ) +
    ggraph::geom_node_text(
      ggplot2::aes(label = .data$label),
      size = params$label_size,
      colour = params$node_colour
    ) +
    ggplot2::theme_void() +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = params$bg_fill,
                                              colour = NA)
    )
  print(p)
  invisible(g)
}

#' Plot ontology relations using ggraph with a stress-minimisation layout
#'
#' Produces a ggplot2-based directed graph using ggraph and the
#' graphlayouts stress layout, which places nodes to minimise visual stress.
#' Useful when the hierarchy is shallow or you prefer a force-directed look.
#' Visual parameters are controlled via `onto_plot2_params()`.
#'
#' @importFrom igraph graph_from_adjacency_matrix V V<-
#' @import ggraph
#' @import ggplot2
#' @importFrom graphlayouts layout_with_stress
#' @param ont ontology_index instance (from ontologyIndex / semsql_to_oi)
#' @param terms2use character vector of ontology term IDs to include
#' @param params named list of visual parameters from `onto_plot2_params()`
#' @param ... passed to ontologyPlot::onto_plot
#' @return a ggplot object (printed as a side effect); the igraph is returned
#'   invisibly
#' @examples
#' clcon <- retrieve_semsql_conn("cl")
#' cl <- semsql_to_oi(clcon)
#' cl3k <- c(
#'   "CL:0000492", "CL:0001054", "CL:0000236", "CL:0000625",
#'   "CL:0000576", "CL:0000623", "CL:0000451", "CL:0000556"
#' )
#' onto_plot2_stress(cl, cl3k)
#' @export
onto_plot2_stress <- function(ont, terms2use, params = onto_plot2_params(),
                              ...) {
  pl <- ontologyPlot::onto_plot(ont, terms2use, ...)
  g <- make_igraph_from_ontology_plot(pl)
  g <- label_igraph_nodes(g, ont)
  p <- ggraph::ggraph(g, layout = "stress") +
    ggraph::geom_edge_arc(
      colour = params$edge_colour,
      arrow = grid::arrow(
        length = grid::unit(params$arrow_length_mm, "mm"),
        type = "closed"
      ),
      end_cap = ggraph::circle(params$end_cap_mm, "mm"),
      strength = params$arc_strength
    ) +
    ggraph::geom_node_label(
      ggplot2::aes(label = .data$label),
      size = params$label_size,
      fill = params$node_fill,
      colour = params$node_colour,
      label.r = grid::unit(params$label_corner_r, "lines")
    ) +
    ggplot2::theme_void() +
    ggplot2::theme(
      plot.background = ggplot2::element_rect(fill = params$bg_fill,
                                              colour = NA)
    )
  print(p)
  invisible(g)
}
