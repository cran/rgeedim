## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  eval = FALSE,
  collapse = TRUE,
  comment = "#>"
)

## ----setup--------------------------------------------------------------------
#  library(rgeedim)
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
#  par(mar=c(1,1,1,1))
#  plot(f[[1]])
#  
#  # inspect object
#  f

## ----include=FALSE------------------------------------------------------------
#  unlink("image.tif")

