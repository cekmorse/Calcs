##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(fileName) {
  setwd(modelsFile)
  x <- load(fileName); sx <- get(x); rm(list=x)
  setwd(models.D)
  x <- load(fileName); dx <- get(x); rm(list=x)
  return(list("dx"=dx, "sx"=sx))
}
saveFolder <- "~/Projects/Text/Tables/"
scaleConvert <- 1          # original units of kg/day are good
unitConvert <- 2.20462     # convert kg/day to lb/day

loc <- "U163"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "CAN"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "CON"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "FLS"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "FLY"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "HOL"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "HRC"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "RFD"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "RFR"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "TIM"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "WTP"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "U201"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))


loc <- "Segment A"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "Segment B"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "Segment C"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "Segment D"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

loc <- "Segment E"
ds <- run1(paste("f ",loc,".Rdata", sep=""))
makeTable(ds$dx, ds$sx, scaleConvert, unitConvert, saveFolder, paste("F USR ",loc,".txt", sep=""))

rm(list=ls())
