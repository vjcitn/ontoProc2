# Get descendants traversing both is-a and has-part relationships

Convenience wrapper around
[`get_descendants`](https://github.com/vjcitn/ontoProc2/reference/get_descendants.md)
that follows both `rdfs:subClassOf` and `BFO:0000051` (has-part) edges.

## Usage

``` r
get_descendants_partonomy(conn, term_id, include_self = FALSE)
```

## Arguments

- conn:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- include_self:

  logical(1) whether to include the term itself (default `FALSE`).

## Value

data.frame with columns `id`, `label`, `predicate`.
