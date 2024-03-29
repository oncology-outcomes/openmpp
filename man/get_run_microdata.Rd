% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/RunMicrodata.R
\name{get_run_microdata}
\alias{get_run_microdata}
\alias{get_run_microdata_csv}
\title{OpenM++ Run Microdata}
\usage{
get_run_microdata(model, run, name)

get_run_microdata_csv(model, run, name)
}
\arguments{
\item{model}{Model digest or model name.}

\item{run}{Model run digest, run stamp or run name, modeling task run
stamp, or task run name.}

\item{name}{Output table name.}
}
\value{
A \code{list} or \code{tibble}.
}
\description{
Functions for retrieving microdata from model runs.
}
