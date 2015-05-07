##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")
saveFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

setwd(models.D)
load("calcData.Rdata")

setwd(modelsFile)

scaleConvert <- 1             # original units of m^3/s are good
unitConvert  <- (1/0.3048)^3  # convert m^3/s to cfs

dx <- calcData$q.in
setwd(modelsFile)
x <- load("qin.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qIN.txt")

dx <- calcData$q.CAN
setwd(modelsFile)
x <- load("qCAN.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qCAN.txt")

dx <- calcData$q.CON
setwd(modelsFile)
x <- load("qCON.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qCON.txt")

dx <- calcData$q.FLS
setwd(modelsFile)
x <- load("qFLS.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qFLS.txt")

dx <- calcData$q.FLY
setwd(modelsFile)
x <- load("qFLY.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qFLY.txt")

dx <- calcData$q.HOL
setwd(modelsFile)
x <- load("qHOL.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qHOL.txt")

dx <- calcData$q.HRC
setwd(modelsFile)
x <- load("qHRC.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qHRC.txt")

dx <- calcData$q.RFD
setwd(modelsFile)
x <- load("qRFD.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qRFD.txt")

dx <- calcData$q.RFR
setwd(modelsFile)
x <- load("qRFR.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qRFR.txt")

dx <- calcData$q.TIM
setwd(modelsFile)
x <- load("qTIM.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qTIM.txt")

dx <- calcData$q.WTP
setwd(modelsFile)
x <- load("qWTP.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qWTP.txt")

dx <- calcData$q.out
setwd(modelsFile)
x <- load("qout.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR qOUT.txt")

scaleConvert <- 1             # original units of dS/m are good
unitConvert  <- 1             # NR

dx <- calcData$ec.in
setwd(modelsFile)
x <- load("ecin.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V USR ecIN.txt")

dx <- calcData$ec.out
setwd(modelsFile)
x <- load("ecout.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V USR ecOUT.txt")

scaleConvert <- 1             # original units of deg C are good
unitConvert  <- 1             # convert C to F -- not done at this time

dx <- calcData$t.in
setwd(modelsFile)
x <- load("tin.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V USR tIN.txt")

dx <- calcData$t.out
setwd(modelsFile)
x <- load("tout.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V USR tOUT.txt")

scaleConvert <- 1             # original units of m are good
unitConvert  <- 1/0.3048      # convert m to ft 

dx <- calcData$dA1
setwd(modelsFile)
x <- load("depthA1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR dA.txt")

dx <- calcData$dB1
setwd(modelsFile)
x <- load("depthB1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR dB.txt")

dx <- calcData$dC1
setwd(modelsFile)
x <- load("depthC1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR dC.txt")

dx <- calcData$dD1
setwd(modelsFile)
x <- load("depthD1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR dD.txt")

dx <- calcData$dE1
setwd(modelsFile)
x <- load("depthE1.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR dE.txt")

scaleConvert <- 1000          # original units of m converted to mm
unitConvert  <- 1/25.4        # convert mm to in 

dx <- calcData$et
setwd(modelsFile)
x <- load("et.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR et.txt")

dx <- calcData$p
setwd(modelsFile)
x <- load("p.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR p.txt")

scaleConvert <- 1             # original units of % are acceptable
unitConvert  <- 1             # no conversion

dx <- calcData$RHmin
setwd(modelsFile)
x <- load("RHmin.Rdata"); sx <- get(x); rm(list=x)
makeSimpleTable(dx, sx, scaleConvert, saveFolder, "V USR RHmin.txt")

scaleConvert <- 1             # original units of m/s are acceptable
unitConvert  <- 1/0.3048      # convert to ft/s

dx <- calcData$u2
setwd(modelsFile)
x <- load("u2.Rdata"); sx <- get(x); rm(list=x)
makeTable(dx, sx, scaleConvert, unitConvert, saveFolder, "V USR u2.txt")

rm(list=ls())
