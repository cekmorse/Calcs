##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

run <- function() {
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/ConcRealizations.R")
}

reachLengthVector <- function(dist,length){
  temp <- dist * 5280 * 0.3048 / 1000 
  return <- rep(temp, length)
}

calcCMin <- function(db, point){
  return <- min(db[db$point == point, "cse"], na.rm=TRUE) * 0.5
}

setwd(dataFile)
seData <- read.csv("SeEstData.csv")
setwd(modelsFile)
load("date.Rdata")
load("qin.Rdata")
load("calcData.Rdata")
load("bSe.Rdata")
reals <- dim(q.in)[2]
times <- dim(q.in)[1]
rm(q.in)
labErP1 <- bSe$est[[1]]
labErP2 <- bSe$est[[2]]
labErDist <- "logis"
rm(bSe)

lName <- "D101C"
locate <- "D101C"
cMin <- calcCMin(seData, locate)
run()

lName <- "D106C"
locate <- "D106C"
cMin <- calcCMin(seData, locate)
run()

lName <- "BUF"
locate <- "DDIV"
cMin <- 2.5
di <- reachLengthVector(23.4, times)
run()

lName <- "BIG"
locate <- "BIG"
cMin <- calcCMin(seData, locate)
run()

lName <- "WIL"
locate <- "WIL"
cMin <- calcCMin(seData, locate)
run()

rm(list=ls())