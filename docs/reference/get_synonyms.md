# Get synonyms for a term

Get synonyms for a term

## Usage

``` r
get_synonyms(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

- type:

  character(1) synonym scope: one of `"all"`, `"exact"`, `"broad"`,
  `"narrow"`, `"related"`.

## Value

data.frame with columns `subject`, `predicate`, `synonym`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
get_synonyms(goref, "GO:0006915")
#> [1] subject   predicate synonym  
#> <0 rows> (or 0-length row.names)
get_synonyms(goref, "GO:0006915", type = "exact")
#>      subject           predicate                            synonym
#> 1 GO:0006915 oio:hasExactSynonym               apoptotic cell death
#> 2 GO:0006915 oio:hasExactSynonym    apoptotic programmed cell death
#> 3 GO:0006915 oio:hasExactSynonym programmed cell death by apoptosis
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
