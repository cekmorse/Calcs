##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

run <- function() {
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/River Geometry.R")
}

####################### SEGMENT A
segment <- "A"                       #EDIT
setwd(modelsFile)
load("qin.Rdata")
reals <- dim(q.in)[[2]]
rm(q.in)
setwd(dataFile)
dataSet <- read.csv("Data.csv")
depth <- dataSet$da.0                 #EDIT
dates <- dataSet$DATE
dates <- as.Date(dates, "%m/%d/%Y")
segmentLength <- 7.8 * 1609.34 #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
setwd(modelsFile)
load("USRB1.Rdata")
load("USRB2.Rdata")
load("USRBe.Rdata")
b1Param1 <- USRB1$est[[1]]
b1Param2 <- USRB1$est[[2]]
b2Param1 <- USRB2$est[[1]]
b2Param2 <- USRB2$est[[2]]
beParam1 <- USRBe$est[[1]]
beParam2 <- USRBe$est[[2]]
dMin <- 0.5*0.3048
dMax <- 5*0.3048
wMin <- 5
wMax <- 150
times <- length(depth)
run()

####################### SEGMENT C
segment <- "C"                       #EDIT
depth <- dataSet$dc.0                 #EDIT
segmentLength <- 19.1 * 1609.34  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
setwd(modelsFile)
load("USRB1.Rdata")
load("USRB2.Rdata")
load("USRBe.Rdata")
b1Param1 <- USRB1$est[[1]]
b1Param2 <- USRB1$est[[2]]
b2Param1 <- USRB2$est[[1]]
b2Param2 <- USRB2$est[[2]]
beParam1 <- USRBe$est[[1]]
beParam2 <- USRBe$est[[2]]
run()

####################### SEGMENT D
segment <- "D"                       #EDIT
depth <- dataSet$dd.0                 #EDIT
segmentLength <- 23.5 * 1609.34  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
setwd(modelsFile)
load("USRB1.Rdata")
load("USRB2.Rdata")
load("USRBe.Rdata")
b1Param1 <- USRB1$est[[1]]
b1Param2 <- USRB1$est[[2]]
b2Param1 <- USRB2$est[[1]]
b2Param2 <- USRB2$est[[2]]
beParam1 <- USRBe$est[[1]]
beParam2 <- USRBe$est[[2]]
run()

####################### SEGMENT E
segment <- "E"                       #EDIT
depth <- dataSet$de.0                 #EDIT
segmentLength <- 8.9 * 1609.34  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
setwd(modelsFile)
load("USRB1.Rdata")
load("USRB2.Rdata")
load("USRBe.Rdata")
b1Param1 <- USRB1$est[[1]]
b1Param2 <- USRB1$est[[2]]
b2Param1 <- USRB2$est[[1]]
b2Param2 <- USRB2$est[[2]]
beParam1 <- USRBe$est[[1]]
beParam2 <- USRBe$est[[2]]
run()

####################### SEGMENT B
segment <- "B"                       #EDIT
segmentLength <- 2.4 * 1609.34  #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
setwd(modelsFile)
load("USRB1.Rdata")
load("USRB2.Rdata")
load("USRBe.Rdata")
b1Param1 <- USRB1$est[[1]]
b1Param2 <- USRB1$est[[2]]
b2Param1 <- USRB2$est[[1]]
b2Param2 <- USRB2$est[[2]]
beParam1 <- USRBe$est[[1]]
beParam2 <- USRBe$est[[2]]
run()

load("depthA1.Rdata")
depthA <- depthToday
load("depthC1.Rdata")
depthC <- depthToday
depthToday <- (depthA + depthC)/2

load("depthA2.Rdata")
depthA <- depthYesterday
load("depthC2.Rdata")
depthC <- depthYesterday
depthYesterday <- (depthA + depthC)/2
rm(depthA, depthC)

b1Vector <- rep(-1, reals)
b2Vector <- b1Vector

for(i in 1:reals){
  while(b1Vector[i] <= 0 || b1Vector[i] >= 100){b1Vector[i] <- rlogis(1, location=b1Param1, scale=b1Param2)}
  while(b2Vector[i] <= 0 || b2Vector[i] >= 1){b2Vector[i] <- rlnorm(1, meanlog=b2Param1, sdlog=b2Param2)}
}

b1Matrix <- data.frame(matrix(b1Vector, nrow=times, ncol=reals, byrow=TRUE))
b2Matrix <- data.frame(matrix(b2Vector, nrow=times, ncol=reals, byrow=TRUE))

beMatrix <- data.frame(matrix(rlogis(reals*times, location=beParam1, scale=beParam2), nrow=times, ncol=reals))

sdMeasureError <- 0.01*0.3048/3.9
sdLocationError <- 0.25*0.3048/3.9
sdError <- sdMeasureError + sdLocationError

widthToday <- b1Matrix * depthToday ^ b2Matrix + beMatrix

## make the width error matrix
if(segment == "F" || segment == "G") {
  widthE1 <- data.frame(matrix(rlnorm(reals * times, meanlog=beParam1, sdlog=beParam2), nrow=times, ncol=reals))
} else {
  widthE1 <- data.frame(matrix(rlogis(reals * times, location=beParam1, scale=beParam2), nrow=times, ncol=reals))
}

## add width error to width
widthToday <- widthToday + widthE1
trips <- 0

while (trips <= 5) {
  zeros <- data.frame(matrix(0, nrow=times, ncol=reals))
  zeros[is.na(widthToday)] <- NA
  zeros[widthToday<wMin] <- 1
  zeros[widthToday>wMax] <- 1
  
  if(segment == "F" || segment == "G") {
    widthE1 <- data.frame(matrix(rlnorm(reals * times, meanlog=beParam1, sdlog=beParam2), nrow=times, ncol=reals)) * zeros
  } else {
    widthE1 <- data.frame(matrix(rlogis(reals * times, location=beParam1, scale=beParam2), nrow=times, ncol=reals)) * zeros
  }
  widthToday[widthToday<wMin] <- 0
  widthToday[widthToday>wMax] <- 0
  
  count1 <- length(widthToday[widthToday<wMin]) + length(widthToday[widthToday>wMax]) - length(widthToday[is.na(widthToday)])
  widthToday <- widthToday + widthE1
  count2 <- length(widthToday[widthToday<wMin]) + length(widthToday[widthToday>wMax]) - length(widthToday[is.na(widthToday)])
  if (count2 < count1) {
    trips <- 0
  } else {
    trips = trips + 1
  }
}

widthYesterday <- data.frame(rbind(NA,widthToday[1:(times-1),]))
surfaceArea <- widthToday * segmentLength
volumeChange <- (widthToday + widthYesterday)/2 * (depthToday - depthYesterday) * segmentLength

setwd(modelsFile)
save(depthToday, file=paste("depth",segment,"1.Rdata", sep=""))
save(depthYesterday, file=paste("depth",segment,"2.Rdata", sep=""))
save(widthToday, file=paste("width",segment,"1.Rdata", sep=""))
save(widthYesterday, file=paste("width",segment,"2.Rdata", sep=""))
save(surfaceArea, file=paste("area",segment,".Rdata", sep=""))
save(volumeChange, file=paste("vol",segment,".Rdata", sep=""))

rm(list=ls())