% vim:textwidth=80:expandtab:shiftwidth=2:softtabstop=2
%salinityFlag, temperatureFlag, pressureFlag, conductivityFlag,
%SAFlag, CTFlag, oxygenFlag, nitrateFlag, nitriteFlag, phosphateFlag, silicateFlag,

\name{as.ctd}
\alias{as.ctd}
\title{Coerce data into ctd dataset}
\description{Coerces a dataset into a ctd dataset.}

\usage{as.ctd(salinity, temperature=NULL, pressure=NULL, conductivity=NULL,
       SA=NULL, CT=NULL, oxygen=NULL,
       nitrate=NULL, nitrite=NULL, phosphate=NULL, silicate=NULL,
       scan=NULL, time=NULL, other=NULL,
       units=NULL, pressureType="sea",
       missingValue=NA, quality=NULL, 
       filename="", type="", model="", serialNumber="",
       ship="", scientist="", institute="", address="", cruise="", station="", 
       date="", startTime="", recovery="",
       longitude=NA, latitude=NA,
       deploymentType="unknown",
       pressureAtmospheric=0, waterDepth=NA,
       sampleInterval=NA, src="",
       debug=getOption("oceDebug"))}

\arguments{

  \item{salinity}{There are two choices for \code{salinity}. First, it can be a
    vector indicating the practical salinity through the water column. In that
    case, \code{as.ctd} employs the other arguments listed below. The second
    choice is that \code{salinity} is something from which practical salinity,
    temperature, etc., can be inferred. In that case, the relevant information
    is extracted and the other arguments to \code{as.ctd} are ignored, except
    for \code{pressureAtmospheric}; see \dQuote{Details}.}

  \item{temperature}{\emph{in-situ} temperature [\eqn{^\circ}{deg}C], defined on
    the ITS-90 scale; see \dQuote{Temperature units} in the documentation for
    \code{\link{swRho}}.}

  \item{pressure}{pressure through the water column. If only one value is given,
    then it is repeated to match the length of the temperature vector.}

  \item{conductivity}{electrical conductivity ratio through the water column
    (optional). To convert from raw conductivity in milliSeimens per centimeter
    divide by 42.914 to get conductivity ratio.}

  \item{SA}{absolute salinity (as in TEOS-10).  If given, the supplied absolute
    salinity is converted internally to UNESCO-defined practical salinity.}

  \item{CT}{conservative temperature (as in TEOS-10).  If given, the supplied
    conservative temperature is converted internally to UNESCO-defined in-situ
    temperature.}
  \item{oxygen}{optional oxygen concentration}
  \item{nitrate}{optional nitrate concentration [micromole/kg]}
  \item{nitrite}{optional nitrite concentration [micromole/kg]}
  \item{phosphate}{optional phosphate concentration [micromole/kg]}
  \item{silicate}{optional silicate concentration [micromole/kg]}
  \item{scan}{optional scan number.  If not provided, this will be set to
    \code{1:length(salinity)}.}
  \item{time}{optional vector of times of observation}
  \item{other}{optional list of other data columns that are not in the standard list}
%  \item{salinityFlag}{a quality flag, defined and interpreted by the user}
%  \item{temperatureFlag}{a quality flag, defined and interpreted by the user}
%  \item{pressureFlag}{a quality flag, defined and interpreted by the user}
%  \item{conductivityFlag}{a quality flag, defined and interpreted by the user}
%  \item{SAFlag}{a quality flag, defined and interpreted by the user}
%  \item{CTFlag}{a quality flag, defined and interpreted by the user}
%  \item{oxygenFlag}{a quality flag, defined and interpreted by the user}
%  \item{nitrateFlag}{a quality flag, defined and interpreted by the user}
%  \item{nitriteFlag}{a quality flag, defined and interpreted by the user}
%  \item{phosphateFlag}{a quality flag, defined and interpreted by the user}
%  \item{silicateFlag}{a quality flag, defined and interpreted by the user}

  \item{units}{an optional list containing units.  If not supplied, a default of
    \code{list(temperature=list(unit=expression(degree*C), scale="ITS-90"),
      salinity=list(unit=expression(ratio), scale="",
      pressure=list(unit=expression(dbar), scale="")} is used. This is quite
    typical of archived datasets, but for some instrumental files it will make
    sense to use \code{salinity=list(unit=expression(uS/cm), scale="")} or 
    \code{salinity=list(unit=expression(S/m), scale="")}.}
  
  \item{pressureType}{a character string indicating the type of pressure; may be
    \code{"absolute"}, for total pressure, i.e. the sum of atmospheric pressure
    and sea pressure, or \code{"sea"}.}
  \item{missingValue}{optional missing value, indicating data that should be
    taken as \code{NA}.}
  \item{quality}{quality flag, e.g. from the salinity quality flag in WOCE data.
    (In WOCE, \code{quality=2} indicates good data, \code{quality=3} means
    questionable data, and \code{quality=4} means bad data.}
  \item{filename}{filename to be stored in the object}
  \item{type}{type of CTD, e.g. "SBE"}
  \item{model}{model of instrument}
  \item{serialNumber}{serial number of instrument}
  \item{ship}{optional string containing the ship from which the observations were made.}
  \item{scientist}{optional string containing the chief scientist on the cruise.}
  \item{institute}{optional string containing the institute behind the work.}
  \item{address}{optional string containing the address of the institute.}
  \item{cruise}{optional string containing a cruise identifier.}
  \item{station}{optional string containing a station identifier.}
  \item{date}{optional string containing the date at which the profile was started.}
  \item{startTime}{optional string containing the start time.}
  \item{recovery}{optional string indicating the recovery time.}
  \item{longitude}{optional numerical value containing longitude in decimal
    degrees, positive in the eastern hemisphere. If this is a single number,
    then it is stored in the \code{metadata} slot of the returned value; if it
    is a vector of numbers, they are stored in \code{data} and a mean value is
    stored in \code{metadata}.  }
  \item{latitude}{optional numerical value containing the latitude in decimal
    degrees, positive in the northern hemisphere. See the note on length, for
    the \code{longitude} argument.}
  \item{deploymentType}{character string indicating the type of deployment. Use
    \code{"unknown"} if this is not known, \code{"profile"} for a profile (in
    which the data were acquired during a downcast, while the device was lowered
    into the water column, perhaps also including an upcast; \code{"moored"} if
    the device is installed on a fixed mooring, \code{"thermosalinograph"} (or
    \code{"tsg"}) if the device is mounted on a moving vessel, to record
    near-surface properties, or \code{"towyo"} if the device is repeatedly
    lowered and raised.}
  \item{pressureAtmospheric}{if \code{NA} (the default), then pressure is copied
    from the \code{pressure} argument or from the contents of the first argument
    (as described above for \code{salinity}). Otherwise, if
    \code{pressureAtmospheric} is a numerical value (a constant or a vector),
    then it is subtracted from pressure before storing it in the return value.
    See \dQuote{Details} for special considerations if \code{salinity}
    is a \code{\link{rsk-class}} object.}
  \item{waterDepth}{optional numerical value indicating the water depth in
    metres. This is different from the maximum recorded pressure, although
    the latter is used by some oce functions as a guess on water depth, the
    most important example being \code{\link{plot.section}}.}
  \item{sampleInterval}{optional numerical value indicating the time between
    samples in the profile.}
  \item{src}{optional string indicating data source}
  \item{debug}{a flag that can be set to \code{TRUE} to turn on debugging.}
}

\details{If the first argument is an \code{\link{rsk-class}} object, the
  pressure it contains may need to be adjusted, because \code{rsk} objects may
  contain either absolute pressure or sea pressure. This adjustment is handled
  automatically by \code{as.ctd}, by examination of the metadata item named
  \code{pressureType} (described in the documentation for
  \code{\link{read.rsk}}). Once the sea pressure is determined, adjustments may
  be made with the \code{pressureAtmospheric} argument, although in
  that case it is better considered a pressure adjustment than the atmospheric
  pressure.

  \code{\link{rsk-class}} objects may store sea pressure or absolute pressure
  (the sum of sea pressure and atmospheric pressure), depending on how the
  object was created with \code{\link{as.rsk}} or \code{\link{read.rsk}}.
  However, \code{\link{ctd-class}} objects store sea pressure, which is needed
  for plotting, calculating density, etc. This poses no difficulities, however,
  because \code{as.ctd} automatically converts absolute pressure to sea
  pressure, if the metadata in the \code{\link{rsk-class}} object indicates that
  this is appropriate. Further alteration of the pressure can be accomplished
  with the \code{pressureAtmospheric} argument, as noted above.}

\value{An object of \code{\link[base]{class}} \code{"ctd"} (for details, see
  \code{\link{read.ctd}}).}

\seealso{The documentation for \code{\link{ctd-class}} explains the structure of
  CTD objects, and also outlines the other functions dealing with them.}

\examples{
library(oce)
pressure <- 1:50
temperature <- 10 - tanh((pressure - 20) / 5) + 0.02*rnorm(50)
salinity <- 34 + 0.5*tanh((pressure - 20) / 5) + 0.01*rnorm(50)
ctd <- as.ctd(salinity, temperature, pressure)
summary(ctd)
plot(ctd)
}

\author{Dan Kelley}

\keyword{misc}
