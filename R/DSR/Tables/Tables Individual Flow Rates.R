##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run1 <- function(loc) {
  setwd(models.D)
  x <- load(paste(loc, ".Rdata", sep="")); dx <- get(x); rm(list=x)
  setwd(modelsFile)
  x <- load(paste(loc, ".Rdata", sep="")); sx <- get(x); rm(list=x)
  return(list("dx"=dx, "sx"=sx))
}

saveFolder <- "~/Projects/Text/Tables/"

# in m^3/(sec*km)
scaleConvert <- 1             # no scaling
unitConvert <- (1/0.3048)^3   # convert to cfs

loc <- "qin"
ds <- run1(loc)
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("DSR_",loc,".txt",sep=""))

loc <- "qout"
ds <- run1(loc)
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("DSR_",loc,".txt",sep=""))

loc <- "qBIG"
ds <- run1(loc)
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("DSR_",loc,".txt",sep=""))

loc <- "qBUF"
ds <- run1(loc)
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("DSR_",loc,".txt",sep=""))

loc <- "qFRO"
ds <- run1(loc)
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("DSR_",loc,".txt",sep=""))

loc <- "qWIL"
ds <- run1(loc)
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("DSR_",loc,".txt",sep=""))

rm(list=ls())
