depthYesterday <- c(NA,depthToday[1:(times-1)])

widthToday <- cd2$geomB1 * depthToday ^ cd2$geomB2
widthYesterday <- c(NA,widthToday[1:(times-1)])

surfaceArea <- widthToday * segmentLength
volumeChange <- (widthToday + widthYesterday)/2 * (depthToday - depthYesterday) * segmentLength

save(surfaceArea, file=paste("area",segment,".Rdata", sep=""))
save(volumeChange, file=paste("vol",segment,".Rdata", sep=""))