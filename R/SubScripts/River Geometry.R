depth[depth < dMin] <- NA
depth[depth > dMax] <- NA

b1Vector <- rep(-1, reals)
b2Vector <- b1Vector

for(i in 1:reals){
  while(b1Vector[i] <= 0 || b1Vector[i] >= 100){b1Vector[i] <- rlogis(1, location=b1Param1, scale=b1Param2)}
  while(b2Vector[i] <= 0 || b2Vector[i] >= 1){b2Vector[i] <- rlnorm(1, meanlog=b2Param1, sdlog=b2Param2)}
}

 b1Matrix <- data.frame(matrix(b1Vector, nrow=times, ncol=reals, byrow=TRUE))
 b2Matrix <- data.frame(matrix(b2Vector, nrow=times, ncol=reals, byrow=TRUE))

if(segment == "F" || segment == "G"){
  beMatrix <- data.frame(matrix(rlnorm(reals*times, meanlog=beParam1, sdlog=beParam2), nrow=times, ncol=reals))
} else {
  beMatrix <- data.frame(matrix(rlogis(reals*times, location=beParam1, scale=beParam2), nrow=times, ncol=reals))
}

sdMeasureError <- 0.01*0.3048/3.9
sdLocationError <- 0.25*0.3048/3.9
sdError <- sdMeasureError + sdLocationError

depthMatrix <- data.frame(matrix(NA, nrow=times, ncol=reals, byrow=FALSE))

sdErrorVector <- rep(sdError, times=length(depth))
sdErrorVector[is.na(depth)] <- -1

depth[is.na(depth)] <- -999

depthMatrix <- data.frame(apply(depthMatrix, 2, rtnorm, mean=depth, sd=sdErrorVector, lower=dMin, upper=dMax))
depthMatrix[is.nan(depthMatrix)] <- NA

# print(paste(segment,"Depth Done"))

depthToday <- depthMatrix
depthYesterday <- data.frame(rbind(NA,depthToday[1:(times-1),]))

widthToday <- b1Matrix * depthMatrix ^ b2Matrix + beMatrix

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
#   print(paste("count =",count2,"   trips =",trips))
}

# print(paste(segment,"Width Done"))

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
