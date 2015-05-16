setwd(models.D)
seData <- read.csv("~/Projects/Calcs/USR/Data/SeEstData.csv")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/SA ConcRealizations.R")
}

lName <- "U163"
locate <- "U163"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "HOL"
locate <- "UDIV"
cMin <- 1.37
di <- 7.8 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
run1()

lName <- "FLS"
locate <- "UDIV"
cMin <- 1.47
di <- 10.2 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
run1()

lName <- "FLY"
locate <- "UDIV"
cMin <- 1.42
di <- 29.3 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
run1()

lName <- "CON"
locate <- "UDIV"
cMin <- 2.26
di <- 52.8 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
run1()

lName <- "U201"
locate <- "U201"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "RFD"
locate <- "U167"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "TIM"
locate <- "TIM"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "CAN"
locate <- "CAN"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5  
run1()

lName <- "HRC"
locate <- "HRC"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5  
run1()

lName <- "WTP"
locate <- "WTP"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5  
run1()