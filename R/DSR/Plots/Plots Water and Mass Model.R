##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/Water and Mass Model Plots.R")
}

ylabel1 <- expression(Cumulative~Volume~Change~~(m^3*day^-1*km^-1))
ylabel2 <- expression(Cumulative~Se~Mass~Change~~(kg*day^-1*km^-1))
ylabel3 <- expression(Se~Concentration~~(C[Se])~(mu*g~L^-1))

setwd(modelsFile)
load("date.Rdata")

y <- load("m atmChangeStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.005
oneway <- 0
ylabel <- ylabel1
fileName <- "Balance Water - atm.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m flowChangeStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.25
ylabel <- expression(sum(Flow~rates)~~(m^3*s^-1*km^-1))
fileName <- "Balance Water - flow.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m storageChangeStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.2
ylabel <- ylabel1
fileName <- "Balance Water - storage.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m unknownWaterStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.2
ylabel <- ylabel1
fileName <- "Balance Water.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m massFluxStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.25
ylabel <- ylabel2
fileName <- "Balance Mass - Flux.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m massStoreChangeStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.1
ylabel <- ylabel2
fileName <- "Balance Mass - Storage.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m unknownMassStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 0.3
ylabel <- ylabel2
fileName <- "Balance Mass.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

y <- load("m unknownCStats.Rdata")
x <- get(y); rm(list=y)
yMinMax <- 1000
ylabel <- ylabel3
fileName <- "Balance C.pdf"
setwd(plotFile); run1(); setwd(modelsFile)

# y <- load("m unknownCinStats.Rdata")
# x <- get(y); rm(list=y)
# d <- x[,1]; x<-x[,-1]
# x[x<0] <- 0
# x <- abs(x)
# x <- cbind(d,x)
# colnames(x) <- c("date","P.025","Mean","P.975","SD","Skew","Kurt")
# oneway <- 1
# yMinMax <- 600
# ylabel <- ylabel3
# fileName <- "Balance Cin.pdf"
# setwd(plotFile); run1(); setwd(modelsFile)
# 
# y <- load("m unknownCoutStats.Rdata")
# x <- get(y); rm(list=y)
# d <- x[,1]; x<-x[,-1]
# x[x>0] <- 0
# x <- abs(x)
# x <- cbind(d,x)
# colnames(x) <- c("date","P.975","Mean","P.025","SD","Skew","Kurt")
# oneway <- 1
# yMinMax <- 600
# ylabel <- ylabel3
# fileName <- "Balance Cout.pdf"
# setwd(plotFile); run1(); setwd(modelsFile)

rm(list=ls())
