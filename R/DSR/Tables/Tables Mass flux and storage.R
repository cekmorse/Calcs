##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run1 <- function(fileName) {
  setwd(modelsFile)
  x <- load(fileName); sx <- get(x); rm(list=x)
  setwd(models.D)
  x <- load(fileName); dx <- get(x); rm(list=x)
  return(list("dx"=dx, "sx"=sx))
}
saveFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"
scaleConvert <- 1          # original units of kg/day are good
unitConvert <- 2.20462     # convert kg/day to lb/day

loc <- "D101C"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "D106C"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "BIG"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "BUF"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "FRO"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "WIL"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "Segment F"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

loc <- "Segment G"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F DSR ",loc,".txt", sep=""))

rm(list=ls())
