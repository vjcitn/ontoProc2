# ontoProc2
Revise ontoProc methods to take advantage of INCAtools SemanticSQL representations of ontologies

The [INCAtools Semantic SQL project](https://github.com/INCATools/semantic-sql) ([tutorial notebook](https://github.com/INCATools/semantic-sql/blob/main/notebooks/SemanticSQL-Tutorial.ipynb)) identifies an AWS S3 bucket where a large number of ontologies
are available.

```
%vjc> aws s3 ls s3://bbop-sqlite/ |grep db.gz
2023-09-02 17:38:48    4268563 ado.db.gz
2023-09-02 17:38:48   11841154 agro.db.gz
2023-09-02 17:38:48     301889 aio.db.gz
2023-09-02 17:38:48   42842146 aism.db.gz
2023-09-02 17:38:48     294887 amphx.db.gz
2023-09-02 17:38:48     303328 apo.db.gz
2023-09-02 17:38:48    3457483 apollo_sv.db.gz
2023-09-02 17:38:48    7245916 aro.db.gz
2023-09-02 17:38:48    5939737 bao.db.gz
2023-09-02 17:38:48     767913 bcio.db.gz
2023-09-02 17:38:50     552497 bco.db.gz
2023-09-02 17:38:51 1600927276 bero.db.gz
2023-09-02 17:38:51     108284 bfo.db.gz
2023-09-02 17:38:54     575935 biolink.db.gz
2023-09-02 17:38:55        646 biopax.db.gz
2023-09-02 17:38:55     463088 biovoices.db.gz
...
```
In this package we will provide tools to retrieve, cache, and make use of these ontologies.

