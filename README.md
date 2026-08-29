# ontoProc2

This package constitutes a "second generation" approach to
management and use of ontologies in Bioconductor.

The [INCAtools Semantic SQL project](https://github.com/INCATools/semantic-sql) ([tutorial notebook](https://github.com/INCATools/semantic-sql/blob/main/notebooks/SemanticSQL-Tutorial.ipynb)) identifies 
a location where a large number of ontologies
are available.

```
curl -s https://semanticsql.berkeleybop.io/ \
>   | xmllint --xpath '//*[local-name()="Key"][substring(text(), string-length(text())-5)=".db.gz"]/text()' - | head -20
ado.db.gz
agro.db.gz
aio.db.gz
aism.db.gz
amphx.db.gz
apo.db.gz
apollo_sv.db.gz
aro.db.gz
asmo.db.gz
bao.db.gz
bcio.db.gz
bco.db.gz
bero.db.gz
bervo.db.gz
bfo.db.gz
bfo2020.db.gz
bfo2020_core.db.gz
bfo2020_notime.db.gz
bfo2020_time.db.gz
biolink.db.gz
...
```
In this package we will provide tools to retrieve, cache, and make use of these ontologies.

## Installation

For Bioconductor versions 3.24 and beyond, use `BiocManager::install("ontoProc2")`.  Otherwise,
use `BiocManager::install("vjcitn/ontoProc2")`.
