# Get direct edges in the ontology graph for a term

Get direct edges in the ontology graph for a term

## Usage

``` r
get_direct_edges(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- direction:

  character(1) one of `"outgoing"`, `"incoming"`, `"both"`.

## Value

data.frame with columns `subject`, `subject_label`, `predicate`,
`predicate_label`, `object`, `object_label`.
