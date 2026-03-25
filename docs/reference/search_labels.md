<div id="main" class="col-md-9" role="main">

# Search term labels in a SemsqlConn database

<div class="ref-description section level2">

Search term labels in a SemsqlConn database

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
search_labels(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

-   pattern:

    character(1) substring to match against rdfs:label values (SQL LIKE
    pattern, case-insensitive on most SQLite builds).

-   limit:

    integer(1) maximum number of rows to return (default 20).

</div>

<div class="section level2">

## Value

data.frame with columns `subject` and `label`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
search_labels(goref, "apoptosis")
#>           subject
#> 1     CHEBI:68494
#> 2     CHEBI:68495
#> 3      GO:0003377
#> 4  _:riog00109215
#> 5  _:riog00112658
#> 6      GO:0006918
#> 7      GO:0006920
#> 8      GO:0006921
#> 9      GO:0006922
#> 10     GO:0006923
#> 11 _:riog00112701
#> 12     GO:0008189
#> 13     GO:0016329
#> 14     GO:0016506
#> 15     GO:0019987
#> 16     GO:0030972
#> 17     GO:0031558
#> 18     GO:0033668
#> 19 _:riog00187929
#> 20     GO:0039526
#>                                                                                  label
#> 1                                                                  apoptosis inhibitor
#> 2                                                                    apoptosis inducer
#> 3        obsolete regulation of apoptosis by sphingosine-1-phosphate signaling pathway
#> 4                                                  Apoptosis induced DNA fragmentation
#> 5                                                                            Apoptosis
#> 6                                               obsolete induction of apoptosis by p53
#> 7                                                     obsolete commitment to apoptosis
#> 8              cellular component disassembly involved in execution phase of apoptosis
#> 9                  obsolete cleavage of lamin involved in execution phase of apoptosis
#> 10 obsolete cleavage of cytoskeletal proteins involved in execution phase of apoptosis
#> 11                                                   Influenza Virus Induced Apoptosis
#> 12                                               obsolete apoptosis inhibitor activity
#> 13                                               obsolete apoptosis regulator activity
#> 14                                               obsolete apoptosis activator activity
#> 15                                      obsolete negative regulation of anti-apoptosis
#> 16    obsolete cleavage of cytosolic proteins involved in execution phase of apoptosis
#> 17                    obsolete induction of apoptosis in response to chemical stimulus
#> 18                                     symbiont-mediated suppression of host apoptosis
#> 19                                                            Suppression of apoptosis
#> 20                                    obsolete perturbation by virus of host apoptosis
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
