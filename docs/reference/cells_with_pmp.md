<div id="main" class="col-md-9" role="main">

# produce a table with cells exhibiting given proteins on plasma membrane according to CL

<div class="ref-description section level2">

produce a table with cells exhibiting given proteins on plasma membrane
according to CL

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
cells_with_pmp(curies)
```

</div>

</div>

<div class="section level2">

## Arguments

-   curies:

    a character vector in format "PR:nnnnnnnnn"

</div>

<div class="section level2">

## Value

a data.frame with columns cl, celltype, pr, protein

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
cells_with_pmp(c("PR:000002064", "PR:000001874"))
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e27456c620_cl.db
#> Primary ontology prefix: CL
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/53b73763962a_pr.db
#> Primary ontology prefix: PR
#> Disconnected from '40e27456c620_cl.db'
#> Disconnected from '53b73763962a_pr.db'
#>           prtag              value         cl
#> 1  PR:000001874 KLRB1-like protein CL:0000924
#> 2  PR:000001874 KLRB1-like protein CL:0000922
#> 3  PR:000001874 KLRB1-like protein CL:0002441
#> 4  PR:000001874 KLRB1-like protein CL:0000925
#> 5  PR:000001874 KLRB1-like protein CL:0002438
#> 6  PR:000001874 KLRB1-like protein CL:4052055
#> 7  PR:000001874 KLRB1-like protein CL:0002448
#> 8  PR:000001874 KLRB1-like protein CL:0002439
#> 9  PR:000001874 KLRB1-like protein CL:0000923
#> 10 PR:000001874 KLRB1-like protein CL:0000929
#> 11 PR:000001874 KLRB1-like protein CL:0002346
#> 12 PR:000001874 KLRB1-like protein CL:0000926
#> 13 PR:000001874 KLRB1-like protein CL:0000930
#> 14 PR:000001874 KLRB1-like protein CL:0000928
#> 15 PR:000001874 KLRB1-like protein CL:0000932
#> 16 PR:000001874 KLRB1-like protein CL:0000933
#> 17 PR:000001874 KLRB1-like protein CL:0002338
#> 18 PR:000001874 KLRB1-like protein CL:0002345
#> 19 PR:000001874 KLRB1-like protein CL:0002426
#> 20 PR:000001874 KLRB1-like protein CL:0002443
#> 21 PR:000001874 KLRB1-like protein CL:0002445
#> 22 PR:000001874 KLRB1-like protein CL:0002344
#> 23 PR:000001874 KLRB1-like protein CL:0002440
#> 24 PR:000001874 KLRB1-like protein CL:0002447
#> 25 PR:000001874 KLRB1-like protein CL:0000814
#> 26 PR:000001874 KLRB1-like protein CL:0001081
#> 27 PR:000001874 KLRB1-like protein CL:0000921
#> 28 PR:000001874 KLRB1-like protein CL:0002446
#> 29 PR:000001874 KLRB1-like protein CL:0002444
#> 30 PR:000001874 KLRB1-like protein CL:0002449
#> 31 PR:000001874 KLRB1-like protein CL:0000931
#> 32 PR:000001874 KLRB1-like protein CL:0000927
#> 33 PR:000002064        macrosialin CL:4307132
#> 34 PR:000002064        macrosialin CL:4033077
#> 35 PR:000002064        macrosialin CL:0000890
#> 36 PR:000002064        macrosialin CL:0000862
#> 37 PR:000002064        macrosialin CL:1000696
#> 38 PR:000002064        macrosialin CL:4033041
#> 39 PR:000002064        macrosialin CL:0000129
#> 40 PR:000002064        macrosialin CL:0000877
#> 41 PR:000002064        macrosialin CL:1000697
#> 42 PR:000002064        macrosialin CL:1000695
#> 43 PR:000002064        macrosialin CL:0000861
#> 44 PR:000002064        macrosialin CL:0000583
#> 45 PR:000002064        macrosialin CL:0000581
#> 46 PR:000002064        macrosialin CL:0000863
#> 47 PR:000002064        macrosialin CL:4072015
#> 48 PR:000002064        macrosialin CL:0002629
#> 49 PR:000002064        macrosialin CL:0000874
#> 50 PR:000002064        macrosialin CL:4033042
#> 51 PR:000002064        macrosialin CL:0000091
#> 52 PR:000002064        macrosialin CL:0002628
#> 53 PR:000002064        macrosialin CL:0000876
#>                                                                  celltype
#> 1                             CD4-negative, CD8-negative type I NK T cell
#> 2                                                       type II NK T cell
#> 3                                CD94-positive natural killer cell, mouse
#> 4                                 activated CD4-positive type I NK T cell
#> 5                               NK1.1-positive natural killer cell, mouse
#> 6                                                 mature NK T cell, human
#> 7                               Ly49H-negative natural killer cell, mouse
#> 8                               NKGA2-positive natural killer cell, mouse
#> 9                                           CD4-positive type I NK T cell
#> 10 CD4-negative, CD8-negative type I NK T cell secreting interferon-gamma
#> 11       Dx5-negative, NK1.1-positive immature natural killer cell, mouse
#> 12               CD4-positive type I NK T cell secreting interferon-gamma
#> 13    CD4-negative, CD8-negative type I NK T cell secreting interleukin-4
#> 14                  activated CD4-negative, CD8-negative type I NK T cell
#> 15                           type II NK T cell secreting interferon-gamma
#> 16                              type II NK T cell secreting interleukin-4
#> 17      CD56-positive, CD161-positive immature natural killer cell, human
#> 18                CD27-low, CD11b-low immature natural killer cell, mouse
#> 19               CD11b-positive, CD27-positive natural killer cell, mouse
#> 20                             Ly49CI-positive natural killer cell, mouse
#> 21                              Ly49D-negative natural killer cell, mouse
#> 22      CD56-negative, CD161-positive immature natural killer cell, human
#> 23                              Ly49D-positive natural killer cell, mouse
#> 24                               CD94-negative natural killer cell, mouse
#> 25                                                       mature NK T cell
#> 26                                    group 2 innate lymphoid cell, human
#> 27                                                       type I NK T cell
#> 28                             Ly49CI-negative natural killer cell, mouse
#> 29                              Ly49H-positive natural killer cell, mouse
#> 30               CD94-positive Ly49CI-positive natural killer cell, mouse
#> 31                                            activated type II NK T cell
#> 32                  CD4-positive type I NK T cell secreting interleukin-4
#> 33                                                 microglial cell (Mmus)
#> 34                                            cycling alveolar macrophage
#> 35                                                          M2 macrophage
#> 36                                                  suppressor macrophage
#> 37                            kidney interstitial inflammatory macrophage
#> 38                                      CCL3-positive alveolar macrophage
#> 39                                                        microglial cell
#> 40                                       splenic tingible body macrophage
#> 41                              kidney interstitial suppressor macrophage
#> 42                 kidney interstitial alternatively activated macrophage
#> 43                                                    elicited macrophage
#> 44                                                    alveolar macrophage
#> 45                                                  peritoneal macrophage
#> 46                                                          M1 macrophage
#> 47                                          monocyte-derived Kupffer cell
#> 48                                                 mature microglial cell
#> 49                                            splenic red pulp macrophage
#> 50                           metallothionein-positive alveolar macrophage
#> 51                                                           Kupffer cell
#> 52                                               immature microglial cell
#> 53                                          splenic white pulp macrophage
```

</div>

</div>

</div>
