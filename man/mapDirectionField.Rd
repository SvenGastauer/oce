\name{mapDirectionField}

\alias{mapDirectionField}

\title{Plot a direction field on a existing map}

\description{Plot a direction field on a existing map}

\usage{
mapDirectionField(longitude, latitude, u, v,
                  scale=1, length=0.05, code=2, col=par("fg"), ...)}
\arguments{
    \item{longitude, latitude}{starting points for arrows}
    \item{u, v}{components of a vector to be shown as a direction
        field}
    \item{scale}{latitude degrees per unit of \code{u} or \code{v}.}
    \item{length}{length of arrow heads, passed to \code{\link{arrows}}}
    \item{code}{code of arrows, passed to \code{\link{arrows}}}
    \item{col}{color of arrows.  This may be a single colour, or a matrix
        of colors of the same dimension as \code{u}.}
    \item{\dots}{optional arguments passed to \code{\link{arrows}}, e.g.
        \code{angle} and \code{lwd} can be useful in differentiating different
        fields.}
}

\details{Adds arrows for a direction field on an existing map.  There are
    different possibilities for how \code{longitude}, \code{latitude} and
    \code{u} and \code{v} match up.  In one common case, all four of these are
    matrices, e.g. output from a numerical model.  In another, \code{longitude}
    and \code{latitude} are the coordinates along the matrices, and are thus
    stored in vectors with lengths that match appropriately.}

\seealso{See \code{\link{mapPlot}} for general information on plotting maps,
    including other functions.}

\examples{
\dontrun{
library(oce)
data(coastlineWorld)
par(mar=rep(2,4))
mapPlot(coastlineWorld, longitudelim=c(-120,-55), latitudelim=c(35,50),
        proj="lambert", parameters=c(lat0=40,lat1=60),
        orientation=c(90,-90,0))
lon <- seq(-120, -60, 15)
lat <- 45 + seq(-15, 15, 5)
lonm <- matrix(expand.grid(lon,lat)[,1], nrow=length(lon))
latm <- matrix(expand.grid(lon,lat)[,2], nrow=length(lon))
## vectors pointed 45 degrees clockwise from north
u <- matrix(1/sqrt(2), nrow=length(lon), ncol=length(lat))
v <- matrix(1/sqrt(2), nrow=length(lon), ncol=length(lat))
mapDirectionField(lon, lat, u, v, scale=3)
mapDirectionField(lonm, latm, 0, 1, scale=3, col='red')
# Color code by longitude, using thick lines
col <- colormap(lonm)$zcol
mapDirectionField(lonm, latm, 1, 0, scale=3, col=col, lwd=2)
}
}

\author{Dan Kelley}

\keyword{hplot}

