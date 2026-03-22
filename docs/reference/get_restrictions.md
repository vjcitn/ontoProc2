# Get OWL someValuesFrom restrictions for a term

Get OWL someValuesFrom restrictions for a term

## Usage

``` r
get_restrictions(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- term_id:

  character(1) CURIE.

## Value

data.frame with columns `restriction_id`, `property`, `property_label`,
`filler`, `filler_label`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
# mitochondrion (GO:0005739) has part-of restrictions to cell
get_restrictions(goref, "GO:0005739")
#>   restriction_id    property property_label         filler filler_label
#> 1 _:riog00106045 BFO:0000050        part of     GO:0005737    cytoplasm
#> 2 _:riog00106045 BFO:0000050        part of     GO:0005737    cytoplasm
#> 3 _:riog00106046  RO:0002162       in taxon NCBITaxon:2759    Eukaryota
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
