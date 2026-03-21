# SemsqlConn: S7 connection wrapper for SemanticSQL databases

An S7 class that encapsulates a SQLite connection to an ontology
database following the SemanticSQL schema. Provides methods for common
ontology queries including label lookup, ancestor/descendant traversal,
and relationship queries.

Properties:

- con:

  The DBI connection object (SQLiteConnection)

- db_path:

  character(1) path to the SQLite database file

- ontology_prefix:

  character(1) primary ontology prefix, e.g. `"CL"` for the Cell
  Ontology

## Usage

``` r
SemsqlConn(con = NULL, db_path = character(0), ontology_prefix = character(0))
```
