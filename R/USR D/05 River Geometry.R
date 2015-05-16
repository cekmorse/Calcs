##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/D River Geometry.R")
}
setwd(dataFile)
USRvar <- read.csv("data.csv", header=TRUE)

setwd(modelsFile)
load("date.Rdata")
load("USRB1.Rdata")
load("USRB2.Rdata")

geom <- c(USRB1$est[[1]], exp(USRB2$est[[1]]))

setwd(models.D)
save(geom, file="geom.Rdata")
times <- length(dates)
dMin <- 0.5*0.3048
dMax <- 5*0.3048

distConv <- 5280 * 0.3048  ## Convert miles to meters

####################### SEGMENT A
segment <- "A"                       #EDIT
depthToday <- USRvar$da.0
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 7.8 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()

####################### SEGMENT C
segment <- "C"                       #EDIT
depthToday <- USRvar$dc.0
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 19.1 * distConv  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()

####################### SEGMENT D
segment <- "D"                       #EDIT
depthToday <- USRvar$dd.0
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 23.5 * distConv  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()

####################### SEGMENT E
segment <- "E"                       #EDIT
depthToday <- USRvar$de.0
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 8.9 * distConv  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()

####################### SEGMENT B
segment <- "B"                       #EDIT
depthToday <- (USRvar$da.0 + USRvar$dc.0)/2
depthToday[which(depthToday < dMin)] <- NA
depthToday[which(depthToday > dMax)] <- NA
segmentLength <- 2.4 * distConv  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
run1()
rm(list=ls())
