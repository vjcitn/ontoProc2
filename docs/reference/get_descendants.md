# Get all descendants of a term via entailed edges

Get all descendants of a term via entailed edges

## Usage

``` r
get_descendants(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- predicates:

  character vector of predicate CURIEs to follow. Defaults to
  `"rdfs:subClassOf"`.

- include_self:

  logical(1) whether to include the term itself (default `FALSE`).

## Value

data.frame with columns `id`, `label`, `predicate`.
