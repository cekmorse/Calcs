source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")
textTablesFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

C1 <- 0.0001  ## convert m^3 to hectare-meters
C2 <- 8.10713194  ## convert hectare-meters to acre-feet

fname <- "tableVolumeA.txt"
setwd(models.D)
load("volA.Rdata")
da <- volumeChange
setwd(modelsFile)
load("volA.Rdata")
ds <- volumeChange
makeTable(da, ds, textTablesFolder, fname)

fname <- "tableVolumeB.txt"
setwd(models.D)
load("volB.Rdata")
da <- volumeChange
setwd(modelsFile)
load("volB.Rdata")
ds <- volumeChange
makeTable(da, ds, textTablesFolder, fname)

fname <- "tableVolumeC.txt"
setwd(models.D)
load("volC.Rdata")
da <- volumeChange
setwd(modelsFile)
load("volC.Rdata")
ds <- volumeChange
makeTable(da, ds, textTablesFolder, fname)

fname <- "tableVolumeD.txt"
setwd(models.D)
load("volD.Rdata")
da <- volumeChange
setwd(modelsFile)
load("volD.Rdata")
ds <- volumeChange
makeTable(da, ds, textTablesFolder, fname)

fname <- "tableVolumeE.txt"
setwd(models.D)
load("volE.Rdata")
da <- volumeChange
setwd(modelsFile)
load("volE.Rdata")
ds <- volumeChange
makeTable(da, ds, textTablesFolder, fname)

rm(list=ls())