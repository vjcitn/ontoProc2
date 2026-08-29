<div id="main" class="col-md-9" role="main">

# produce an ontology\_index instance from semantic sql sqlite connection

<div class="ref-description section level2">

produce an ontology\_index instance from semantic sql sqlite connection

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
semsql_to_oi(con)
```

</div>

</div>

<div class="section level2">

## Arguments

-   con:

    DBI::dbConnect value for sqlite table

</div>

<div class="section level2">

## Value

result of ontologyIndex::ontology\_index evaluated for the labels and
parent-child relations in tables statements and edge of the semantic sql
resource

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
if (FALSE) { # \dontrun{
conn <- semsql_connect(ontology = "aio")
oi <- suppressWarnings(semsql_to_oi(conn@con))
names(oi)
} # }
```

</div>

</div>

</div>
