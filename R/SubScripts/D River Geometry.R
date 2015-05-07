depthYesterday <- c(NA,depthToday[1:(times-1)])

widthToday <- geom[[1]] * depthToday ^ geom[[2]]
widthYesterday <- c(NA,widthToday[1:(times-1)])

surfaceArea <- widthToday * segmentLength
volumeChange <- (widthToday + widthYesterday)/2 * (depthToday - depthYesterday) * segmentLength

save(depthToday, file=paste("depth",segment,"1.Rdata", sep=""))
save(widthToday, file=paste("width",segment,"1.Rdata", sep=""))
save(surfaceArea, file=paste("area",segment,".Rdata", sep=""))
save(volumeChange, file=paste("vol",segment,".Rdata", sep=""))