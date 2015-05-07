##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")
saveFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

setwd(modelsFile)

scaleConvert <- 1000       # original units of m converted to mm
unitConvert  <- 1/25.4  # convert m to in

setwd(models.D)
findFile <- "A evap.Rdata"
x <- load(findFile);
dx <- get(x); rm(list=x)
setwd(modelsFile)
x <- load(findFile); 
sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "USR Evap.txt")

setwd(models.D)
findFile <- "p.Rdata"
x <- load(findFile);
dx <- get(x); rm(list=x)
setwd(modelsFile)
x <- load(findFile); 
sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "USR Precip.txt")

rm(list=ls())
