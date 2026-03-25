<div id="main" class="col-md-9" role="main">

# Display a detailed report of a SemsqlConn object

<div class="ref-description section level2">

Displays a verbose, formatted representation of a `SemsqlConn` object
including connection status, database statistics (labeled terms, edges,
definitions), prefix breakdown, and available key tables. More
informative than `print()`, intended for interactive exploration.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
report(object, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   object:

    A `SemsqlConn` object.

</div>

<div class="section level2">

## Value

The `SemsqlConn` object invisibly.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
report(goref)
#> 
#> ============================================================ 
#> SemsqlConn Object
#> ============================================================ 
#> 
#> Connection Details:
#> ---------------------------------------- 
#>   Database path:    /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db 
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
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
