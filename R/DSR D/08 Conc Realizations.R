##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/D ConcRealizations.R")
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

lName <- "D101C"
locate <- "D101C"
cMin <- calcCMin(seData, locate)
run1()

lName <- "D106C"
locate <- "D106C"
cMin <- calcCMin(seData, locate)
run1()

lName <- "BUF"
locate <- "DDIV"
cMin <- 2.5
di <- reachLengthVector(23.4, times)
run1()

lName <- "BIG"
locate <- "BIG"
cMin <- calcCMin(seData, locate)
run1()

lName <- "WIL"
locate <- "WIL"
cMin <- calcCMin(seData, locate)
run1()

rm(list=ls())