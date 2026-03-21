# Count labeled terms grouped by CURIE prefix

Count labeled terms grouped by CURIE prefix

## Usage

``` r
count_by_prefix(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

## Value

data.frame with columns `prefix` and `n`, ordered by `n` descending.
