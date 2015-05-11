##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/Water and Mass Model Plots.R")
}

ylabel1 <- expression(Cumulative~Volume~Change~~(m^3*day^-1*km^-1))
ylabel2 <- expression(Cumulative~Se~Mass~Change~~(kg*day^-1*km^-1))
ylabel3 <- expression(Se~Concentration~~(C[Se])~(mu*g~L^-1))

setwd(modelsFile)
load("date.Rdata")

load("m atmChangeStats.Rdata")
x <- atmChangeStats
rm(atmChangeStats)
oneway = 0
yMinMax <- 0.015
ylabel <- ylabel1
fileName <- "Balance Water - atm.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

load("m flowChangeStats.Rdata")
x <- flowChangeStats
rm(flowChangeStats)
yMinMax <- 0.5
ylabel <- expression(sum(Flow~rates)~~(m^3*s^-1*km^-1))
fileName <- "Balance Water - flow.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

 load("m storageChangeStats.Rdata")
x <- storageChangeStats
rm(storageChangeStats)
yMinMax <- 0.30
ylabel <- ylabel1
fileName <- "Balance Water - storage.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

load("m unknownWaterStats.Rdata")
x <- unknownWaterStats
rm(unknownWaterStats)
yMinMax <- 0.3
ylabel <- ylabel1
fileName <- "Balance Water.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

load("m massFluxStats.Rdata")
x <- massFluxStats
rm(massFluxStats)
yMinMax <- 0.25
ylabel <- ylabel2
fileName <- "Balance Mass - Flux.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

load("m massStoreChangeStats.Rdata")
x <- massStoreChangeStats
rm(massStoreChangeStats)
yMinMax <- 0.20
ylabel <- ylabel2
fileName <- "Balance Mass - Storage.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

load("m unknownMassStats.Rdata")
x <- unknownMassStats
rm(unknownMassStats)
yMinMax <- 0.30
ylabel <- ylabel2
fileName <- "Balance Mass.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

#####
load("m unknownCStats.Rdata")
x <- unknownCStats
rm(unknownCStats)
yMinMax <- 600
ylabel <- ylabel3
fileName <- "Balance C.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

load("m unknownCoutStats.Rdata")
x <- unknownCoutStats
rm(unknownCoutStats)
d <- x[,1]; x<-x[,-1]
x[x>0] <- 0
x <- abs(x)
x <- cbind(d,x)
colnames(x) <- c("date","P.975","Mean","P.025","SD","Skew","Kurt")
oneway <- 1
yMinMax <- 600
ylabel <- ylabel3
fileName <- "Balance Cout.pdf"
setwd(plotFile); run1();  setwd(modelsFile)

rm(list=ls())