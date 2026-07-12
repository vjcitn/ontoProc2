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

## Note

When the cache is searched, the string given as 'ontology' will be
prefixed with '^'. This helps avoid confusion between pcl.db and cl.db,
for example.

## Examples

``` r
# first time will involve a download and decompression
aionto <- retrieve_semsql_conn("aio")
head(DBI::dbListTables(aionto))
#> [1] "all_problems"                    "annotation_property_node"       
#> [3] "anonymous_class_expression"      "anonymous_expression"           
#> [5] "anonymous_individual_expression" "anonymous_property_expression"  
dplyr::tbl(aionto, "class_node") |> head()
#> # A query:  ?? x 1
#> # Database: sqlite 3.53.3 [/home/runner/.cache/R/BiocFileCache/5208512d9fe8_aio.db]
#>   id                             
#>   <chr>                          
#> 1 aio:AbstractRNNCell            
#> 2 aio:ActivationLayer            
#> 3 aio:ActiveLearning             
#> 4 aio:ActivityBias               
#> 5 aio:ActivityRegularizationLayer
#> 6 aio:AdaptiveAvgPool1DLayer     
```
