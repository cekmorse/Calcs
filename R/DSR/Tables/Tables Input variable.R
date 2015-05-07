##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")
saveFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

setwd(models.D)
load("calcData.Rdata")

setwd(modelsFile)

scaleConvert <- 1             # original units of m^3/s are good
unitConvert  <- (1/0.3048)^3  # convert m^3/s to cfs

dx <- calcData$q.in
setwd(modelsFile)
x <- load("qin.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR qIN.txt")

dx <- calcData$q.BIG
setwd(modelsFile)
x <- load("qBIG.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR qCAN.txt")

dx <- calcData$q.BUF
setwd(modelsFile)
x <- load("qBUF.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR qCON.txt")

dx <- calcData$q.FRO
setwd(modelsFile)
x <- load("qFRO.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR qFLS.txt")

dx <- calcData$q.WIL
setwd(modelsFile)
x <- load("qWIL.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR qFLY.txt")

dx <- calcData$q.out
setwd(modelsFile)
x <- load("qout.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR qOUT.txt")

scaleConvert <- 1             # original units of dS/m are good
unitConvert  <- 1             # NR

dx <- calcData$ec.in
setwd(modelsFile)
x <- load("ecin.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V DSR ecIN.txt")

dx <- calcData$ec.out
setwd(modelsFile)
x <- load("ecout.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V DSR ecOUT.txt")

scaleConvert <- 1             # original units of deg C are good
unitConvert  <- 1             # convert C to F -- not done at this time

dx <- calcData$t.in
setwd(modelsFile)
x <- load("tin.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V DSR tIN.txt")

dx <- calcData$t.out
setwd(modelsFile)
x <- load("tout.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V DSR tOUT.txt")

scaleConvert <- 1             # original units of m are good
unitConvert  <- 1/0.3048      # convert m to ft 

dx <- calcData$dF1
setwd(modelsFile)
x <- load("depthF1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR dA.txt")

dx <- calcData$dG1
setwd(modelsFile)
x <- load("depthG1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR dB.txt")

scaleConvert <- 1000          # original units of m converted to mm
unitConvert  <- 1/25.4        # convert mm to in 

dx <- calcData$et
setwd(modelsFile)
x <- load("et.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR et.txt")

dx <- calcData$p
setwd(modelsFile)
x <- load("p.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR p.txt")

scaleConvert <- 1             # original units of % are acceptable
unitConvert  <- 1             # no conversion

dx <- calcData$RHmin
setwd(modelsFile)
x <- load("RHmin.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V DSR RHmin.txt")

scaleConvert <- 1             # original units of m/s are acceptable
unitConvert  <- 1/0.3048      # convert to ft/s

dx <- calcData$u2
setwd(modelsFile)
x <- load("u2.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V DSR u2.txt")

rm(list=ls())
