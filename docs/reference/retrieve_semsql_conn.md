# return a SQLite connection (read only) to an INCAtools Semantic SQL ontology

return a SQLite connection (read only) to an INCAtools Semantic SQL
ontology

## Usage

``` r
retrieve_semsql_conn(
  ontology = "efo",
  cache = BiocFileCache::BiocFileCache(),
  cacheid = NULL,
  ...
)
```

## Arguments

- ontology:

  character(1) short string prefixing .db.gz in the INCAtools collection

- cache:

  a BiocFileCache instance, defaulting to BiocFileCache::BiocFileCache()

- cacheid:

  character(1) or NULL; if non-null, the associated SQLite resource will
  be used from cache

- ...:

  passed to download.file

## Value

an RSQLite DBI connection instance

## Examples

``` r
# first time will involve a download and decompression
aionto = retrieve_semsql_conn("aio")
head(DBI::dbListTables(aionto))
#> [1] "all_problems"                    "annotation_property_node"       
#> [3] "anonymous_class_expression"      "anonymous_expression"           
#> [5] "anonymous_individual_expression" "anonymous_property_expression"  
dplyr::tbl(aionto, "class_node") |> head() 
#> # Source:   SQL [?? x 1]
#> # Database: sqlite 3.51.2 [/home/vincent/.cache/R/BiocFileCache/b2422b2bbf70_aio.db]
#>   id                             
#>   <chr>                          
#> 1 aio:AbstractRNNCell            
#> 2 aio:ActivationLayer            
#> 3 aio:ActiveLearning             
#> 4 aio:ActivityBias               
#> 5 aio:ActivityRegularizationLayer
#> 6 aio:AdaptiveAvgPool1DLayer     
```
