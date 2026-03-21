# Get the rdfs:label for a term

Get the rdfs:label for a term

## Usage

``` r
get_label(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE, e.g. `"CL:0000540"`.

## Value

character(1) label, or `NA_character_` if not found.
