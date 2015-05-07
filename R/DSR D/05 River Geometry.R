##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/D River Geometry.R")
}
setwd(dataFile)
DSRvar <- read.csv("data.csv", header=TRUE)

setwd(modelsFile)
load("date.Rdata")
load("DSRB1.Rdata")
load("DSRB2.Rdata")

setwd(models.D)
geom <- c(DSRB1$est[[1]], exp(DSRB2$est[[1]]))
save(geom, file="geom.Rdata")
times <- length(dates)
dMin <- 0.5*0.3048
dMax <- 5*0.3048

####################### SEGMENT F
segment <- "F"                       #EDIT
depthToday <- DSRvar$df.0
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 23.4 * 1.60934 #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()

####################### SEGMENT G
segment <- "G"                       #EDIT
depthToday <- DSRvar$dg.0
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 15.5 * 1.60934 #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()
rm(list=ls())