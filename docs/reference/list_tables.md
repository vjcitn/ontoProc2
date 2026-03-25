<div id="main" class="col-md-9" role="main">

# List tables in a SemsqlConn database

<div class="ref-description section level2">

List tables in a SemsqlConn database

</div>

<div class="section level2">

## Usage

<div class="sourceCode">

``` r
list_tables(x, ...)
```

</div>

</div>

<div class="section level2">

## Arguments

-   x:

    A `SemsqlConn` object.

</div>

<div class="section level2">

## Value

character vector of table names.

</div>

<div class="section level2">

## Examples

<div class="sourceCode">

``` r
goref <- semsql_connect(ontology = "go")
#> Connected to SemanticSQL database: /Users/vincentcarey/Library/Caches/org.R-project.R/R/BiocFileCache/40e293b372b_go.db
#> Primary ontology prefix: GO
list_tables(goref)
#>   [1] "all_problems"                                  
#>   [2] "annotation_property_node"                      
#>   [3] "anonymous_class_expression"                    
#>   [4] "anonymous_expression"                          
#>   [5] "anonymous_individual_expression"               
#>   [6] "anonymous_property_expression"                 
#>   [7] "asymmetric_property_node"                      
#>   [8] "axiom_dbxref_annotation"                       
#>   [9] "blank_node"                                    
#>  [10] "class_node"                                    
#>  [11] "contributor"                                   
#>  [12] "count_of_instantiated_classes"                 
#>  [13] "count_of_predicates"                           
#>  [14] "count_of_subclasses"                           
#>  [15] "creator"                                       
#>  [16] "deprecated_node"                               
#>  [17] "edge"                                          
#>  [18] "entailed_edge"                                 
#>  [19] "entailed_edge_cycle"                           
#>  [20] "entailed_edge_same_predicate_cycle"            
#>  [21] "entailed_subclass_of_edge"                     
#>  [22] "entailed_type_edge"                            
#>  [23] "has_broad_match_statement"                     
#>  [24] "has_broad_synonym_statement"                   
#>  [25] "has_dbxref_statement"                          
#>  [26] "has_exact_match_statement"                     
#>  [27] "has_exact_synonym_statement"                   
#>  [28] "has_mapping_statement"                         
#>  [29] "has_match_statement"                           
#>  [30] "has_narrow_match_statement"                    
#>  [31] "has_narrow_synonym_statement"                  
#>  [32] "has_oio_synonym_statement"                     
#>  [33] "has_related_match_statement"                   
#>  [34] "has_related_synonym_statement"                 
#>  [35] "has_synonym_statement"                         
#>  [36] "has_text_definition_statement"                 
#>  [37] "iri_node"                                      
#>  [38] "irreflexive_property_node"                     
#>  [39] "lexical_problem"                               
#>  [40] "named_individual_node"                         
#>  [41] "node"                                          
#>  [42] "node_identifier"                               
#>  [43] "node_to_node_statement"                        
#>  [44] "node_to_value_statement"                       
#>  [45] "node_with_two_labels_problem"                  
#>  [46] "object_property_node"                          
#>  [47] "ontology_node"                                 
#>  [48] "ontology_status_statement"                     
#>  [49] "orcid"                                         
#>  [50] "owl_all_values_from"                           
#>  [51] "owl_axiom"                                     
#>  [52] "owl_axiom_annotation"                          
#>  [53] "owl_complement_of_statement"                   
#>  [54] "owl_complex_axiom"                             
#>  [55] "owl_disjoint_class_statement"                  
#>  [56] "owl_equivalent_class_statement"                
#>  [57] "owl_equivalent_to_intersection_member"         
#>  [58] "owl_has_self"                                  
#>  [59] "owl_has_value"                                 
#>  [60] "owl_imports_statement"                         
#>  [61] "owl_inverse_of_statement"                      
#>  [62] "owl_reified_axiom"                             
#>  [63] "owl_restriction"                               
#>  [64] "owl_same_as_statement"                         
#>  [65] "owl_some_values_from"                          
#>  [66] "owl_subclass_of_some_values_from"              
#>  [67] "prefix"                                        
#>  [68] "problem"                                       
#>  [69] "property_node"                                 
#>  [70] "property_used_with_datatype_values_and_objects"
#>  [71] "rdf_first_statement"                           
#>  [72] "rdf_level_summary_statistic"                   
#>  [73] "rdf_list_member_statement"                     
#>  [74] "rdf_list_node"                                 
#>  [75] "rdf_list_statement"                            
#>  [76] "rdf_rest_statement"                            
#>  [77] "rdf_rest_transitive_statement"                 
#>  [78] "rdf_type_statement"                            
#>  [79] "rdfs_domain_statement"                         
#>  [80] "rdfs_label_statement"                          
#>  [81] "rdfs_range_statement"                          
#>  [82] "rdfs_subclass_of_named_statement"              
#>  [83] "rdfs_subclass_of_statement"                    
#>  [84] "rdfs_subproperty_of_statement"                 
#>  [85] "reflexive_property_node"                       
#>  [86] "relation_graph_construct"                      
#>  [87] "repair_action"                                 
#>  [88] "statements"                                    
#>  [89] "subgraph_edge_by_ancestor"                     
#>  [90] "subgraph_edge_by_ancestor_or_descendant"       
#>  [91] "subgraph_edge_by_child"                        
#>  [92] "subgraph_edge_by_descendant"                   
#>  [93] "subgraph_edge_by_parent"                       
#>  [94] "subgraph_edge_by_self"                         
#>  [95] "subgraph_query"                                
#>  [96] "symmetric_property_node"                       
#>  [97] "term_association"                              
#>  [98] "trailing_whitespace_problem"                   
#>  [99] "transitive_edge"                               
#> [100] "transitive_property_node"                      
disconnect(goref)
#> Disconnected from '40e293b372b_go.db'
```

</div>

</div>

</div>
