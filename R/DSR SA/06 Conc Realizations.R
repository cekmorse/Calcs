setwd(models.D)
seData <- read.csv("~/Projects/Calcs/DSR/Data/SeEstData.csv")

run1 <- function(){
    source("~/Projects/Calcs/R/SubScripts/SA ConcRealizations.R")
}

lName <- "D101C"
locate <- "D101C"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "D106C"
locate <- "D106C"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "BUF"
locate <- "DDIV"
cMin <- 2.5
di <- 23.4 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
run1()

lName <- "BIG"
locate <- "BIG"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()

lName <- "WIL"
locate <- "WIL"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
run1()