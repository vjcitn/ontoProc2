# Get all ancestors of a term via entailed edges

Get all ancestors of a term via entailed edges

## Usage

``` r
get_ancestors(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- predicates:

  character vector of predicate CURIEs to follow. Defaults to
  `"rdfs:subClassOf"`. See
  [`PREDICATES`](https://github.com/vjcitn/ontoProc2/reference/PREDICATES.md)
  for common values.

- include_self:

  logical(1) whether to include the term itself (default `FALSE`).

## Value

data.frame with columns `id`, `label`, `predicate`.

## Examples

``` r
if (FALSE) { # \dontrun{
conn <- semsql_connect(ontology = "cl")
get_ancestors(conn, "CL:0000540")
disconnect(conn)
} # }
```
