# Run a demonstration of SemsqlConn capabilities

Runs a series of example queries against a `SemsqlConn` object using the
Cell Ontology neuron term (`CL:0000540`) as the example. Useful for
verifying a new connection is working correctly.

## Usage

``` r
run_demo(conn)
```

## Arguments

- conn:

  A `SemsqlConn` object.

## Value

NULL invisibly, called for its side effects.

## Examples

``` r
if (FALSE) { # \dontrun{
conn <- semsql_connect(ontology = "cl")
run_demo(conn)
disconnect(conn)
} # }
```
