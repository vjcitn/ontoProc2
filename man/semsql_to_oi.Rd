% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/semsql_to_oi.R
\name{semsql_to_oi}
\alias{semsql_to_oi}
\title{produce an ontology_index instance from semantic sql sqlite connection}
\usage{
semsql_to_oi(con)
}
\arguments{
\item{con}{DBI::dbConnect value for sqlite table}
}
\value{
result of ontologyIndex::ontology_index evaluated for the labels and 
parent-child relations in tables statements and edge of the semantic sql resource
}
\description{
produce an ontology_index instance from semantic sql sqlite connection
}
