##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run <- function() {
  source("~/Projects/Calcs/R/SubScripts/River Geometry.R")
}

dMin <- 0.5*0.3048
dMax <- 5*0.3048
wMin <- 5
wMax <- 150
setwd(dataFile)
dataSet <- read.csv("Data.csv")
dates <- dataSet$DATE
dates <- as.Date(dates, "%m/%d/%Y")
times <- length(dates)
setwd(modelsFile)
load("qin.Rdata")
reals <- dim(q.in)[[2]]
rm(q.in)
load("DSRB1.Rdata")                  #EDIT THIS SET
load("DSRB2.Rdata")                  #
load("DSRBe.Rdata")                  #
b1Param1 <- DSRB1$est[[1]]           #
b1Param2 <- DSRB1$est[[2]]           #
b2Param1 <- DSRB2$est[[1]]           #
b2Param2 <- DSRB2$est[[2]]           #
beParam1 <- DSRBe$est[[1]]           #
beParam2 <- DSRBe$est[[2]]           #EDIT THIS SET 

####################### SEGMENT F
segment <- "F" 
setwd(dataFile)
depth <- dataSet$df.0                 #EDIT
segmentLength <- 23.4 * 1609.34       #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run()

####################### SEGMENT G
segment <- "G"                       #EDIT
setwd(modelsFile)
depth <- dataSet$dg.0                #EDIT
segmentLength <- 15.5 * 1609.34      #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run()

rm(list=ls())
