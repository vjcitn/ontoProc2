# retrieve and cache all filenames of Semantic SQL ontologies available, checking for updated content relative to cache via ETag

retrieve and cache all filenames of Semantic SQL ontologies available,
checking for updated content relative to cache via ETag

## Usage

``` r
bbop_sqlite_db_gz(
  url = "https://s3.amazonaws.com/bbop-sqlite",
  bfc = BiocFileCache::BiocFileCache(),
  rname = "bbop_sqlite_listing",
  timeout_connect = 5,
  timeout_total = 15
)
```

## Arguments

- url:

  source address

- bfc:

  an instance of BiocFileCache

- rname:

  a string to use to identify the cached listing

- timeout_connect:

  passed to httr2::req_options connecttimeout parameter

- timeout_total:

  passed to httr2::req_options seconds parameter

## Note

There is no real etag discipline for the metadata, so full metadata
content is extracted on each call, digested, and compared to digest in
cache. Cache is updated when there is a discrepancy, except there is a
guard against rewriting cache with corrupted or zero-length data at
endpoint. Note this code was negotiated at length with claude.ai Sonnet
4.6.

## Examples

``` r
gzs = bbop_sqlite_db_gz()
#> Fetching bucket listing...
#> Content hash matches; using cached listing.
head(gzs)
#> [1] "ado.db.gz"   "agro.db.gz"  "aio.db.gz"   "aism.db.gz"  "amphx.db.gz"
#> [6] "apo.db.gz"  
length(gzs)
#> [1] 332
```
