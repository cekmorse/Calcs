ds <-ds[which(ds$ti>=trange[1] & ds$ti<=trange[2]),]
ds <- merge(tseries, ds, by="ti", all=TRUE)
colnames(ds) <- c("ti", "Depth", "Width", "Area", "Volume")
ds$Area <- ds$Area * .0001
ds$Volume <- ds$Volume * .0001
ds <- ts(ds, start=c(2006,274), frequency=365)

pdf(file=paste("Geo TimeSeries 01Day",locate,".pdf", sep=""), width=6, height=7, family="Times")
plot(as.zoo(ds[,2:5]), main="", yax.flip=TRUE,  ylab=list("D","W","A","V"))#oma.multi=c(6,0,1.1,0),
dev.off()

pdf(file=paste("Geo TimeSeries 07Day",locate,".pdf", sep=""), width=6, height=7, family="Times")
plot(rollapply(ds[,2:5], 7, mean, na.rm=T), main="", yax.flip=TRUE, oma.multi=c(6,0,1.1,0))
dev.off()

pdf(file=paste("Geo TimeSeries 14Day",locate,".pdf", sep=""), width=6, height=7, family="Times")
plot(rollapply(ds[,2:5], 14, mean, na.rm=T), main="", yax.flip=TRUE, oma.multi=c(6,0,1.1,0))
dev.off()

pdf(file=paste("Geo TimeSeries 30Day",locate,".pdf", sep=""), width=6, height=7, family="Times")
plot(rollapply(ds[,2:5], 30, mean, na.rm=T), main="", yax.flip=TRUE, oma.multi=c(6,0,1.1,0))
dev.off()