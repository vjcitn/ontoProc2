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

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
report(goref)
#> 
#> ============================================================ 
#> SemsqlConn Object
#> ============================================================ 
#> 
#> Connection Details:
#> ---------------------------------------- 
#>   Database path:    /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db 
#>   Ontology prefix:  GO 
#>   Status:           ✓   Connected 
#> 
#> Database Statistics:
#> ---------------------------------------- 
#>   Labeled terms:    88,356 
#>   Direct edges:     214,146 
#>   Entailed edges:   9,336,957 
#>   Definitions:      55,200 
#> 
#> Terms by Prefix (top 5):
#> ---------------------------------------- 
#>   GO:              48,251
#>   CHEBI:           23,969
#>   _:               7,497
#>   UBERON:          4,783
#>   CL:              1,307
#> 
#> Key Tables Available:
#> ---------------------------------------- 
#>   ✓  rdfs_label_statement 
#>   ✓  has_text_definition_statement 
#>   ✓  edge 
#>   ✓  entailed_edge 
#>   ✓  rdfs_subclass_of_statement 
#>   ✓  owl_some_values_from 
#>   ✓  has_oio_synonym_statement 
#> 
#> ============================================================ 
#> Use methods like search_labels(), get_ancestors(), etc.
#> Run ?SemsqlConn for documentation.
#> ============================================================ 
#> 
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
