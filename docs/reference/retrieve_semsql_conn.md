<div id="main" class="col-md-9" role="main">

# return a SQLite connection (read only) to an INCAtools Semantic SQL ontology

<div class="ref-description section level2">

return a SQLite connection (read only) to an INCAtools Semantic SQL
ontology

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
retrieve_semsql_conn(
  ontology = "efo",
  cache = BiocFileCache::BiocFileCache(),
  cacheid = NULL,
  ...
)
```

</div>

</div>

<div class="section level2">

## Arguments

-   ontology:

    character(1) short string prefixing .db.gz in the INCAtools
    collection

-   cache:

    a BiocFileCache instance, defaulting to
    BiocFileCache::BiocFileCache()

-   cacheid:

    character(1) or NULL; if non-null, the associated SQLite resource
    will be used from cache

-   ...:

    passed to download.file

</div>

<div class="section level2">

## Value

an RSQLite DBI connection instance

</div>

<div class="section level2">

## Note

When the cache is searched, the string given as 'ontology' will be
prefixed with '^'. This helps avoid confusion between pcl.db and cl.db,
for example.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
# first time will involve a download and decompression
aionto = retrieve_semsql_conn("aio")
head(DBI::dbListTables(aionto))
#> [1] "all_problems"                    "annotation_property_node"       
#> [3] "anonymous_class_expression"      "anonymous_expression"           
#> [5] "anonymous_individual_expression" "anonymous_property_expression"  
dplyr::tbl(aionto, "class_node") |> head() 
#> # Source:   SQL [?? x 1]
#> # Database: sqlite 3.51.2 [/Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/4561637cb3e4_aio.db]
#>   id                             
#>   <chr>                          
#> 1 aio:AbstractRNNCell            
#> 2 aio:ActivationLayer            
#> 3 aio:ActiveLearning             
#> 4 aio:ActivityBias               
#> 5 aio:ActivityRegularizationLayer
#> 6 aio:AdaptiveAvgPool1DLayer     
```

</div>

</div>

</div>
