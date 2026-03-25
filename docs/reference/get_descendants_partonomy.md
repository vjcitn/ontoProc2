<div id="main" class="col-md-9" role="main">

# Get descendants traversing both is-a and has-part relationships

<div class="ref-description section level2">

Convenience wrapper around `get_descendants` that follows both
`rdfs:subClassOf` and `BFO:0000051` (has-part) edges.

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
get_descendants_partonomy(conn, term_id, include_self = FALSE)
```

</div>

</div>

<div class="section level2">

## Arguments

-   conn:

    A `SemsqlConn` object.

-   term\_id:

    character(1) CURIE.

-   include\_self:

    logical(1) whether to include the term itself (default `FALSE`).

</div>

<div class="section level2">

## Value

data.frame with columns `id`, `label`, `predicate`.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
get_descendants_partonomy(goref, "GO:0005634")  # nucleus sub-components
#>                 id
#> 1       CL:0000236
#> 2       CL:0001201
#> 3       CL:0000819
#> 4       CL:0000820
#> 5       CL:0000821
#> 6       CL:0000822
#> 7       CL:0002113
#> 8       CL:0002123
#> 9       CL:0002110
#> 10      CL:0002116
#> 11      CL:0002112
#> 12      CL:0002122
#> 13      CL:0002109
#> 14      CL:0002115
#> 15      CL:0000968
#> 16      CL:0000943
#> 17      CL:0000944
#> 18      CL:0000961
#> 19      CL:0000962
#> 20      CL:0000964
#> 21      CL:0000965
#> 22      CL:0000963
#> 23      CL:0000966
#> 24      CL:0000967
#> 25      CL:0001022
#> 26      CL:0002465
#> 27      CL:0000989
#> 28      CL:0002396
#> 29      CL:0001054
#> 30      CL:0001055
#> 31      CL:0002397
#> 32      CL:0002532
#> 33      CL:0002037
#> 34      CL:0002121
#> 35      CL:0002120
#> 36      CL:0002432
#> 37      CL:0002434
#> 38      CL:0002126
#> 39      CL:0002125
#> 40      CL:0002124
#> 41      CL:0002108
#> 42      CL:0002118
#> 43      CL:0002102
#> 44      CL:0002111
#> 45      CL:0002105
#> 46      CL:0002119
#> 47      CL:0002101
#> 48      CL:0002114
#> 49      CL:0002430
#> 50      CL:0000803
#> 51      CL:0002454
#> 52      CL:0000924
#> 53      CL:0000929
#> 54      CL:0000930
#> 55      CL:0000492
#> 56      CL:0000923
#> 57      CL:0000926
#> 58      CL:0000927
#> 59      CL:0000792
#> 60      CL:0002431
#> 61      CL:0001051
#> 62      CL:0000624
#> 63      CL:0000934
#> 64      CL:0000793
#> 65      CL:0000897
#> 66      CL:0000810
#> 67      CL:0002344
#> 68      CL:0002338
#> 69      CL:0002429
#> 70      CL:0002433
#> 71      CL:0002435
#> 72      CL:0002016
#> 73      CL:0002018
#> 74      CL:0000802
#> 75      CL:0000915
#> 76      CL:0000796
#> 77      CL:0002455
#> 78      CL:0002460
#> 79      CL:0002456
#> 80      CL:0002059
#> 81      CL:0001052
#> 82      CL:0001041
#> 83      CL:0000625
#> 84      CL:0000908
#> 85      CL:0000794
#> 86      CL:0000909
#> 87      CL:0000795
#> 88      CL:0000811
#> 89      CL:0001202
#> 90      CL:0000806
#> 91      CL:0002423
#> 92      CL:0002424
#> 93      CL:0000807
#> 94      CL:0000808
#> 95      CL:0002346
#> 96      CL:0002478
#> 97      CL:0002479
#> 98      CL:0002013
#> 99      CL:0002395
#> 100     CL:0002058
#> 101     CL:0002398
#> 102     CL:0000973
#> 103     CL:0000987
#> 104     CL:0000984
#> 105     CL:0000976
#> 106     CL:0000949
#> 107     CL:0002107
#> 108     CL:0001053
#> 109     CL:0002106
#> 110     CL:0000948
#> 111     CL:0000947
#> 112     CL:0000950
#> 113     CL:0000951
#> 114     CL:0000979
#> 115     CL:0000985
#> 116     CL:0000982
#> 117     CL:0000977
#> 118     CL:0002117
#> 119     CL:0002104
#> 120     CL:0002103
#> 121     CL:0000971
#> 122     CL:0000986
#> 123     CL:0000983
#> 124     CL:0000978
#> 125     CL:0002014
#> 126     CL:0002017
#> 127     CL:0002015
#> 128     CL:0000453
#> 129     CL:0002473
#> 130     CL:0002472
#> 131     CL:0002469
#> 132     CL:0002471
#> 133     CL:0002470
#> 134 UBERON:0001211
#> 135     CL:0002402
#> 136 UBERON:0010386
#> 137 UBERON:0004697
#> 138     CL:0009014
#> 139     CL:0002464
#> 140     CL:0002463
#> 141     CL:0000084
#> 142     CL:0002038
#> 143     CL:0000545
#> 144     CL:0000899
#> 145     CL:0000546
#> 146     CL:0001042
#> 147     CL:0000958
#> 148     CL:0000959
#> 149     CL:0000960
#> 150     CL:4030058
#> 151     CL:0000918
#> 152     CL:0000901
#> 153     CL:0000928
#> 154     CL:0000925
#> 155     CL:0000896
#> 156     CL:0000906
#> 157     CL:0000931
#> 158     CL:0002462
#> 159     CL:0002477
#> 160     CL:0017509
#> 161     CL:0000789
#> 162     CL:0000797
#> 163     CL:0000946
#> 164     GO:0043079
#> 165     GO:1905754
#> 166     CL:0000770
#> 167     CL:0000774
#> 168     CL:0017506
#> 169     CL:0000549
#> 170     CL:0000769
#> 171     CL:0000614
#> 172     CL:0000227
#> 173 UBERON:0004749
#> 174     CL:0002476
#> 175 UBERON:0001963
#> 176 UBERON:0013478
#> 177     CL:0000878
#> 178 UBERON:0009114
#> 179 UBERON:0005206
#> 180     CL:0000972
#> 181     CL:0000860
#> 182     CL:0009038
#> 183     CL:0000990
#> 184 UBERON:0002123
#> 185     CL:0000910
#> 186     CL:0000451
#> 187     CL:0000916
#> 188     CL:0011024
#> 189     CL:0000981
#> 190     CL:0002489
#> 191     CL:0002428
#> 192     CL:0000809
#> 193     CL:0001044
#> 194     CL:0001050
#> 195     CL:0000911
#> 196     CL:0000861
#> 197     CL:0000773
#> 198     CL:0000612
#> 199     CL:0002457
#> 200 UBERON:0012069
#> 201     CL:0000765
#> 202     CL:0011025
#> 203     CL:0008046
#> 204     GO:0001674
#> 205     GO:0001939
#> 206     CL:0002404
#> 207     CL:0000843
#> 208 UBERON:0006340
#> 209     CL:0002047
#> 210     CL:0002400
#> 211     CL:0002049
#> 212     CL:0002050
#> 213     CL:0002052
#> 214     CL:0002054
#> 215     CL:0002056
#> 216     CL:0000798
#> 217     CL:0000801
#> 218     CL:0002405
#> 219     CL:0000486
#> 220     GO:0048555
#> 221     GO:0043073
#> 222 UBERON:0010754
#> 223     CL:0000844
#> 224     GO:0042585
#> 225     CL:0001067
#> 226     CL:0001069
#> 227     CL:0001071
#> 228 UBERON:0001962
#> 229     CL:0000912
#> 230     CL:0000816
#> 231     CL:0000992
#> 232     CL:0002533
#> 233     CL:0000914
#> 234     CL:0002039
#> 235     CL:0002040
#> 236     CL:0002041
#> 237     CL:0002042
#> 238     CL:0002420
#> 239     CL:0000790
#> 240     CL:0000768
#> 241     CL:0000840
#> 242     CL:0002218
#> 243     CL:0000772
#> 244     CL:0000799
#> 245     CL:0001082
#> 246     CL:0000823
#> 247     CL:0000776
#> 248     CL:0000805
#> 249     CL:0000863
#> 250     CL:0002127
#> 251     CL:0001065
#> 252     CL:0002393
#> 253     CL:0002496
#> 254     CL:0002507
#> 255 UBERON:0003453
#> 256     CL:0000957
#> 257 UBERON:0006338
#> 258     GO:0097571
#> 259 UBERON:0018117
#> 260     CL:2000055
#> 261     CL:0000974
#> 262     CL:1001603
#> 263 UBERON:0010748
#> 264 UBERON:0009039
#> 265 UBERON:0010420
#> 266 UBERON:0010395
#> 267 UBERON:0010753
#> 268     CL:0000542
#> 269     CL:0000945
#> 270     CL:0001200
#> 271     CL:0002474
#> 272     CL:0002475
#> 273 UBERON:0000444
#> 274 UBERON:0001744
#> 275     GO:0031039
#> 276     CL:0000235
#> 277     GO:0001673
#> 278     GO:0001940
#> 279     CL:0000845
#> 280     CL:0000785
#> 281     CL:0000993
#> 282     CL:0002534
#> 283     CL:0002436
#> 284     CL:0002437
#> 285     CL:0000814
#> 286     CL:0002419
#> 287     CL:0000791
#> 288     CL:0000043
#> 289     CL:0000841
#> 290     CL:0002401
#> 291     CL:0000800
#> 292     CL:0002629
#> 293     CL:0000096
#> 294     GO:0043082
#> 295     GO:0043076
#> 296     CL:0000787
#> 297     CL:0000813
#> 298     CL:0002678
#> 299     CL:0000777
#> 300     CL:0000129
#> 301     GO:0031040
#> 302     GO:0048556
#> 303     CL:0000576
#> 304     CL:0000842
#> 305     CL:0010004
#> 306     CL:2000085
#> 307     CL:0000781
#> 308     CL:0000778
#> 309     CL:0000113
#> 310 UBERON:0001961
#> 311     CL:0000940
#> 312     CL:0000780
#> 313     CL:0000779
#> 314     CL:0000228
#> 315     CL:0000647
#> 316     CL:0000783
#> 317     CL:0000782
#> 318     CL:4052024
#> 319     CL:0002372
#> 320     CL:0000788
#> 321     CL:0000898
#> 322     CL:0000895
#> 323     CL:0000900
#> 324 UBERON:0012330
#> 325     CL:0002679
#> 326     CL:0000623
#> 327     CL:4052025
#> 328     CL:0000875
#> 329     CL:0000762
#> 331     CL:0000552
#> 332     CL:4033087
#> 333     CL:0000786
#> 334     CL:0000980
#> 335     CL:0000784
#> 336     GO:0043078
#> 337     CL:0000550
#> 338     CL:0000956
#> 339     CL:0000955
#> 340     CL:0000937
#> 341     CL:0000953
#> 342     CL:0000952
#> 343     CL:0000817
#> 344     GO:0048353
#> 345 UBERON:0010422
#> 346     GO:0045120
#> 347     CL:0000815
#> 348 UBERON:0005270
#> 349     CL:0017507
#> 350     CL:0002427
#> 351     GO:0097572
#> 352 UBERON:0018118
#> 353 UBERON:0010755
#> 354 UBERON:0001745
#> 355     CL:0000975
#> 356     CL:0000226
#> 357     CL:0008002
#> 358     CL:0000189
#> 359 UBERON:0006907
#> 360 UBERON:0003454
#> 361     CL:0000954
#> 362     CL:0008003
#> 363 UBERON:0010421
#> 364 UBERON:0005196
#> 365 UBERON:0001249
#> 366 UBERON:0004041
#> 367 UBERON:0004042
#> 368     CL:0000862
#> 369     CL:4052002
#> 370     CL:0000525
#> 371 UBERON:0006339
#> 372 UBERON:0009115
#> 373     CL:0000828
#> 374     CL:0000941
#> 375     CL:0000866
#> 376     CL:0000942
#> 377     CL:0000893
#> 378 UBERON:0002370
#> 379 UBERON:0003988
#> 380 UBERON:0002125
#> 381 UBERON:0003483
#> 382     CL:0000864
#> 383     CL:0002673
#> 384     CL:0000818
#> 385     CL:0000921
#> 386     CL:0000922
#> 387     CL:0000932
#> 388     CL:0000933
#> 389     CL:0000970
#> 390     CL:4052028
#> 391     CL:4033064
#>                                                                           label
#> 1                                                                        B cell
#> 2                                                         B cell, CD19-positive
#> 3                                                                    B-1 B cell
#> 4                                                                   B-1a B cell
#> 5                                                                   B-1b B cell
#> 6                                                                    B-2 B cell
#> 7                               B220-low CD38-negative unswitched memory B cell
#> 8              B220-low CD38-positive IgG-negative class switched memory B cell
#> 9                                           B220-low CD38-positive naive B cell
#> 10                              B220-low CD38-positive unswitched memory B cell
#> 11                         B220-positive CD38-negative unswitched memory B cell
#> 12        B220-positive CD38-positive IgG-negative class switched memory B cell
#> 13                                     B220-positive CD38-positive naive B cell
#> 14                         B220-positive CD38-positive unswitched memory B cell
#> 15                                                                      Be cell
#> 16                                                                     Be1 Cell
#> 17                                                                     Be2 cell
#> 18                                                                   Bm1 B cell
#> 19                                                                   Bm2 B cell
#> 20                                                                  Bm2' B cell
#> 21                                                                   Bm3 B cell
#> 22                                                             Bm3-delta B cell
#> 23                                                                   Bm4 B cell
#> 24                                                                   Bm5 B cell
#> 25                                                      CD115-positive monocyte
#> 26                                                CD11b-positive dendritic cell
#> 27                                        CD11c-low plasmacytoid dendritic cell
#> 28                                             CD14-low, CD16-positive monocyte
#> 29                                                       CD14-positive monocyte
#> 30                                             CD14-positive, CD16-low monocyte
#> 31                                        CD14-positive, CD16-positive monocyte
#> 32                                         CD16-positive myeloid dendritic cell
#> 33  CD2-positive, CD5-positive, CD44-positive alpha-beta intraepithelial T cell
#> 34        CD24-negative CD38-negative IgG-negative class switched memory B cell
#> 35        CD24-positive CD38-negative IgG-negative class switched memory B cell
#> 36                                 CD24-positive, CD4 single-positive thymocyte
#> 37                                 CD24-positive, CD8 single-positive thymocyte
#> 38                     CD25-positive, CD27-positive immature gamma-delta T cell
#> 39                                             CD27-negative gamma-delta T cell
#> 40                                             CD27-positive gamma-delta T cell
#> 41                                              CD38-negative IgG memory B cell
#> 42                      CD38-negative IgG-negative class switched memory B cell
#> 43                                                   CD38-negative naive B cell
#> 44                                       CD38-negative unswitched memory B cell
#> 45                                              CD38-positive IgG memory B cell
#> 46                      CD38-positive IgG-negative class switched memory B cell
#> 47                                                   CD38-positive naive B cell
#> 48                                       CD38-positive unswitched memory B cell
#> 49                     CD4-intermediate, CD8-positive double-positive thymocyte
#> 50                 CD4-negative CD8-negative gamma-delta intraepithelial T cell
#> 51              CD4-negative, CD8-alpha-negative, CD11b-positive dendritic cell
#> 52                                  CD4-negative, CD8-negative type I NK T cell
#> 53       CD4-negative, CD8-negative type I NK T cell secreting interferon-gamma
#> 54          CD4-negative, CD8-negative type I NK T cell secreting interleukin-4
#> 55                                                   CD4-positive helper T cell
#> 56                                                CD4-positive type I NK T cell
#> 57                     CD4-positive type I NK T cell secreting interferon-gamma
#> 58                        CD4-positive type I NK T cell secreting interleukin-4
#> 59                    CD4-positive, CD25-positive, alpha-beta regulatory T cell
#> 60                     CD4-positive, CD8-intermediate double-positive thymocyte
#> 61               CD4-positive, CXCR3-negative, CCR6-negative, alpha-beta T cell
#> 62                                              CD4-positive, alpha-beta T cell
#> 63                                    CD4-positive, alpha-beta cytotoxic T cell
#> 64                              CD4-positive, alpha-beta intraepithelial T cell
#> 65                                       CD4-positive, alpha-beta memory T cell
#> 66                                           CD4-positive, alpha-beta thymocyte
#> 67            CD56-negative, CD161-positive immature natural killer cell, human
#> 68            CD56-positive, CD161-positive immature natural killer cell, human
#> 69                                      CD69-positive double-positive thymocyte
#> 70                        CD69-positive, CD4-positive single-positive thymocyte
#> 71                        CD69-positive, CD8-positive single-positive thymocyte
#> 72                           CD71-low, GlyA-positive polychromatic erythroblast
#> 73                     CD71-negative, GlyA-positive orthochromatic erythroblast
#> 74                 CD8-alpha alpha positive, gamma-delta intraepithelial T cell
#> 75                  CD8-alpha-alpha-positive, alpha-beta intraepithelial T cell
#> 76                   CD8-alpha-beta-positive, alpha-beta intraepithelial T cell
#> 77                               CD8-alpha-negative plasmacytoid dendritic cell
#> 78                        CD8-alpha-negative thymic conventional dendritic cell
#> 79                               CD8-alpha-positive plasmacytoid dendritic cell
#> 80                        CD8-alpha-positive thymic conventional dendritic cell
#> 81               CD8-positive, CXCR3-negative, CCR6-negative, alpha-beta T cell
#> 82                   CD8-positive, CXCR3-positive, alpha-beta regulatory T cell
#> 83                                              CD8-positive, alpha-beta T cell
#> 84                  CD8-positive, alpha-beta cytokine secreting effector T cell
#> 85                                    CD8-positive, alpha-beta cytotoxic T cell
#> 86                                       CD8-positive, alpha-beta memory T cell
#> 87                                   CD8-positive, alpha-beta regulatory T cell
#> 88                                           CD8-positive, alpha-beta thymocyte
#> 89                                                    CD86-positive plasmablast
#> 90                                                                DN2 thymocyte
#> 91                                                               DN2a thymocyte
#> 92                                                               DN2b thymocyte
#> 93                                                                DN3 thymocyte
#> 94                                                                DN4 thymocyte
#> 95             Dx5-negative, NK1.1-positive immature natural killer cell, mouse
#> 96                                            F4/80-negative adipose macrophage
#> 97                                            F4/80-positive adipose macrophage
#> 98                                        GlyA-positive basophilic erythroblast
#> 99                                                  Gr1-high classical monocyte
#> 100                                              Gr1-low non-classical monocyte
#> 101                                        Gr1-positive, CD43-positive monocyte
#> 102                                                           IgA memory B cell
#> 103                                                             IgA plasma cell
#> 104                                                             IgA plasmablast
#> 105                                                 IgA short lived plasma cell
#> 106                                                             IgD plasmablast
#> 107                                IgD-negative CD38-positive IgG memory B cell
#> 108                                                  IgD-negative memory B cell
#> 109                                IgD-positive CD38-positive IgG memory B cell
#> 110                                                           IgE memory B cell
#> 111                                                             IgE plasma cell
#> 112                                                             IgE plasmablast
#> 113                                                 IgE short lived plasma cell
#> 114                                                           IgG memory B cell
#> 115                                                             IgG plasma cell
#> 116                                                             IgG plasmablast
#> 117                                                 IgG short lived plasma cell
#> 118                                   IgG-negative class switched memory B cell
#> 119                                  IgG-negative double negative memory B cell
#> 120                                  IgG-positive double negative memory B cell
#> 121                                                           IgM memory B cell
#> 122                                                             IgM plasma cell
#> 123                                                             IgM plasmablast
#> 124                                                 IgM short lived plasma cell
#> 125                            Kit-negative, Ly-76 high basophilic erythroblast
#> 126                  Kit-negative, Ly-76 high orthochromatophilic erythroblasts
#> 127                    Kit-negative, Ly-76 high polychromatophilic erythroblast
#> 128                                                             Langerhans cell
#> 129                                          MHC-II-high non-classical monocyte
#> 130                                           MHC-II-low non-classical monocyte
#> 131                                          MHC-II-negative classical monocyte
#> 132                                      MHC-II-negative non-classical monocyte
#> 133                                          MHC-II-positive classical monocyte
#> 134                                                               Peyer's patch
#> 135                                                        Peyer's patch B cell
#> 136                                                      Peyer's patch follicle
#> 137                                               Peyer's patch germinal center
#> 138                                                    Peyer's patch lymphocyte
#> 139                                       SIRPa-negative adipose dendritic cell
#> 140                                       SIRPa-positive adipose dendritic cell
#> 141                                                                      T cell
#> 142                                                    T follicular helper cell
#> 143                                                             T-helper 1 cell
#> 144                                                            T-helper 17 cell
#> 145                                                             T-helper 2 cell
#> 146                                                            T-helper 22 cell
#> 147                                                                   T1 B cell
#> 148                                                                   T2 B cell
#> 149                                                                   T3 B cell
#> 150                                                     TCR-positive macrophage
#> 151                                                                    Tc2 cell
#> 152                                                                    Tr1 cell
#> 153                       activated CD4-negative, CD8-negative type I NK T cell
#> 154                                     activated CD4-positive type I NK T cell
#> 155                                   activated CD4-positive, alpha-beta T cell
#> 156                                   activated CD8-positive, alpha-beta T cell
#> 157                                                 activated type II NK T cell
#> 158                                                      adipose dendritic cell
#> 159                                                          adipose macrophage
#> 160                                                             alobate nucleus
#> 161                                                           alpha-beta T cell
#> 162                                           alpha-beta intraepithelial T cell
#> 163                                                     antibody secreting cell
#> 164                                                      antipodal cell nucleus
#> 165                                             ascospore-type prospore nucleus
#> 166                                                          band form basophil
#> 167                                                        band form eosinophil
#> 168                                                              banded nucleus
#> 169                                                     basophilic erythroblast
#> 170                                                    basophilic metamyelocyte
#> 171                                                        basophilic myelocyte
#> 172                                                             binucleate cell
#> 173                                                                  blastodisc
#> 174                                                      bone marrow macrophage
#> 175                                        bronchial-associated lymphoid tissue
#> 176                                                                cecal tonsil
#> 177                                           central nervous system macrophage
#> 178                                                             cervical thymus
#> 179                                                       choroid plexus stroma
#> 180                                                class switched memory B cell
#> 181                                                          classical monocyte
#> 182                                                            colon macrophage
#> 183                                                 conventional dendritic cell
#> 184                                                            cortex of thymus
#> 185                                                            cytotoxic T cell
#> 186                                                              dendritic cell
#> 187                                                  dendritic epidermal T cell
#> 188                                           double negative T regulatory cell
#> 189                                               double negative memory B cell
#> 190                                                   double negative thymocyte
#> 191                                                       double-positive blast
#> 192                                       double-positive, alpha-beta thymocyte
#> 193                                    effector CD4-positive, alpha-beta T cell
#> 194                                    effector CD8-positive, alpha-beta T cell
#> 195                                                             effector T cell
#> 196                                                         elicited macrophage
#> 197                                                  eosinophilic metamyelocyte
#> 198                                                      eosinophilic myelocyte
#> 199                                                   epidermal Langerhans cell
#> 200                                       epithelium-associated lymphoid tissue
#> 201                                                                erythroblast
#> 202                                                            exhausted T cell
#> 203                                                     extrafusal muscle fiber
#> 204                                                    female germ cell nucleus
#> 205                                                           female pronucleus
#> 206                                                             fetal thymocyte
#> 207                                                           follicular B cell
#> 208                                      fourth ventricle choroid plexus stroma
#> 209                                                 fraction B precursor B cell
#> 210                                               fraction B/C precursor B cell
#> 211                                                 fraction C precursor B cell
#> 212                                                fraction C' precursor B cell
#> 213                                                 fraction D precursor B cell
#> 214                                                  fraction E immature B cell
#> 215                                                    fraction F mature B cell
#> 216                                                          gamma-delta T cell
#> 217                                          gamma-delta intraepithelial T cell
#> 218                                                       gamma-delta thymocyte
#> 219                                                                garland cell
#> 220                                                     generative cell nucleus
#> 221                                                           germ cell nucleus
#> 222                                                             germinal center
#> 223                                                      germinal center B cell
#> 224                                                            germinal vesicle
#> 225                                                group 1 innate lymphoid cell
#> 226                                                group 2 innate lymphoid cell
#> 227                                                group 3 innate lymphoid cell
#> 228                                              gut-associated lymphoid tissue
#> 229                                                               helper T cell
#> 230                                                             immature B cell
#> 231                              immature CD11c-low plasmacytoid dendritic cell
#> 232                               immature CD16-positive myeloid dendritic cell
#> 233                                                          immature NK T cell
#> 234                                                  immature NK T cell stage I
#> 235                                                 immature NK T cell stage II
#> 236                                                immature NK T cell stage III
#> 237                                                 immature NK T cell stage IV
#> 238                                                             immature T cell
#> 239                                                  immature alpha-beta T cell
#> 240                                                           immature basophil
#> 241                                        immature conventional dendritic cell
#> 242                              immature dendritic epithelial T cell precursor
#> 243                                                         immature eosinophil
#> 244                                                 immature gamma-delta T cell
#> 245                                               immature innate lymphoid cell
#> 246                                                immature natural killer cell
#> 247                                                         immature neutrophil
#> 248                                          immature single positive thymocyte
#> 249                                                     inflammatory macrophage
#> 250                                                      innate effector T cell
#> 251                                                        innate lymphoid cell
#> 252                                                       intermediate monocyte
#> 253                                                  intraepithelial lymphocyte
#> 254                                 langerin-positive lymph node dendritic cell
#> 255                                               large intestine Peyer's patch
#> 256                                                         large pre-B-II cell
#> 257                                     lateral ventricle choroid plexus stroma
#> 258                                                                left nucleus
#> 259                                              left renal cortex interstitium
#> 260                                                        liver dendritic cell
#> 261                                                      long lived plasma cell
#> 262                                                             lung macrophage
#> 263                                                         lymph node follicle
#> 264                                                  lymph node germinal center
#> 265                                      lymph node germinal center mantle zone
#> 266                                                 lymph node primary follicle
#> 267                                               lymph node secondary follicle
#> 268                                                                  lymphocyte
#> 269                                                     lymphocyte of B lineage
#> 270                                      lymphocyte of B lineage, CD19-positive
#> 271                                 lymphoid MHC-II-negative classical monocyte
#> 272                             lymphoid MHC-II-negative non-classical monocyte
#> 273                                                           lymphoid follicle
#> 274                                                             lymphoid tissue
#> 275                                                                macronucleus
#> 276                                                                  macrophage
#> 277                                                      male germ cell nucleus
#> 278                                                             male pronucleus
#> 279                                              marginal zone B cell of spleen
#> 280                                                               mature B cell
#> 281                                mature CD11c-low plasmacytoid dendritic cell
#> 282                                 mature CD16-positive myeloid dendritic cell
#> 283                                        mature CD4 single-positive thymocyte
#> 284                                        mature CD8 single-positive thymocyte
#> 285                                                            mature NK T cell
#> 286                                                               mature T cell
#> 287                                                    mature alpha-beta T cell
#> 288                                                             mature basophil
#> 289                                          mature conventional dendritic cell
#> 290                                mature dendritic epithelial T cell precursor
#> 291                                                   mature gamma-delta T cell
#> 292                                                      mature microglial cell
#> 293                                                           mature neutrophil
#> 294                                            megagametophyte egg cell nucleus
#> 295                                                       megasporocyte nucleus
#> 296                                                               memory B cell
#> 297                                                               memory T cell
#> 298                                                    memory regulatory T cell
#> 299                                                         mesangial phagocyte
#> 300                                                             microglial cell
#> 301                                                                micronucleus
#> 302                                                      microsporocyte nucleus
#> 303                                                                    monocyte
#> 304                                                            mononuclear cell
#> 305                                             mononuclear cell of bone marrow
#> 306                                          mononuclear cell of umbilical cord
#> 307                                                     mononuclear odontoclast
#> 308                                                      mononuclear osteoclast
#> 309                                                       mononuclear phagocyte
#> 310                                           mucosa-associated lymphoid tissue
#> 311                                                    mucosal invariant T cell
#> 312                                                    multinuclear odontoclast
#> 313                                                     multinuclear osteoclast
#> 314                                                          multinucleate cell
#> 315                                                   multinucleated giant cell
#> 316                                                    multinucleated phagocyte
#> 317                                                      myeloid dendritic cell
#> 318                                               myotendinous junction nucleus
#> 319                                                                     myotube
#> 320                                                                naive B cell
#> 321                                                                naive T cell
#> 322                        naive thymus-derived CD4-positive, alpha-beta T cell
#> 323                        naive thymus-derived CD8-positive, alpha-beta T cell
#> 324                                            nasal-associated lymphoid tissue
#> 325                                                   natural helper lymphocyte
#> 326                                                         natural killer cell
#> 327                                              neuromuscular junction nucleus
#> 328                                                      non-classical monocyte
#> 329                                                       nucleated thrombocyte
#> 331                                                 orthochromatic erythroblast
#> 332                                               placental resident macrophage
#> 333                                                                 plasma cell
#> 334                                                                 plasmablast
#> 335                                                 plasmacytoid dendritic cell
#> 336                                                               polar nucleus
#> 337                                             polychromatophilic erythroblast
#> 338                                                                pre-B-I cell
#> 339                                                               pre-B-II cell
#> 340                                                     pre-natural killer cell
#> 341                                         preBCR-negative large pre-B-II cell
#> 342                                         preBCR-positive large pre-B-II cell
#> 343                                                            precursor B cell
#> 344                                                   primary endosperm nucleus
#> 345                                             primary nodular lymphoid tissue
#> 346                                                                  pronucleus
#> 347                                                           regulatory T cell
#> 348                                                   renal cortex interstitium
#> 349                                                            reniform nucleus
#> 350                                           resting double-positive thymocyte
#> 351                                                               right nucleus
#> 352                                             right renal cortex interstitium
#> 353                                                   secondary follicle corona
#> 354                                           secondary nodular lymphoid tissue
#> 355                                                     short lived plasma cell
#> 356                                                        single nucleate cell
#> 357                                                       skeletal muscle fiber
#> 358                                                            slow muscle cell
#> 359                                                          slow muscle tissue
#> 360                                               small intestine Peyer's patch
#> 361                                                         small pre-B-II cell
#> 362                                                      somatic muscle myotube
#> 363                                                        spleen B cell corona
#> 364                                                      spleen germinal center
#> 365                                                    spleen lymphoid follicle
#> 366                                                   spleen primary B follicle
#> 367                                                 spleen secondary B follicle
#> 368                                                       suppressor macrophage
#> 369                                                              syncytial cell
#> 370                                                    syncytiotrophoblast cell
#> 371                                       third ventricle choroid plexus stroma
#> 372                                                             thoracic thymus
#> 373                                                                thromboblast
#> 374                                          thymic conventional dendritic cell
#> 375                                                           thymic macrophage
#> 376                                          thymic plasmacytoid dendritic cell
#> 377                                                                   thymocyte
#> 378                                                                      thymus
#> 379                                            thymus corticomedullary boundary
#> 380                                                               thymus lobule
#> 381                                                      thymus lymphoid tissue
#> 382                                                  tissue-resident macrophage
#> 383                                                          tongue muscle cell
#> 384                                                   transitional stage B cell
#> 385                                                            type I NK T cell
#> 386                                                           type II NK T cell
#> 387                                type II NK T cell secreting interferon-gamma
#> 388                                   type II NK T cell secreting interleukin-4
#> 389                                                    unswitched memory B cell
#> 390                                                 uterine natural killer cell
#> 391                                                 uterine resident macrophage
#>           predicate
#> 1       BFO:0000051
#> 2       BFO:0000051
#> 3       BFO:0000051
#> 4       BFO:0000051
#> 5       BFO:0000051
#> 6       BFO:0000051
#> 7       BFO:0000051
#> 8       BFO:0000051
#> 9       BFO:0000051
#> 10      BFO:0000051
#> 11      BFO:0000051
#> 12      BFO:0000051
#> 13      BFO:0000051
#> 14      BFO:0000051
#> 15      BFO:0000051
#> 16      BFO:0000051
#> 17      BFO:0000051
#> 18      BFO:0000051
#> 19      BFO:0000051
#> 20      BFO:0000051
#> 21      BFO:0000051
#> 22      BFO:0000051
#> 23      BFO:0000051
#> 24      BFO:0000051
#> 25      BFO:0000051
#> 26      BFO:0000051
#> 27      BFO:0000051
#> 28      BFO:0000051
#> 29      BFO:0000051
#> 30      BFO:0000051
#> 31      BFO:0000051
#> 32      BFO:0000051
#> 33      BFO:0000051
#> 34      BFO:0000051
#> 35      BFO:0000051
#> 36      BFO:0000051
#> 37      BFO:0000051
#> 38      BFO:0000051
#> 39      BFO:0000051
#> 40      BFO:0000051
#> 41      BFO:0000051
#> 42      BFO:0000051
#> 43      BFO:0000051
#> 44      BFO:0000051
#> 45      BFO:0000051
#> 46      BFO:0000051
#> 47      BFO:0000051
#> 48      BFO:0000051
#> 49      BFO:0000051
#> 50      BFO:0000051
#> 51      BFO:0000051
#> 52      BFO:0000051
#> 53      BFO:0000051
#> 54      BFO:0000051
#> 55      BFO:0000051
#> 56      BFO:0000051
#> 57      BFO:0000051
#> 58      BFO:0000051
#> 59      BFO:0000051
#> 60      BFO:0000051
#> 61      BFO:0000051
#> 62      BFO:0000051
#> 63      BFO:0000051
#> 64      BFO:0000051
#> 65      BFO:0000051
#> 66      BFO:0000051
#> 67      BFO:0000051
#> 68      BFO:0000051
#> 69      BFO:0000051
#> 70      BFO:0000051
#> 71      BFO:0000051
#> 72      BFO:0000051
#> 73      BFO:0000051
#> 74      BFO:0000051
#> 75      BFO:0000051
#> 76      BFO:0000051
#> 77      BFO:0000051
#> 78      BFO:0000051
#> 79      BFO:0000051
#> 80      BFO:0000051
#> 81      BFO:0000051
#> 82      BFO:0000051
#> 83      BFO:0000051
#> 84      BFO:0000051
#> 85      BFO:0000051
#> 86      BFO:0000051
#> 87      BFO:0000051
#> 88      BFO:0000051
#> 89      BFO:0000051
#> 90      BFO:0000051
#> 91      BFO:0000051
#> 92      BFO:0000051
#> 93      BFO:0000051
#> 94      BFO:0000051
#> 95      BFO:0000051
#> 96      BFO:0000051
#> 97      BFO:0000051
#> 98      BFO:0000051
#> 99      BFO:0000051
#> 100     BFO:0000051
#> 101     BFO:0000051
#> 102     BFO:0000051
#> 103     BFO:0000051
#> 104     BFO:0000051
#> 105     BFO:0000051
#> 106     BFO:0000051
#> 107     BFO:0000051
#> 108     BFO:0000051
#> 109     BFO:0000051
#> 110     BFO:0000051
#> 111     BFO:0000051
#> 112     BFO:0000051
#> 113     BFO:0000051
#> 114     BFO:0000051
#> 115     BFO:0000051
#> 116     BFO:0000051
#> 117     BFO:0000051
#> 118     BFO:0000051
#> 119     BFO:0000051
#> 120     BFO:0000051
#> 121     BFO:0000051
#> 122     BFO:0000051
#> 123     BFO:0000051
#> 124     BFO:0000051
#> 125     BFO:0000051
#> 126     BFO:0000051
#> 127     BFO:0000051
#> 128     BFO:0000051
#> 129     BFO:0000051
#> 130     BFO:0000051
#> 131     BFO:0000051
#> 132     BFO:0000051
#> 133     BFO:0000051
#> 134     BFO:0000051
#> 135     BFO:0000051
#> 136     BFO:0000051
#> 137     BFO:0000051
#> 138     BFO:0000051
#> 139     BFO:0000051
#> 140     BFO:0000051
#> 141     BFO:0000051
#> 142     BFO:0000051
#> 143     BFO:0000051
#> 144     BFO:0000051
#> 145     BFO:0000051
#> 146     BFO:0000051
#> 147     BFO:0000051
#> 148     BFO:0000051
#> 149     BFO:0000051
#> 150     BFO:0000051
#> 151     BFO:0000051
#> 152     BFO:0000051
#> 153     BFO:0000051
#> 154     BFO:0000051
#> 155     BFO:0000051
#> 156     BFO:0000051
#> 157     BFO:0000051
#> 158     BFO:0000051
#> 159     BFO:0000051
#> 160 rdfs:subClassOf
#> 161     BFO:0000051
#> 162     BFO:0000051
#> 163     BFO:0000051
#> 164 rdfs:subClassOf
#> 165 rdfs:subClassOf
#> 166     BFO:0000051
#> 167     BFO:0000051
#> 168 rdfs:subClassOf
#> 169     BFO:0000051
#> 170     BFO:0000051
#> 171     BFO:0000051
#> 172     BFO:0000051
#> 173     BFO:0000051
#> 174     BFO:0000051
#> 175     BFO:0000051
#> 176     BFO:0000051
#> 177     BFO:0000051
#> 178     BFO:0000051
#> 179     BFO:0000051
#> 180     BFO:0000051
#> 181     BFO:0000051
#> 182     BFO:0000051
#> 183     BFO:0000051
#> 184     BFO:0000051
#> 185     BFO:0000051
#> 186     BFO:0000051
#> 187     BFO:0000051
#> 188     BFO:0000051
#> 189     BFO:0000051
#> 190     BFO:0000051
#> 191     BFO:0000051
#> 192     BFO:0000051
#> 193     BFO:0000051
#> 194     BFO:0000051
#> 195     BFO:0000051
#> 196     BFO:0000051
#> 197     BFO:0000051
#> 198     BFO:0000051
#> 199     BFO:0000051
#> 200     BFO:0000051
#> 201     BFO:0000051
#> 202     BFO:0000051
#> 203     BFO:0000051
#> 204 rdfs:subClassOf
#> 205 rdfs:subClassOf
#> 206     BFO:0000051
#> 207     BFO:0000051
#> 208     BFO:0000051
#> 209     BFO:0000051
#> 210     BFO:0000051
#> 211     BFO:0000051
#> 212     BFO:0000051
#> 213     BFO:0000051
#> 214     BFO:0000051
#> 215     BFO:0000051
#> 216     BFO:0000051
#> 217     BFO:0000051
#> 218     BFO:0000051
#> 219     BFO:0000051
#> 220 rdfs:subClassOf
#> 221 rdfs:subClassOf
#> 222     BFO:0000051
#> 223     BFO:0000051
#> 224 rdfs:subClassOf
#> 225     BFO:0000051
#> 226     BFO:0000051
#> 227     BFO:0000051
#> 228     BFO:0000051
#> 229     BFO:0000051
#> 230     BFO:0000051
#> 231     BFO:0000051
#> 232     BFO:0000051
#> 233     BFO:0000051
#> 234     BFO:0000051
#> 235     BFO:0000051
#> 236     BFO:0000051
#> 237     BFO:0000051
#> 238     BFO:0000051
#> 239     BFO:0000051
#> 240     BFO:0000051
#> 241     BFO:0000051
#> 242     BFO:0000051
#> 243     BFO:0000051
#> 244     BFO:0000051
#> 245     BFO:0000051
#> 246     BFO:0000051
#> 247     BFO:0000051
#> 248     BFO:0000051
#> 249     BFO:0000051
#> 250     BFO:0000051
#> 251     BFO:0000051
#> 252     BFO:0000051
#> 253     BFO:0000051
#> 254     BFO:0000051
#> 255     BFO:0000051
#> 256     BFO:0000051
#> 257     BFO:0000051
#> 258 rdfs:subClassOf
#> 259     BFO:0000051
#> 260     BFO:0000051
#> 261     BFO:0000051
#> 262     BFO:0000051
#> 263     BFO:0000051
#> 264     BFO:0000051
#> 265     BFO:0000051
#> 266     BFO:0000051
#> 267     BFO:0000051
#> 268     BFO:0000051
#> 269     BFO:0000051
#> 270     BFO:0000051
#> 271     BFO:0000051
#> 272     BFO:0000051
#> 273     BFO:0000051
#> 274     BFO:0000051
#> 275 rdfs:subClassOf
#> 276     BFO:0000051
#> 277 rdfs:subClassOf
#> 278 rdfs:subClassOf
#> 279     BFO:0000051
#> 280     BFO:0000051
#> 281     BFO:0000051
#> 282     BFO:0000051
#> 283     BFO:0000051
#> 284     BFO:0000051
#> 285     BFO:0000051
#> 286     BFO:0000051
#> 287     BFO:0000051
#> 288     BFO:0000051
#> 289     BFO:0000051
#> 290     BFO:0000051
#> 291     BFO:0000051
#> 292     BFO:0000051
#> 293     BFO:0000051
#> 294 rdfs:subClassOf
#> 295 rdfs:subClassOf
#> 296     BFO:0000051
#> 297     BFO:0000051
#> 298     BFO:0000051
#> 299     BFO:0000051
#> 300     BFO:0000051
#> 301 rdfs:subClassOf
#> 302 rdfs:subClassOf
#> 303     BFO:0000051
#> 304     BFO:0000051
#> 305     BFO:0000051
#> 306     BFO:0000051
#> 307     BFO:0000051
#> 308     BFO:0000051
#> 309     BFO:0000051
#> 310     BFO:0000051
#> 311     BFO:0000051
#> 312     BFO:0000051
#> 313     BFO:0000051
#> 314     BFO:0000051
#> 315     BFO:0000051
#> 316     BFO:0000051
#> 317     BFO:0000051
#> 318 rdfs:subClassOf
#> 319     BFO:0000051
#> 320     BFO:0000051
#> 321     BFO:0000051
#> 322     BFO:0000051
#> 323     BFO:0000051
#> 324     BFO:0000051
#> 325     BFO:0000051
#> 326     BFO:0000051
#> 327 rdfs:subClassOf
#> 328     BFO:0000051
#> 329     BFO:0000051
#> 331     BFO:0000051
#> 332     BFO:0000051
#> 333     BFO:0000051
#> 334     BFO:0000051
#> 335     BFO:0000051
#> 336 rdfs:subClassOf
#> 337     BFO:0000051
#> 338     BFO:0000051
#> 339     BFO:0000051
#> 340     BFO:0000051
#> 341     BFO:0000051
#> 342     BFO:0000051
#> 343     BFO:0000051
#> 344 rdfs:subClassOf
#> 345     BFO:0000051
#> 346 rdfs:subClassOf
#> 347     BFO:0000051
#> 348     BFO:0000051
#> 349 rdfs:subClassOf
#> 350     BFO:0000051
#> 351 rdfs:subClassOf
#> 352     BFO:0000051
#> 353     BFO:0000051
#> 354     BFO:0000051
#> 355     BFO:0000051
#> 356     BFO:0000051
#> 357     BFO:0000051
#> 358     BFO:0000051
#> 359     BFO:0000051
#> 360     BFO:0000051
#> 361     BFO:0000051
#> 362     BFO:0000051
#> 363     BFO:0000051
#> 364     BFO:0000051
#> 365     BFO:0000051
#> 366     BFO:0000051
#> 367     BFO:0000051
#> 368     BFO:0000051
#> 369     BFO:0000051
#> 370     BFO:0000051
#> 371     BFO:0000051
#> 372     BFO:0000051
#> 373     BFO:0000051
#> 374     BFO:0000051
#> 375     BFO:0000051
#> 376     BFO:0000051
#> 377     BFO:0000051
#> 378     BFO:0000051
#> 379     BFO:0000051
#> 380     BFO:0000051
#> 381     BFO:0000051
#> 382     BFO:0000051
#> 383     BFO:0000051
#> 384     BFO:0000051
#> 385     BFO:0000051
#> 386     BFO:0000051
#> 387     BFO:0000051
#> 388     BFO:0000051
#> 389     BFO:0000051
#> 390     BFO:0000051
#> 391     BFO:0000051
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
