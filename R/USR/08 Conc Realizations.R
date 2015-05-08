##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run <- function() {
  source("~/Projects/Calcs/R/SubScripts/ConcRealizations.R")
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

lName <- "U163"
locate <- "U163"
cMin <- calcCMin(seData, locate)
run()

lName <- "HOL"
locate <- "UDIV"
cMin <- 1.37
di <- reachLengthVector(7.8, times)
run()

lName <- "FLS"
locate <- "UDIV"
cMin <- 1.47
di <- reachLengthVector(10.2, times)
run()

lName <- "FLY"
locate <- "UDIV"
cMin <- 1.42
di <- reachLengthVector(29.3, times)
run()

lName <- "CON"
locate <- "UDIV"
cMin <- 2.26
di <- reachLengthVector(52.8, times)
run()

lName <- "U201"
locate <- "U201"
cMin <- calcCMin(seData, locate)
run()

lName <- "RFD"
locate <- "U167"
cMin <- calcCMin(seData, locate)
run()

lName <- "TIM"
locate <- "TIM"
cMin <- calcCMin(seData, locate)
run()

lName <- "CAN"
locate <- "CAN"
cMin <- calcCMin(seData, locate)
run()

lName <- "HRC"
locate <- "HRC"
cMin <- calcCMin(seData, locate)
run()

lName <- "WTP"
locate <- "WTP"
cMin <- calcCMin(seData, locate)
run()

rm(list=ls())