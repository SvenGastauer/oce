% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/argo.R
\docType{class}
\name{argo-class}
\alias{argo-class}
\title{Class to hold argo data}
\description{
This class stores data from argo drifters. It will be in fairly
active development in the early months of 2016.
}
\details{
An \code{argo} object may be read with \code{\link{read.argo}} or
created with \code{\link{as.argo}}.  Argo data can be gridded to constant
pressures with \code{\link{argoGrid}}.  Plots can be made with
\code{\link{plot.argo}}, while \code{\link{summary.argo}} produces statistical
summaries and \code{show} produces overviews. The usual oce generic
functions are available, e.g. \code{\link{[[,argo-method}} may 
be used to extract data, and \code{\link{[[<-,argo-method}} may
be used to insert data.

See \url{http://www.argo.ucsd.edu/Gridded_fields.html} for some
argo-related datasets that may be useful in a wider context.
}

