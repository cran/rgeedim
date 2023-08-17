## ---- include = FALSE---------------------------------------------------------
library(rgeedim)
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  fig.width = 8,
  fig.align = 'center',
  comment = "#>"
)

## ----libr---------------------------------------------------------------------
#  library(rgeedim)

## ----setup--------------------------------------------------------------------
#  gd_initialize()

## ----bbox---------------------------------------------------------------------
#  r <- gd_bbox(
#    xmin = -121,
#    xmax = -120.5,
#    ymin = 38.5,
#    ymax = 39
#  )

## ----image-from-id------------------------------------------------------------
#  x <- gd_image_from_id('CSP/ERGo/1_0/Global/SRTM_topoDiversity')

## ----download-----------------------------------------------------------------
#  img <- gd_download(x, filename = 'image.tif',
#                     region = r, scale = 900,
#                     overwrite = TRUE, silent = FALSE
#                    )

## ----terrarast, fig.align='center', fig.width=4-------------------------------
#  library(terra)
#  f <- rast(img)

## ----inspect------------------------------------------------------------------
#  par(mar = c(1, 1, 1, 1))
#  plot(f[[1]])
#  
#  # inspect object
#  f

## ---- dem10-hillshade---------------------------------------------------------
#  library(rgeedim)
#  library(terra)
#  
#  gd_initialize()
#  
#  b <- gd_bbox(
#    xmin = -120.296,
#    xmax = -120.227,
#    ymin = 37.9824,
#    ymax = 38.0071
#  )
#  
#  ## hillshade example
#  # download 10m NED DEM in AEA
#  x <- "USGS/NED" |>
#    gd_image_from_id() |>
#    gd_download(
#      region = b,
#      scale = 10,
#      crs = "EPSG:5070",
#      resampling = "bilinear",
#      filename = "image.tif",
#      bands = list("elevation"),
#      overwrite = TRUE,
#      silent = FALSE
#    )
#  dem <- rast(x)$elevation
#  
#  # calculate slope, aspect, and hillshade with terra
#  slp <- terrain(dem, "slope", unit = "radians")
#  asp <- terrain(dem, "aspect", unit = "radians")
#  hsd <- shade(slp, asp)
#  
#  # compare elevation v.s. hillshade
#  plot(c(dem, hillshade = hsd))

## ----lidar-composite----------------------------------------------------------
#  # search and download composite from USGS 1m lidar data collection
#  library(rgeedim)
#  library(terra)
#  
#  gd_initialize()
#  
#  # wkt->SpatVector->GeoJSON
#  b <- 'POLYGON((-121.355 37.56,-121.355 37.555,
#            -121.35 37.555,-121.35 37.56,
#            -121.355 37.56))' |>
#    vect(crs = "OGC:CRS84")
#  
#  # create a GeoJSON-like list from a SpatVector object
#  # (most rgeedim functions arguments for spatial inputs do this automatically)
#  r <- gd_region(b)
#  
#  # search collection for an area of interest
#  a <- "USGS/3DEP/1m" |>
#    gd_collection_from_name() |>
#    gd_search(region = r)
#  
#  # inspect individual image metadata in the collection
#  gd_properties(a)
#  
#  # resampling images as part of composite; before download
#  x <- a |>
#    gd_composite(resampling = "bilinear") |>
#    gd_download(region = r,
#                crs = "EPSG:5070",
#                scale = 1,
#                filename = "image.tif",
#                overwrite = TRUE,
#                silent = FALSE) |>
#    rast()
#  
#  # inspect
#  plot(terra::terrain(x$elevation))
#  plot(project(b, x), add = TRUE)

## ---- daymet-nocomposite------------------------------------------------------
#  # search and download individual images from daymet V4
#  library(rgeedim)
#  library(terra)
#  
#  gd_initialize()
#  
#  r <- gd_bbox(
#    xmin = -121,
#    xmax = -120.5,
#    ymin = 38.5,
#    ymax = 39
#  )
#  
#  # search collection for spatial and date range (one week in January 2020)
#  gd_collection_from_name('NASA/ORNL/DAYMET_V4') |>
#    gd_search(region = r,
#              start_date = "2020-01-21",
#              end_date = "2020-01-27") -> res
#  
#  # get table of IDs and dates
#  p <- gd_properties(res)
#  td <- file.path(tempdir(), "DAYMET_V4")
#  
#  # create a new collection using gd_collection_from_list()
#  # download each image as separate GeoTIFF (no compositing)
#  # Note: `filename` is a directory
#  gd_collection_from_list(p$id) |>
#    gd_download(
#      filename = td,
#      composite = FALSE,
#      dtype = 'int16',
#      region = r,
#      bands = list("prcp"),
#      crs = "EPSG:5070",
#      scale = 1000
#    ) |>
#    rast() -> x2
#  
#  # filter to bands of interest (if neeeded)
#  x2 <- x2[[names(x2) == "prcp"]]
#  
#  # set time for each layer
#  time(x2) <- p$date
#  panel(x2)
#  title(ylab = "Daily Precipitation (mm)")

## ---- include=FALSE-----------------------------------------------------------
#  unlink("image.tif")
#  unlink(td, recursive = TRUE)

