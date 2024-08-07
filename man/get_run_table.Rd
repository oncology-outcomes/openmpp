% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/OutputTables.R
\name{get_run_table}
\alias{get_run_table}
\alias{get_run_table_csv}
\alias{get_run_table_calc_csv}
\alias{get_run_table_comparison_csv}
\title{OpenM++ Output Tables}
\usage{
get_run_table(model, run, name)

get_run_table_csv(model, run, name)

get_run_table_calc_csv(model, run, name, calc)

get_run_table_comparison_csv(model, run, name, compare, variant)
}
\arguments{
\item{model}{Model digest or model name.}

\item{run}{Model run digest, run stamp or run name, modeling task run
stamp or task run name.}

\item{name}{Output table name.}

\item{calc}{Name of calculation. One of \code{"avg"}, \code{"sum"}, \code{"count"}, \code{"max"},
\code{"min"}, \code{"var"}, \code{"sd"}, \code{"se"}, or \code{"cv"}.}

\item{compare}{Comparison to calculate. One of \code{"diff"}, \code{"ratio"}, or
\code{"percent"}. Comparisons are for the base run relative to the variant
run (i.e., for \code{"diff"} it is the difference of values represented as
Variant - Base).}

\item{variant}{Run digest, name, or stamp for the variant model run.}
}
\value{
A \code{list} or \code{tibble}.
}
\description{
Functions for retrieving output tables from model runs.
}
