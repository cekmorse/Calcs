##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

tableFolder <- "~/Projects/Text/Tables/"
setwd(modelsFile)
load("date.Rdata")

unitConvert <- 1/0.3048 # meters to feet
scaleFactor <- 1        # no conversion required
setwd(models.D)
load("widthA1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthA1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthA.txt")

setwd(models.D)
load("widthB1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthB1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthB.txt")

setwd(models.D)
load("widthC1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthC1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthC.txt")

setwd(models.D)
load("widthD1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthD1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthD.txt")

setwd(models.D)
load("widthE1.Rdata"); dx <- widthToday
setwd(modelsFile)
load("widthE1.Rdata"); sx <- widthToday
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableWidthE.txt")

unitConvert <- 2.47105  # hectares to acres.
scaleFactor <- 0.0001   # convert from m^2 to hectares -- 10,000 m^2 == 1 ha
setwd(models.D)
load("areaA.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaA.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaA.txt")

setwd(models.D)
load("areaB.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaB.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaB.txt")

setwd(models.D)
load("areaC.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaC.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaC.txt")

setwd(models.D)
load("areaD.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaD.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaD.txt")

setwd(models.D)
load("areaE.Rdata"); dx <- surfaceArea
setwd(modelsFile)
load("areaE.Rdata"); sx <- surfaceArea
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableAreaE.txt")


unitConvert <- 2.47105 * (1/0.3048) # hectare-m to acre-ft.
scaleFactor <- 0.0001   # convert from m^3 to hectare-m -- 10,000 m^3 == 1 ha-m
setwd(models.D)
load("volA.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volA.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeA.txt")

setwd(models.D)
load("volB.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volB.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeB.txt")

setwd(models.D)
load("volC.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volC.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeC.txt")

setwd(models.D)
load("volD.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volD.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeD.txt")

setwd(models.D)
load("volE.Rdata"); dx <- volumeChange
setwd(modelsFile)
load("volE.Rdata"); sx <- volumeChange
makeTable(dx, sx, scaleFactor, unitConvert, tableFolder, "tableVolumeE.txt")

rm(list=ls())
