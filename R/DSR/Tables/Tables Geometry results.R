##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")
saveFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

setwd(modelsFile)
load("date.Rdata")

run1 <- function(fileName) {
  setwd(models.D)
  x <- load(fileName); dx <- get(x); rm(list=x)
  setwd(modelsFile)
  x <- load(fileName); sx <- get(x); rm(list=x)
  return(list("dx"=dx,"sx"=sx))
}

scaleConvert <- 1               # original units of m
unitConvert <- 1/0.3048         # convert m to ft

loc <- "widthF1"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

loc <- "widthG1"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

loc <- "widthF1"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

scaleConvert <- 0.0001           # original units of m^2 convert to hectare -- 10,000 m^2 per ha
unitConvert <-  2.4710538146717   # convert ha to ac

loc <- "areaF"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

loc <- "areaG"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

scaleConvert <- 0.0001            # original units of m^3 convert to ha-m -- 10,000 m^3 per ha-m
unitConvert <-  8.107131821088457 # convert ha-m to ac-ft

loc <- "volF"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

loc <- "volG"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("G ", loc, ".txt", sep=""))

rm(list=ls())
