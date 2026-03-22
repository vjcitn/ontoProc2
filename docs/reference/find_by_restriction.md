# Find terms that have a given OWL someValuesFrom restriction

Find terms that have a given OWL someValuesFrom restriction

## Usage

``` r
find_by_restriction(x, ...)
```

## Arguments

- x:

  A `SemsqlConn` object.

- property:

  character(1) property CURIE (e.g. `"BFO:0000050"` for part-of).

- filler:

  character(1) filler class CURIE.

- include_filler_descendants:

  logical(1) if TRUE also match subclasses of `filler` (default
  `FALSE`).

## Value

data.frame with columns `id` and `label`.

## Examples

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /home/vincent/.cache/R/BiocFileCache/b24227f056f7_go.db
#> Primary ontology prefix: GO
# cellular components that are part_of nucleus (GO:0005634)
find_by_restriction(goref, "BFO:0000050", "GO:0005634")
#>            id                              label
#> 1  GO:0046818                 dense nuclear body
#> 2  GO:0140510             mitotic nuclear bridge
#> 3  GO:0005635                   nuclear envelope
#> 4  GO:0042405             nuclear inclusion body
#> 5  GO:0031981                      nuclear lumen
#> 6  GO:0005880                nuclear microtubule
#> 7  GO:0140513 nuclear protein-containing complex
#> 8  GO:0110093               nucleus lagging edge
#> 9  GO:0110092               nucleus leading edge
#> 10 GO:0000943       retrotransposon nucleocapsid
disconnect(goref)
#> Disconnected from 'b24227f056f7_go.db'
```
