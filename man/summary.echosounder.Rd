\name{summary.echosounder}

\alias{summary.echosounder}

\title{Summarize an echosounder object}

\description{Summarizes some of the data in an \code{echosounder} object.}

\usage{
\method{summary}{echosounder}(object, \dots)
}

\arguments{
  \item{object}{an object of class \code{"echosounder"}, usually, a result of a
    call to \code{\link{read.echosounder}}, \code{\link{read.oce}}, or
    \code{\link{as.echosounder}}.}
  \item{\dots}{further arguments passed to or from other methods.}
}

\details{Pertinent summary information is presented, including the
  sampling location, data ranges, etc.}

\value{An object of class \code{"summary.echosounder"}, which contains
    pertinent information about the echosounder record and its processing.}

\seealso{The documentation for \code{\link{echosounder-class}} explains the
    structure of echosounder objects, and also outlines the other functions
    dealing with them.}

\examples{
library(oce)
\dontrun{
e <- read.echosounder("myfile")
summary(e)
}
}

\author{Dan Kelley}

\keyword{misc}