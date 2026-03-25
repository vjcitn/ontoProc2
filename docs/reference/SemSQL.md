<div id="main" class="col-md-9" role="main">

# constructor for SemSQL instance

<div class="ref-description section level2">

constructor for SemSQL instance

check aspects of SemSQL object

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
SemSQL(conn, resource)
```

</div>

</div>

<div class="section level2">

## Arguments

-   conn:

    SQLiteConnection

-   resource:

    character tag

</div>

<div class="section level2">

## Value

SemSQL instance

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
gg = retrieve_semsql_conn("go")
ngo = SemSQL(gg, "GO")
ngo
#> SemanticSQL interface for GO
#> There are 2801704 statements.
```

</div>

</div>

</div>
