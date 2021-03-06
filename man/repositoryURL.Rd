% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/repo.R
\name{repositoryURL}
\alias{repositoryURL}
\title{Calculate a web link to download Oceanographic data}
\usage{
repositoryURL(item, id, window, domain, subdomain)
}
\arguments{
\item{item}{A string indicating the item sought; see \dQuote{Details}.}

\item{id}{A string indicating the ID of the sought item.}

\item{window}{A list specifying a data window for a snapshot; the contents are
\code{basin}, a string naming the ocean basin (must be \code{"Atlantic"},
\code{"Pacific"} or \code{"Indian"}) and a string named \code{time},
specifying a date in the format \code{yyyymmdd}.}

\item{domain}{The base-level domain (more information to be added later).}

\item{subdomain}{The second-level domain (more information to be added later).}
}
\description{
This function is able to construct universal resource locators (URLs)
that can be used with \code{\link{download.file}} to download data from
several common Oceanographic repositories. The goal of this function is to
spare users the task of finding such URLs for casual use or one-off
applications. There is no intention of trying to reproduce the web tools
provided with many data repositories, nor of providing an exhaustive
list of data types. Readers are advised strongly to become familiar with
the data sites that are relevant to their own work, and also to the
wide-reaching NOAA data-accumulator system known as ERDDAP [1], which
provides powerful graphical tools for finding data. An R interface to
ERDDAP is provided by the \CRANpkg{rerddap} package, of which 
the present function is the faintest of faint echoes.
}
\details{
The following values for \code{item} are handled. In each example, square
brackets are used to indicate that the contents are to be replaced by
the named item from the argument list.

\enumerate{
\item \code{item="argo"} looks up argo data, referenced either by 
float id or by basin plus time.

\itemize{

\item \emph{id mode.} The return value is constructed
as \preformatted{"[domain]/pub/outgoing/argo/dac/[subdomain]/[id]/[id]_prof.nc"}
where if \code{domain} is missing a default of 
\code{"ftp://usgodae.org"} will be used, and similarly \code{"bodc"}
will be used for \code{subdomain} if it is missing. The proper subdomain
for a given float \code{id} will be known to users familiar with the data,
while other users may infer it by inspecting the subdirectories
of the FTP site \code{ftp://usgodae.org/pub/outgoing/argo/dac}
or by accessing
\code{ftp://usgodae.org/pub/outgoing/argo/ar_index_global_meta.txt}
and searching for the float identifier, \code{id}. See example 1.

\item \emph{basin/time mode.} The return value is constructed as
\preformatted{"[domain]/pub/outgoing/argo/geo/[B]_ocea/[yyyy]/[mm]/[dd]/[yyy][mm][dd]_prof.nc"}
where \code{B} is the value of \code{window$basin}, and \code{yyyy},
\code{mm} and \code{dd} are extracted from the characters of \code{window$time}.
See example 2.

}

Caution: tests made in January 2016 revealed that 
\code{http://data.nodc.noaa.gov} stores argo files with
\emph{lower-case} names, which is inconsistent
with argo documentation [2] and incompatible with \code{\link{read.argo}}.

\item \code{item="hydrography"} looks up hydrographic data, at present
only by specified cruise (or EXPOCODE, in the notation used by archiving 
agencies). The return value is constructed as
\preformatted{"[domain]/cruise/[window$cruise]?download=dataset"} where
the \code{domain} argument defaults to \code{"http://cchdo.ucsd.edu"}
if it is not provided and \code{window$cruise} is a string containing 
the cruise EXPOCODE.  (It is assumed that readers will know the identifier,
or look it up with the searching tools provided at \url{http://cchdo.ucsd.edu}).
The returned URL points to a zip file
that can be expanded to get including bottle and CTD data. See example 3.

}
}
\section{Contributing}{

This function was drafted in late January, 2016, and its argument
list is likely to change through the early months of 2016. Some
of this will be to accommodate new data types, but changes to 
website structures will also precipitate changes to how this
function works.

This function will be most useful if users contribute to it, both by 
pointing out changes to URLs and by suggesting additions for useful
datasets. The most useful comments will be concrete; merely suggesting
that an interface be provided to such-and-such server is too vague
to help much.
}
\examples{
# Example 1.
# Trajectory of the argo float used for data("argo").
file <- repositoryURL(item="argo", id="6900388")
\dontrun{
download.file(file, "argo.nc")
argo <- read.oce("argo.nc")
summary(argo)
plot(argo)
mtext(file, side=3, line=0)}

# Example 2.
# Map of Atlantic float SST on New Year's Day, 2016, 
# with faded colours if the top datum is not close to 
# the surface.
file <- repositoryURL(item="argo",
                      window=list(basin="Atlantic", time="20130101"))
\dontrun{
download.file(file, "nyd.nc")
nyd <- read.oce("nyd.nc")
## Colour-code
Tlim <- c(-2, 30)
temp <- nyd[["temperature"]][1,]
cm <- colormap(temp, zlim=Tlim)
pres <- nyd[['pressure']][1,]
col <- cm$zcol
col2 <- unlist(lapply(seq_along(temp),
                      function(i) adjustcolor(col[i], pres[i]/10)))
par(mar=c(4, 4, 1, 4))
drawPalette(colormap=cm)
plot(nyd, pch=21, bg=col2, cex=2, mar=c(4, 4, 1, 4))
mtext(file, side=3, line=0)}

# Example 3.
# Zipfile holds data from cruise 74JC20150110.
file <- repositoryURL(item="hydrography", window=list(cruise="74JC20150110"))
\dontrun{
download.file(file, "cchdo_74JC20150110.zip")}

}
\author{
Dan Kelley
}
\references{
\itemize{
\item 1. The ERDDAP site is at \url{http://coastwatch.pfeg.noaa.gov/erddap/index.html} and
\url{http://coastwatch.pfeg.noaa.gov/erddap/information.html} provides an itemized summary
of some key issues relating to it.  Rich Signell's video tutorial on ERDDAP
(\url{https://www.youtube.com/watch?v=18xZoXu1USM}) is a good way to get an idea for
the scope of ERDDAP.
\item 2. The \code{argo} netCDF format is described at
\code{http://archimer.ifremer.fr/doc/00187/29825/40575.pdf}; 
as of January 28, 2016, Section 2.2.4 of this document
indicates that variable names are to be in upper case,
which is true for the \code{nodc.noaa.gov} server, so data provided
by this server cannot be read with \code{\link{read.argo}}.
}
}
\seealso{
The \CRANpkg{rerddap} package provides excellent capabilities for searching for datasets, and the related website \url{http://coastwatch.pfeg.noaa.gov/erddap/index.html} provides excellent graphical interfaces to this archive. \code{\link{download.file}} for downloading the files found by \code{repositoryURI}
}

