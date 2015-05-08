##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/D Water and Mass Model Plots.R")
}

ylabel1 <- expression(Cumulative~Volume~Change~~(m^3*day^-1*km^-1))
ylabel2 <- expression(Cumulative~Se~Mass~Change~~(kg*day^-1*km^-1))
ylabel3 <- expression(Se~Concentration~~(C[Se])~(mu*g~L^-1))

setwd(models.D)
load("date.Rdata")

load("m atmChange.Rdata")
x <- atmChange
rm(atmChange)
yMinMax <- 0.005
oneway <- 0
ylabel <- ylabel1
fileName <- "Balance Water - atm.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m flowChange.Rdata")
x <- flowChange
rm(flowChange)
yMinMax <- 0.25
ylabel <- expression(sum(Flow~rates)~~(m^3*s^-1*km^-1))
fileName <- "Balance Water - flow.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m storageChange.Rdata")
x <- storageChange
rm(storageChange)
yMinMax <- 0.2
ylabel <- ylabel1
fileName <- "Balance Water - storage.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m unknownWater.Rdata")
x <- unknownWater
rm(unknownWater)
yMinMax <- 0.2
ylabel <- ylabel1
fileName <- "Balance Water.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m massFlux.Rdata")
x <- massFlux
rm(massFlux)
yMinMax <- 0.25
ylabel <- ylabel2
fileName <- "Balance Mass - Flux.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m massStoreChange.Rdata")
x <- massStoreChange
rm(massStoreChange)
yMinMax <- 0.1
ylabel <- ylabel2
fileName <- "Balance Mass - Storage.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m unknownMass.Rdata")
x <- unknownMass
rm(unknownMass)
yMinMax <- 0.3
ylabel <- ylabel2
fileName <- "Balance Mass.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m unknownC.Rdata")
x <- unknownC
rm(unknownC)
yMinMax <- 500
ylabel <- ylabel3
fileName <- "Balance C.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m unknownCin.Rdata")
x <- unknownCin
rm(unknownCin)
oneway <- 1
yMinMax <- 600
ylabel <- ylabel3
fileName <- "Balance Cin.pdf"
setwd(plot.D); run1(); setwd(models.D)

load("m unknownCout.Rdata")
x <- unknownCout
x <- -1*x
rm(unknownCout)
oneway <- 1
yMinMax <- 60
ylabel <- ylabel3
fileName <- "Balance Cout.pdf"
setwd(plot.D); run1(); setwd(models.D)

rm(list=ls())
