# produce a table with list of proteins from protein ontology identified as present on cell membranes for input cell type CURIEs

produce a table with list of proteins from protein ontology identified
as present on cell membranes for input cell type CURIEs

## Usage

``` r
get_present_pmp(curies)
```

## Arguments

- curies:

  a character vector in format "CL:nnnnnnn"

## Value

a data.frame with columns cl, celltype, pr, protein

## Examples

``` r
get_present_pmp(c("CL:0000091", "CL:0000926"))
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/19c5423265f_cl.db
#> Primary ontology prefix: CL
#> Connected to SemanticSQL database: /home/runner/.cache/R/BiocFileCache/19c5228fc1b5_pr.db
#> Primary ontology prefix: PR
#> Disconnected from '19c5423265f_cl.db'
#> Disconnected from '19c5228fc1b5_pr.db'
#>            cl                                                 celltype
#> 1  CL:0000091                                             Kupffer cell
#> 2  CL:0000091                                             Kupffer cell
#> 3  CL:0000091                                             Kupffer cell
#> 4  CL:0000091                                             Kupffer cell
#> 5  CL:0000091                                             Kupffer cell
#> 6  CL:0000091                                             Kupffer cell
#> 7  CL:0000091                                             Kupffer cell
#> 8  CL:0000091                                             Kupffer cell
#> 9  CL:0000091                                             Kupffer cell
#> 10 CL:0000091                                             Kupffer cell
#> 11 CL:0000926 CD4-positive type I NK T cell secreting interferon-gamma
#> 12 CL:0000926 CD4-positive type I NK T cell secreting interferon-gamma
#> 13 CL:0000926 CD4-positive type I NK T cell secreting interferon-gamma
#>              pr                                              protein
#> 1  PR:000001005                         integrin alpha with A domain
#> 2  PR:000001012                                     integrin alpha-M
#> 3  PR:000001087                  adhesion G-protein coupled receptor
#> 4  PR:000001813               adhesion G protein-coupled receptor E1
#> 5  PR:000001883                 lysosome-associated membrane protein
#> 6  PR:000001925 scavenger receptor cysteine-rich type 1 protein M130
#> 7  PR:000002064                                          macrosialin
#> 8  PR:000018263                                     amino acid chain
#> 9  PR:000025796                                       integrin alpha
#> 10 PR:000030035                           G-protein coupled receptor
#> 11 PR:000001004                                         CD4 molecule
#> 12 PR:000001874                                   KLRB1-like protein
#> 13 PR:000018263                                     amino acid chain
```
