# Count the number of descendants of a term

Count the number of descendants of a term

## Usage

``` r
count_descendants(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- predicate:

  character(1) predicate to traverse (default `"rdfs:subClassOf"`).

## Value

integer(1).
