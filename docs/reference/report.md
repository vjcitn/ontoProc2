# Display a detailed report of a SemsqlConn object

Displays a verbose, formatted representation of a `SemsqlConn` object
including connection status, database statistics (labeled terms, edges,
definitions), prefix breakdown, and available key tables. More
informative than
[`print()`](https://github.com/vjcitn/ontoProc2/reference/print.md),
intended for interactive exploration.

## Usage

``` r
report(object, ...)
```

## Arguments

- object:

  A `SemsqlConn` object.

## Value

The `SemsqlConn` object invisibly.
