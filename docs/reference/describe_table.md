<div id="main" class="col-md-9" role="main">

# Describe the columns of a table in a SemsqlConn database

<div class="ref-description section level2">

Describe the columns of a table in a SemsqlConn database

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
describe_table(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   table\_name:

    character(1) name of the table.

</div>

<div class="section level2">

## Value

data.frame with PRAGMA table\_info output (columns: cid, name, type,
notnull, dflt\_value, pk).

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
describe_table(goref, "rdfs_label_statement")
#>   cid      name type notnull dflt_value pk
#> 1   0    stanza TEXT       0         NA  0
#> 2   1   subject TEXT       0         NA  0
#> 3   2 predicate TEXT       0         NA  0
#> 4   3    object TEXT       0         NA  0
#> 5   4     value TEXT       0         NA  0
#> 6   5  datatype TEXT       0         NA  0
#> 7   6  language TEXT       0         NA  0
#> 8   7     graph TEXT       0         NA  0
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
