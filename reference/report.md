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

## S7 method for class <ontoProc2::SemsqlConn>
report(object, ...)
```

## Arguments

- object:

  A `SemsqlConn` object.

- ...:

  additional arguments (currently unused)

## Value

The `SemsqlConn` object invisibly.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/51f25f664001_go.db
#> Primary ontology prefix: GO
report(goref)
#> 
#> ============================================================ 
#> SemsqlConn Object
#> ============================================================ 
#> 
#> Connection Details:
#> ---------------------------------------- 
#>   Database path:    /home/runner/.cache/R/BiocFileCache/51f25f664001_go.db 
#>   Ontology prefix:  GO 
#>   Status:           ✓   Connected 
#> 
#> Database Statistics:
#> ---------------------------------------- 
#>   Labeled terms:    88,849 
#>   Direct edges:     213,852 
#>   Entailed edges:   9,314,992 
#>   Definitions:      55,240 
#> 
#> Terms by Prefix (top 5):
#> ---------------------------------------- 
#>   GO:              48,291
#>   CHEBI:           24,009
#>   _:               7,910
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
#> Disconnected from '51f25f664001_go.db'
```
