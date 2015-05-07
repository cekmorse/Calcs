##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")
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

scaleConvert <- 1
loc <- "c D101C"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c BIG"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c BUF"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c WIL"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c D106C"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment F"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment G"
ds <- run1(paste(loc, ".Rdata", sep="")) 
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

rm(list=ls())
