# Get synonyms for a term

Get synonyms for a term

## Usage

``` r
get_synonyms(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- type:

  character(1) synonym scope: one of `"all"`, `"exact"`, `"broad"`,
  `"narrow"`, `"related"`.

## Value

data.frame with columns `subject`, `predicate`, `synonym`.
