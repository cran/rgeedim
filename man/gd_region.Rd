% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/regions.R
\name{gd_region}
\alias{gd_region}
\title{Create GeoJSON Region from R Spatial Objects}
\usage{
gd_region(x)
}
\arguments{
\item{x}{either a WKT string (character), a {terra} SpatRaster(Collection)/SpatVector(Collection)/SpatExtent, an {sf} object, an {sp} Spatial* object or a {raster} RasterLayer/RasterStack.}
}
\value{
list representing a GeoJSON extent
}
\description{
Creates a suitable input for the \code{region} argument to \verb{gd_download(<Image>)} or \code{gd_search()} for Image Collections.
}
\details{
If \code{x} is an R spatial object, each vertex (possibly after converting object extent to vector) is used to create the GeoJSON object. Otherwise, the extent is determined and passed to \code{gd_bbox()}.
}
\examples{
\dontshow{if (requireNamespace("terra")) (if (getRversion() >= "3.4") withAutoprint else force)(\{ # examplesIf}
\dontshow{\}) # examplesIf}
b <- terra::vect('POLYGON((-121.355 37.56,-121.355 37.555,
                    -121.35 37.555,-121.35 37.56,
                    -121.355 37.56))',
          crs = "OGC:CRS84")
gd_region(b)
}
\seealso{
\code{gd_bbox()}
}
