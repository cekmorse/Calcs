##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

tableFolder <- "~/Projects/Text/Tables/"
setwd(modelsFile)
load("date.Rdata")

unitConvert <- 1/0.3048 # meters to feet
scaleFactor <- 1        # no conversion required
setwd(models.D)
load("widthF1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthF1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthF.txt")

setwd(models.D)
load("widthG1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthG1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthG.txt")

unitConvert <- 2.47105  # hectares to acres.
scaleFactor <- 0.0001   # convert from m^2 to hectares -- 10,000 m^2 == 1 ha
setwd(models.D)
load("areaF.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaF.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaF.txt")

setwd(models.D)
load("areaG.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaG.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaG.txt")


unitConvert <- 2.47105 * (1/0.3048) # hectare-m to acre-ft.
scaleFactor <- 0.0001   # convert from m^3 to hectare-m -- 10,000 m^3 == 1 ha-m
setwd(models.D)
load("volF.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volF.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeF.txt")

setwd(models.D)
load("volG.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volG.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeG.txt")

rm(list=ls())