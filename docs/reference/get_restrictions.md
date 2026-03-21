# Get OWL someValuesFrom restrictions for a term

Get OWL someValuesFrom restrictions for a term

## Usage

``` r
get_restrictions(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

data.frame with columns `restriction_id`, `property`, `property_label`,
`filler`, `filler_label`.
