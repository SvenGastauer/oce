\name{read.sealevel}

\alias{read.sealevel}

\title{Read a sea-level data file}

\description{Read a data file holding sea level data.  BUG: the time
  vector assumes GMT, regardless of the GMT.offset value.} 

\usage{read.sealevel(file, tz=getOption("oce.tz"), log.action, debug=getOption("oce.debug"))}

\arguments{
  \item{file}{a connection or a character string giving the name of the
    file to load.  See Details for the types of files that are recognized.}
  \item{tz}{time zone.  The default value, \code{oce.tz}, is set to \code{UTC} 
    at setup.  (If a time zone is present in the file header, this will
    supercede the value given here.)}
  \item{log.action}{if provided, the action item to be stored in the
    log.  (Typically only provided for internal calls; the default that
    it provides is better for normal calls by a user.)}
  \item{debug}{set to \code{TRUE} to get debugging information during processing.}
}

\details{This function starts by scanning the first line of the file,
  from which it determines whether the file is in one of two known
  formats: type 1, the format used at the Hawaii archive centre, and
  type 2, the comma-separated-value format used by the Marine
  Environmental Data Service.  (The file type is inferred by checking
  for the existence of the string \code{Station_Name} on the first line
  of the file, indicating type 2.) If the file is in neither of these
  formats, the user might wish to scan it directly, and then to use
  \code{\link{as.sealevel}} to create a \code{sealevel} object.}

\value{An object of \code{\link[base]{class}} \code{"sealevel"}, which
  is a \code{\link[base]{list}} containing
 \item{data}{A \code{\link{data.frame}} containing
   \describe{
     \item{\code{time}}{time}
     \item{\code{eta}}{sea level [m]}
   }
  }
  \item{metadata}{A list containing
    \describe{
      \item{\code{header}}{the header line or lines.  (This may prove
	helpful if detail extraction fails.)}
      \item{\code{year}}{year in which the observations were made.}
      \item{\code{station.number}}{identifier for the station.}
      \item{\code{station.version}}{see online docs at site mentioned in
	References.}
      \item{\code{station.name}}{name of station}
      \item{\code{region}}{a region code.}
      \item{\code{latitude}}{latitude, decimal degrees, positive north
	of equator.}
      \item{\code{longitude}}{longitude, decimal degrees, positive east
	of Greenwich.}
      \item{\code{GMT.offset}}{offset from GMT time.  This is read
	directly from files of type 1.  For files of type 2, the offset is
	inferred from the timezone, but this is a somewhat risky business,
	since timezone names are not standard.}
      \item{\code{decimation.method}}{see online docs at sites mentioned
	in References.}
      \item{\code{reference.offset}}{a reference offset; see online docs
	at sites mentioned in References.}
      \item{\code{reference.code}}{a reference code; see online docs at
	site mentioned in References.}
      \item{\code{units}}{unit of observations in the original file
	(normally "MM")}
      \item{\code{n}}{number of observations.}
      \item{\code{sampling.interval}}{hours between samples in the timeseries.}
    }
  }
  \item{processing.log}{A processing log, in the standard \code{oce} format.}
}

\seealso{The generic function \code{\link{read.oce}} provides an
  alternative to this. A \code{sealevel} object may be summarized with
  \code{\link{summary.sealevel}}.  Use \code{\link{plot.sealevel}} to
  produce a summary plot, and use \code{\link{tidem}} to fit a tidal
  model to the data.

  A \code{"sealevel"} object can also be constructed with
  \code{\link{as.sealevel}} (and, in fact, \code{read.sealevel} uses
  this routine to actually create the \code{"sealevel"} object.)

  Tidal models may be fitted to \code{"sealevel"} objects with
  \code{\link{tidem}}.
}

\examples{
library(oce)
# sealevel.hal
sl <- read.oce(system.file("data", "h275a96.dat", package="oce"))
summary(sl)
plot(sl)
m <- tidem(sl)
plot(m)
}

\references{The Hawaii archive site at \url{http://ilikai.soest.hawaii.edu/uhslc/datai.html}
provides a graphical interface for downloading sealevel data in Type 1
(the format is described at
\url{ftp://ilikai.soest.hawaii.edu/rqds/hourly.fmt}). The MEDS repository
provides Type 2 data, at \url{http://www.meds-sdmm.dfo-mpo.gc.ca/meds/Databases/TWL/TWL_inventory_e.htm}.}

\author{Dan Kelley}

\keyword{misc}