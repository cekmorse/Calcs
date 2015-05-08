##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/River Geometry Plots.R")
}

segment <- "F"
setwd(models.D)
load(file=paste("depth",segment,"1.Rdata",sep=""))
dDepth <- depthToday
setwd(modelsFile)
load(file=paste("depth",segment,"1.Rdata", sep=""))
load(file=paste("depth",segment,"2.Rdata", sep=""))
load(file=paste("width",segment,"1.Rdata", sep=""))
load(file=paste("width",segment,"2.Rdata", sep=""))
load(file=paste("area",segment,".Rdata", sep=""))
load(file=paste("vol",segment,".Rdata", sep=""))
ylimit1 <- c(0,1.5)
ylimit2 <- c(0,60)
ylimit3 <- c(0,250)
ylimit4 <- c(-100,100)
run1()

segment <- "G"
setwd(models.D)
load(file=paste("depth",segment,"1.Rdata",sep=""))
dDepth <- depthToday
setwd(modelsFile)
load(file=paste("depth",segment,"1.Rdata", sep=""))
load(file=paste("depth",segment,"2.Rdata", sep=""))
load(file=paste("width",segment,"1.Rdata", sep=""))
load(file=paste("width",segment,"2.Rdata", sep=""))
load(file=paste("area",segment,".Rdata", sep=""))
load(file=paste("vol",segment,".Rdata", sep=""))
ylimit1 <- c(0,1.5)
ylimit2 <- c(0,70)
ylimit3 <- c(0,200)
ylimit4 <- c(-50,150)
run1()

rm(list=ls())