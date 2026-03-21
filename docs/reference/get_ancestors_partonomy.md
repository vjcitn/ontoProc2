# Get ancestors traversing both is-a and part-of relationships

Convenience wrapper around
[`get_ancestors`](https://github.com/vjcitn/ontoProc2/reference/get_ancestors.md)
that follows both `rdfs:subClassOf` and `BFO:0000050` (part-of) edges.

## Usage

``` r
get_ancestors_partonomy(conn, term_id, include_self = FALSE)
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
