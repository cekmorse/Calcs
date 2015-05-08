##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")
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
loc <- "c U163"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c CAN"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c CON"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c FLS"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c FLY"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c HOL"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c HRC"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c RFD"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c TIM"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c WTP"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c U201"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment A"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment B"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment C"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment D"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

loc <- "c Segment E"
ds <- run1(paste(loc, ".Rdata", sep=""))
makeSimpleTable(ds$dx, ds$sx, scaleConvert, saveFolder, paste(loc, ".txt", sep=""))

rm(list=ls())