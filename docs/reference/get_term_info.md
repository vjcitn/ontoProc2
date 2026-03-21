# Retrieve a summary of information about a term

Retrieve a summary of information about a term

## Usage

``` r
get_term_info(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

list with elements `id`, `label`, `definition`, `synonyms`,
`superclasses`, `subclasses`.
