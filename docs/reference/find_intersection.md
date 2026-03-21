# Find terms that are descendants of a superclass and have a given restriction

Find terms that are descendants of a superclass and have a given
restriction

## Usage

``` r
find_intersection(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- superclass_id:

  character(1) CURIE of the superclass.

- relation_property:

  character(1) property CURIE for the restriction.

- related_to_id:

  character(1) filler CURIE for the restriction.

## Value

data.frame with columns `id` and `label`.
