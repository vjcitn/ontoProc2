<div id="main" class="col-md-9" role="main">

# Run a demonstration of SemsqlConn capabilities

<div class="ref-description section level2">

Runs a series of example queries against a `SemsqlConn` object using the
Cell Ontology neuron term (`CL:0000540`) as the example. Useful for
verifying a new connection is working correctly.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
run_demo(conn)
```

</div>

</div>

<div class="section level2">

## Arguments

-   conn:

    A `SemsqlConn` object.

</div>

<div class="section level2">

## Value

NULL invisibly, called for its side effects.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
if (FALSE) { # \dontrun{
conn <- semsql_connect(ontology = "cl")
run_demo(conn)
disconnect(conn)
} # }
```

</div>

</div>

</div>
