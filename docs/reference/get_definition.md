# Get the text definition for a term

Get the text definition for a term

## Usage

``` r
get_definition(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

character(1) definition text, or `NA_character_` if not found.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
get_definition(goref, "GO:0006915")
#> [1] "A programmed cell death process which begins when a cell receives an internal (e.g. DNA damage) or external signal (e.g. an extracellular death ligand), and proceeds through a series of biochemical events (signaling pathway phase) which trigger an execution phase. The execution phase is the last step of an apoptotic process, and is typically characterized by rounding-up of the cell, retraction of pseudopodes, reduction of cellular volume (pyknosis), chromatin condensation, nuclear fragmentation (karyorrhexis), plasma membrane blebbing and fragmentation of the cell into apoptotic bodies. When the execution phase is completed, the cell has died."
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
