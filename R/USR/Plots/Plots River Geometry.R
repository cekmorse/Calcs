##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/River Geometry Plots.R")
}

segment <- "A"
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
load(file="date.Rdata")
ylimit1 <- c(0,1.5)
ylimit2 <- c(0,150)
ylimit3 <- c(0,180)
ylimit4 <- c(-50,50)
run1()

segment <- "B"
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
ylimit2 <- c(0,150)
ylimit3 <- c(0,50)
ylimit4 <- c(-10,10)
run1()

segment <- "C"
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
ylimit2 <- c(0,150)
ylimit3 <- c(0,400)
ylimit4 <- c(-100,100)
run1()

segment <- "D"
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
ylimit2 <- c(0,150)
ylimit3 <- c(0,500)
ylimit4 <- c(-150,150)
run1()

segment <- "E"
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
ylimit2 <- c(0,150)
ylimit3 <- c(0,200)
ylimit4 <- c(-50,50)
run1()

rm(list=ls())