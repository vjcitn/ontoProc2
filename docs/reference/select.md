<div id="main" class="col-md-9" role="main">

# emulate the AnnotationDbi select method

<div class="ref-description section level2">

emulate the AnnotationDbi select method

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
select(x, keys, columns, keytype = "GOID", ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    instance of SemSQL

-   keys:

    vector of elements of the appropriate type

-   columns:

    vector of desired output columns

-   keytype:

    character(1) defaults to 'GOID'

-   ...:

    not used

</div>

<div class="section level2">

## Value

standardGeneric

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
example("select,SemSQL-method")
#> 
#> s,SSQL> gg = retrieve_semsql_conn("go")
#> 
#> s,SSQL> ngo = SemSQL(gg, "GO")
#> 
#> s,SSQL> ngo
#> SemanticSQL interface for GO
#> There are 2801704 statements.
#> 
#> s,SSQL> validObject(ngo)
#> [1] TRUE
#> 
#> s,SSQL> select(ngo, keys=c("GO:0018942", "GO:0000003"), columns=c("DEFINITION", "TERM", "ONTOLOGY"))
#> # Source:   SQL [?? x 4]
#> # Database: sqlite 3.51.2 [/home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db]
#>   GOID       DEFINITION                                           TERM  ONTOLOGY
#>   <chr>      <chr>                                                <chr> <chr>   
#> 1 GO:0000003 OBSOLETE. The production of new individuals that co… obso… biologi…
#> 2 GO:0018942 The chemical reactions and pathways involving organ… orga… biologi…
```

</div>

</div>

</div>
