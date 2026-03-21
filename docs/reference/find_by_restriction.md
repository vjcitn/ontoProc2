# Find terms that have a given OWL someValuesFrom restriction

Find terms that have a given OWL someValuesFrom restriction

## Usage

``` r
find_by_restriction(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- property:

  character(1) property CURIE (e.g. `"BFO:0000050"` for part-of).

- filler:

  character(1) filler class CURIE.

- include_filler_descendants:

  logical(1) if TRUE also match subclasses of `filler` (default
  `FALSE`).

## Value

data.frame with columns `id` and `label`.
