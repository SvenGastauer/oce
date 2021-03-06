\name{oce.convolve}

\alias{oce.convolve}
\alias{oceConvolve}

\title{Convolve two time series}

\description{Convolve two time series, using a backward-looking method}

\usage{oce.convolve(x, f, end=2)}

\arguments{
  \item{x}{a numerical vector of observations.}
  \item{f}{a numerical vector of filter coefficients.}
  \item{end}{a flag that controls how to handle the points of the \code{x}
      series that have indices less than the length of \code{f}.  If
      \code{end=0}, the values are set to 0.  If \code{end=1}, the original x
      values are used there.  If \code{end=2}, that fraction of the \code{f}
      values that overlap with \code{x} are used.}
}

\details{This function provides a straightforward convolution, which may be
    useful to those who prefer not to use \code{\link{convolve}} and
    \code{filter} in the \code{stats} package.}
    
\value{A vector of the convolution output.}

\examples{
library(oce)
t <- 0:1027
n <- length(t)
signal <- ifelse(sin(t * 2 * pi / 128) > 0, 1, 0)
tau <- 10
filter <- exp(-seq(5*tau, 0) / tau)
filter <- filter / sum(filter)
observation <- oce.convolve(signal, filter)
plot(t, signal, type='l')
lines(t, observation, lty='dotted')
}

\author{Dan Kelley}

\keyword{misc}
