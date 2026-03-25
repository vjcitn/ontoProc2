<div id="main" class="col-md-9" role="main">

# Package index

<div class="section level2">

## All functions

</div>

<div class="section level2">

-   `PREDICATES` : Standard predicate CURIEs used in OBO ontologies
-   `SemsqlConn()` : SemsqlConn: S7 connection wrapper for SemanticSQL
    databases
-   `cells_with_pmp()` : produce a table with cells exhibiting given
    proteins on plasma membrane according to CL
-   `cn2tag` : a named vector with mapping from cell type phrase to
    CURIE for CL.owl of 2025-12-17
-   `count_by_prefix()` : Count labeled terms grouped by CURIE prefix
-   `count_descendants()` : Count the number of descendants of a term
-   `describe_table()` : Describe the columns of a table in a SemsqlConn
    database
-   `disconnect()` : Disconnect a SemsqlConn from its database
-   `find_by_restriction()` : Find terms that have a given OWL
    someValuesFrom restriction
-   `find_intersection()` : Find terms that are descendants of a
    superclass and have a given restriction
-   `get_ancestors()` : Get all ancestors of a term via entailed edges
-   `get_ancestors_partonomy()` : Get ancestors traversing both is-a and
    part-of relationships
-   `get_definition()` : Get the text definition for a term
-   `get_descendants()` : Get all descendants of a term via entailed
    edges
-   `get_descendants_partonomy()` : Get descendants traversing both is-a
    and has-part relationships
-   `get_direct_edges()` : Get direct edges in the ontology graph for a
    term
-   `get_direct_subclasses()` : Get direct subclasses of a term
-   `get_direct_superclasses()` : Get direct superclasses of a term
-   `get_label()` : Get the rdfs:label for a term
-   `get_prefix()` : Retrieve the ontology prefix from a SemsqlConn
-   `get_present_pmp()` : produce a table with list of proteins from
    protein ontology identified as present on cell membranes for input
    cell type CURIEs
-   `get_restrictions()` : Get OWL someValuesFrom restrictions for a
    term
-   `get_synonyms()` : Get synonyms for a term
-   `get_term_info()` : Retrieve a summary of information about a term
-   `improveNodes()` : inject linefeeds for node names for graph, with
    textual annotation from ontology
-   `is_connected()` : Test whether a SemsqlConn has a valid open
    connection
-   `list_tables()` : List tables in a SemsqlConn database
-   `make_graphNEL_from_ontology_plot()` : obtain graphNEL from
    ontology\_plot instance of ontologyPlot
-   `ncit_map` : a named vector with values rdfs labels in NCI
    thesaurus, and names the corresponding formal ontology tags
-   `onto_plot2()` : high-level use of graph/Rgraphviz for rendering
    ontology relations
-   `print` : setup print
-   `reconnect()` : Reconnect a SemsqlConn to its database
-   `report()` : Display a detailed report of a SemsqlConn object
-   `retrieve_semsql_conn()` : return a SQLite connection (read only) to
    an INCAtools Semantic SQL ontology
-   `run_query()` : Run an arbitrary SQL query against a SemsqlConn
    database
-   `search_labels()` : Search term labels in a SemsqlConn database
-   `semsql_connect()` : Create a SemsqlConn connection
-   `semsql_to_oi()` : produce an ontology\_index instance from semantic
    sql sqlite connection
-   `semsql_url()` : produce INCAtools distribution URL
-   `tag2cn` : a named vector with mapping from CURIE to cell type
    phrase for CL.owl of 2025-12-17
-   `with_connection()` : Execute code with an automatically managed
    SemsqlConn

</div>

</div>
