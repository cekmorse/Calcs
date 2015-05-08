##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/D ConcRealizations.R")
}

reachLengthVector <- function(dist,length){
  temp <- dist * 5280 * 0.3048 / 1000 
  return <- rep(temp, length)
}

calcCMin <- function(db, point){
  return <- min(db[db$point == point, "cse"], na.rm=TRUE) * 0.5
}

setwd(modelsFile)
load("date.Rdata")

setwd(dataFile)
seData <- read.csv("SeEstData.csv")

setwd(models.D)
load("calcData.Rdata")
times <- length(dates)

lName <- "U163"
locate <- "U163"
cMin <- calcCMin(seData, locate)
run1()

lName <- "HOL"
locate <- "UDIV"
cMin <- 1.37
di <- reachLengthVector(7.8, times)
run1()

lName <- "FLS"
locate <- "UDIV"
cMin <- 1.47
di <- reachLengthVector(10.2, times)
run1()

lName <- "FLY"
locate <- "UDIV"
cMin <- 1.42
di <- reachLengthVector(29.3, times)
run1()

lName <- "CON"
locate <- "UDIV"
cMin <- 2.26
di <- reachLengthVector(52.8, times)
run1()

lName <- "U201"
locate <- "U201"
cMin <- calcCMin(seData, locate)
run1()

lName <- "RFD"
locate <- "U167"
cMin <- calcCMin(seData, locate)
run1()

lName <- "TIM"
locate <- "TIM"
cMin <- calcCMin(seData, locate)
run1()

lName <- "CAN"
locate <- "CAN"
cMin <- calcCMin(seData, locate)
run1()

lName <- "HRC"
locate <- "HRC"
cMin <- calcCMin(seData, locate)
run1()

lName <- "WTP"
locate <- "WTP"
cMin <- calcCMin(seData, locate)
run1()

rm(list=ls())
