area <- area * 0.0001
vol <- vol * 0.0001

pdf(file=paste("Geo Tw ",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(density(m1), main="", xlab="Average Width (m)", col="blue", xlim=c(0,400))
lines(density(m0), col="red")
legend("topright", legend=c("Time Step i","Time Step i+1"), col=c("red","blue"), lwd=c(1,1))
dev.off()

pdf(file=paste("Geo Vol Area ",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
par(mfrow=c(2,1))
ylimit <- c(0, max(density(area)$y, hist(area, plot=F)$density))
xlabel <- expression(paste("Reach Surface Area (",m^2,")", sep=""))
hist(area, freq=F, breaks="Scott", main="", xlab=xlabel, ylim=ylimit)
lines(density(area), lwd=2)
ylimit <- c(0, max(density(vol)$y, hist(vol, plot=F)$density))
xlimit <- c(-20, 20)
xlabel <- expression(paste("Reach Volume Change (",m^3 %.% day^-1,")", sep=""))
hist(vol, freq=F, breaks="Scott", main="", xlab=xlabel, ylim=ylimit, xlim=xlimit)
lines(density(vol), lwd=2)
dev.off()

ds <-ds[which(ds$ti>=trange[1] & ds$ti<=trange[2]),]
ds <- merge(tseries, ds, by="ti", all=TRUE)
colnames(ds) <- c("ti", "Depth", "Width", "Area", "Volume")
ds$Area <- ds$Area * 0.0001
ds$Volume <- ds$Volume * 0.0001
ds <- ts(ds, start=c(2006,274), frequency=365)

pdf(file=paste("Geo TimeSeries 01Day",locate,".pdf", sep=""), width=6, height=7, family="Times")
plot(ds[,2:5], main="", yax.flip=TRUE, oma.multi=c(6,0,1.1,0))
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