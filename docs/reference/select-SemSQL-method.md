# emulate AnnotationDbi

emulate AnnotationDbi

## Usage

``` r
# S4 method for class 'SemSQL'
select(x, keys, columns, keytype = "GOID", ...)
```

## Arguments

- x:

  instance of SemSQL

- keys:

  vector of elements of the appropriate type

- columns:

  vector of desired output columns

- keytype:

  character(1) defaults to 'GOID'

- ...:

  not used

## Value

a table

## Examples

``` r
gg = retrieve_semsql_conn("go")
ngo = SemSQL(gg, "GO")
ngo
#> SemanticSQL interface for GO
#> There are 2801704 statements.
validObject(ngo)
#> [1] TRUE
select(ngo, keys=c("GO:0018942", "GO:0000003"), columns=c("DEFINITION", "TERM", "ONTOLOGY"))
#> # Source:   SQL [?? x 4]
#> # Database: sqlite 3.51.2 [/home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db]
#>   GOID       DEFINITION                                           TERM  ONTOLOGY
#>   <chr>      <chr>                                                <chr> <chr>   
#> 1 GO:0000003 OBSOLETE. The production of new individuals that co… obso… biologi…
#> 2 GO:0018942 The chemical reactions and pathways involving organ… orga… biologi…
```
