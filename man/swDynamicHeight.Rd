\name{swDynamicHeight}

\alias{swDynamicHeight}

\title{Dynamic height of seawater profile}

\description{Compute the dynamic height of a column of seawater.}

\usage{swDynamicHeight(x, referencePressure=2000,
                subdivisions=500, rel.tol=.Machine$double.eps^0.25,
                            eos=getOption("oceEOS", default="gsw"))}

\arguments{
  \item{x}{a \code{section} object, \strong{or} a \code{ctd} object.}
  \item{referencePressure}{reference pressure [dbar]}
  \item{subdivisions}{number of subdivisions for call to
      \code{\link{integrate}}.  (The default value is considerably larger than
      the default for \code{\link{integrate}}, because otherwise some test
      profiles failed to integrate.}
  \item{rel.tol}{absolute tolerance for call to \code{\link{integrate}}.  Note
      that this call is made in scaled coordinates, i.e. pressure is divided by
      its maximum value, and dz/dp is also divided by its maximum.}
  \item{eos}{equation of state, either \code{"unesco"} or \code{"gsw"}.}
}

\details{If the first argument is a \code{section}, then dynamic height is
    calculated for each station within a section, and returns a list containing
    distance along the section along with dynamic height.

  If the first argument is a \code{ctd}, then this returns just a single
  value, the dynamic height.

  If \code{eos="unesco"}, processing is as follows.  First, a piecewise-linear
  model of the density variation with pressure is developed using
  \code{\link[stats]{approxfun}}. (The option \code{rule=2} is used to
  extrapolate the uppermost density up to the surface, preventing a possible a
  bias for bottle data, in which the first depth may be a few metres below the
  surface.) A second function is constructed as the density of water with
  salinity 35PSU, temperature of 0\eqn{^\circ}{deg}C, and pressure as in the
  \code{ctd}. The difference of the reciprocals of these densities, is then
  integrated with \code{\link[stats]{integrate}} with pressure limits \code{0}
  to \code{referencePressure}.  (For improved numerical results, the variables
  are scaled before the integration, making both independent and dependent
  variables be of order one.)

  NOTE: As of early 2015, the \code{eos="gsw"} case is handled exactly the same
  as the \code{"unesco"} case, because the GSW C code (version 3.0.3) lacks the
  requisite functions.

}

\value{In the first form, a list containing \code{distance}, the
  distance [km] from the first station in the section and \code{height},
  the dynamic height [m].

  In the second form, a single value, containing the dynamic height [m].
}

\examples{
    \dontrun{
library(oce)
data(section)

# Dynamic height and geostrophy
par(mfcol=c(2,2))
par(mar=c(4.5,4.5,2,1))

# Left-hand column: whole section
# (The smoothing lowers Gulf Stream speed greatly)
westToEast <- subset(section, 1<=stationId&stationId<=123)
dh <- swDynamicHeight(westToEast)
plot(dh$distance, dh$height, type='p', xlab="", ylab="dyn. height [m]")
ok <- !is.na(dh$height)
smu <- supsmu(dh$distance, dh$height)
lines(smu, col="blue")
f <- coriolis(section[["station", 1]][["latitude"]])
g <- gravity(section[["station", 1]][["latitude"]])
v <- diff(smu$y)/diff(smu$x) * g / f / 1e3 # 1e3 converts to m
plot(smu$x[-1], v, type='l', col="blue", xlab="distance [km]", ylab="velocity [m/s]")

# right-hand column: gulf stream region, unsmoothed
gs <- subset(section, 102<=stationId&stationId<=124)
dh.gs <- swDynamicHeight(gs)
plot(dh.gs$distance, dh.gs$height, type='b', xlab="", ylab="dyn. height [m]")
v <- diff(dh.gs$height)/diff(dh.gs$distance) * g / f / 1e3
plot(dh.gs$distance[-1], v, type='l', col="blue",
  xlab="distance [km]", ylab="velocity [m/s]")
}
}

\references{Gill, A.E., 1982. \emph{Atmosphere-ocean Dynamics}, Academic
  Press, New York, 662 pp.}

\author{Dan Kelley}

\keyword{misc}
