surfaceArea <- surfaceArea * 0.0001  # convert from square meters to hectares
volumeChange <- volumeChange * 0.0001 # convert from cubic meters to hectare meters

suppressMessages(meltDepthToday <- melt(depthToday, na.rm=TRUE)[,2])
suppressMessages(meltDepthYesterday <- melt(depthYesterday, na.rm=TRUE)[,2])
suppressMessages(meltWidthToday <- melt(widthToday, na.rm=TRUE)[,2])
suppressMessages(meltWidthYesterday <- melt(widthYesterday, na.rm=TRUE)[,2])
suppressMessages(meltArea <- melt(surfaceArea, na.rm=TRUE)[,2])
suppressMessages(meltVolume <- melt(volumeChange, na.rm=TRUE)[,2])

densityDepthToday <- density(meltDepthToday)
densityDepthYesterday <- density(meltDepthYesterday)
densityWidthToday <- density(meltWidthToday)
densityWidthYesterday <- density(meltWidthYesterday)
densityArea <- density(meltArea)
densityVolume <- density(meltVolume)

statsDepth <- data.frame(dates,
                         rowMeans(depthToday, na.rm=TRUE),
                         apply(depthToday, 1, sd, na.rm=TRUE),
                         apply(depthToday, 1, skewness, na.rm=TRUE),
                         apply(depthToday, 1, kurtosis, na.rm=TRUE),
                         apply(depthToday, 1, quantile, probs=c(0.025), na.rm=TRUE),
                         apply(depthToday, 1, quantile, probs=c(0.975), na.rm=TRUE))
statsWidth <- data.frame(dates, 
                         rowMeans(widthToday, na.rm=TRUE),
                         apply(widthToday, 1, sd, na.rm=TRUE),
                         apply(widthToday, 1, skewness, na.rm=TRUE),
                         apply(widthToday, 1, kurtosis, na.rm=TRUE),
                         apply(widthToday, 1, quantile, probs=c(0.025), na.rm=TRUE),
                         apply(widthToday, 1, quantile, probs=c(0.975), na.rm=TRUE))
statsArea <- data.frame(dates,
                        rowMeans(surfaceArea, na.rm=TRUE),
                        apply(surfaceArea, 1, sd, na.rm=TRUE),
                        apply(surfaceArea, 1, skewness, na.rm=TRUE),
                        apply(surfaceArea, 1, kurtosis, na.rm=TRUE),
                        apply(surfaceArea, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        apply(surfaceArea, 1, quantile, probs=c(0.975), na.rm=TRUE))
statsVolume <- data.frame(dates,
                          rowMeans(volumeChange, na.rm=TRUE),
                          apply(volumeChange, 1, sd, na.rm=TRUE),
                          apply(volumeChange, 1, skewness, na.rm=TRUE),
                          apply(volumeChange, 1, kurtosis, na.rm=TRUE),
                          apply(volumeChange, 1, quantile, probs=c(0.025), na.rm=TRUE),
                          apply(volumeChange, 1, quantile, probs=c(0.975), na.rm=TRUE))
colNames <- c("Date","Mean","StdDev","Skewness","Kurtosis","P.025","P.975")
colnames(statsDepth) <- colNames
colnames(statsWidth) <- colNames
colnames(statsArea) <- colNames
colnames(statsVolume) <- colNames

setwd(modelsFile)
save(statsDepth, file=paste("statsDepth ",segment,".Rdata",sep=""))
save(statsWidth, file=paste("statsWidth ",segment,".Rdata",sep=""))
save(statsArea, file=paste("statsArea ",segment,".Rdata",sep=""))
save(statsVolume, file=paste("statsVolume ",segment,".Rdata",sep=""))

setwd(plotFile)
pdf(file=paste("G depthToday ",segment,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(densityDepthToday, main="", xlab="Average Depth (m)", col="blue", xlim=c(0,2))
lines(densityDepthYesterday, col="red", lty=2)
legend("topright", legend=c("Time Step i","Time Step i-1"), col=c("red","blue"), lwd=c(1,1))
dev.off()

pdf(file=paste("G widthToday ",segment,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(densityWidthToday, main="", xlab="Average Width (m)", col="blue")
lines(densityWidthYesterday, col="red", lty=2)
legend("topright", legend=c("Time Step i","Time Step i-1"), col=c("red","blue"), lwd=c(1,1))
dev.off()

pdf(file=paste("G d&w Today ",segment,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
ylimit <- c(0,100)
xlabel <- "Date"
ylabel <- "River Depth or Width (m)"
plot(statsWidth$Date, statsWidth$Mean, ylim=ylimit, type="l", las=1, xlab=xlabel, ylab=ylabel)
lines(statsDepth$Date, statsDepth$Mean, type="l", col="red")
legend("topright", legend=c("Width", "Depth"), col=c("black","red"), lwd=c(1,1))
dev.off()

pdf(file=paste("G a&v ",segment,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
par(mfrow=c(2,1))
xlabel <- expression(Segment~Surface~Area~(ha))
plot(densityArea, main="", xlab=xlabel)
xlabel <- expression(Reach~Volume~Change~(ha~m~day^-1))
plot(densityVolume, main="", xlab=xlabel)
dev.off()

pdf(file=paste("G TS ",segment,".pdf",sep=""), width=6, height=7, family="Times")
size <- c(0.95, 0.7375, 0.525, 0.3125, 0.0)
polys <- polylims(statsDepth$Date, statsDepth$P.025, statsDepth$P.975)
ylabel <- "Flow Depth"
ylimit <- ylimit1
par(fig=c(0,1,size[2], size[1]))
par(mar=c(0,4.1,0,4.1))
plot(statsDepth$Date, statsDepth$Mean, type="n", ylim=ylimit, xlab="", ylab="", las=1, xaxt="n", yaxt="n", cex.axis=0.8)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(statsDepth$Date, dDepth, lwd=1, lty=2, col="red")
lines(statsDepth$Date, statsDepth$Mean, lwd=1, col="black")
abline(h=0, lty=2)
axis(4, las=1, cex.axis=0.8) #, at=c(0,.5,1,1.5), labels=c("0","0.5","1","1.5")
mtext(ylabel, side=4, line=2, cex=.8)
mtext(expression((m)), side=4, line=3, cex=0.8)

polys <- polylims(statsWidth$Date, statsWidth$P.025, statsWidth$P.975)
ylabel <- "Top Width"
ylimit <- ylimit2
par(fig=c(0,1,size[3],size[2]), new=TRUE)
plot(statsWidth$Date, statsWidth$Mean, type="n", ylim=ylimit, xlab="", ylab="", las=1, xaxt="n", cex.axis=0.8)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(statsWidth$Date, statsWidth$Mean, lwd=1, col="black")
abline(h=0, lty=2)
mtext(ylabel, side=2, line=3.2, cex=.8)
mtext(expression((m)), side=2, line=2.3, cex=0.8)

polys <- polylims(statsArea$Date, statsArea$P.025, statsArea$P.975)
ylimit <- ylimit3
ylabel <- "Surface Area"
par(fig=c(0,1,size[4],size[3]), new=TRUE)
plot(statsArea$Date, statsArea$Mean, type="n", ylim=ylimit, xlab="", ylab="", las=1, xaxt="n", yaxt="n", cex.axis=0.8)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(statsArea$Date, statsArea$Mean, lwd=1, col="black")
abline(h=0, lty=2)
axis(4, las=1, cex.axis=0.8) #, at=c(0,50,100,150), labels=c("0","50","100","150")
mtext(ylabel, side=4, line=2, cex=.8)
mtext(expression((ha)), side=4, line=3, cex=0.8)

polys <- polylims(statsVolume$Date, statsVolume$P.025, statsVolume$P.975)
ylimit <- ylimit4
ylabel <- "Volume Change"
yAxisDates <- c()
par(fig=c(0,1,size[5],size[4]), new=TRUE)
par(mar=c(3.1,4.1,0,4.1))
plot(statsVolume$Date, statsVolume$Mean, type="n", ylim=ylimit, xlab="", ylab="", las=1, yaxt="n", cex.axis=0.8)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(statsVolume$Date, statsVolume$Mean, lwd=1, col="black")
abline(h=0, lty=2)
axis(2, las=1, cex.axis=0.8)#at=c(-50,-25,0,25,50), labels=c("-50","-25","0","25","50"),
mtext(ylabel, side=2, line=3.2, cex=.8)
mtext(expression((ha%.%m)), side=2, line=2.3, cex=0.8)
mtext("Time", side=1, line=2, cex=0.8)
dev.off()

for(i in 1:2){
  if(i == 1){
    n <- 434
    if(is.na(min(depthToday[n,]))){
      while(is.na(min(depthToday[n,]))){n <- n-1}
      n <- n-1
    }
  } else {
    n <- 868
    if(is.na(min(depthToday[n,]))){
      while(is.na(min(depthToday[n,]))){n <- n+1}
      n <- n+1
    }
  } 
  depthReal <- as.numeric(depthToday[n,])
  widthReal <- as.numeric(widthToday[n,])
  areaReal <- as.numeric(surfaceArea[n,])
  volumeReal <- as.numeric(volumeChange[n,])
  densityDepth <- density(depthReal)
  densityWidth <- density(widthReal)
  densityArea <- density(areaReal)
  densityVolume <- density(volumeReal)
  histDepth <- hist(depthReal, plot=FALSE)
  histWidth <- hist(widthReal, plot=FALSE)
  histArea <- hist(areaReal, plot=FALSE)
  histVolume <- hist(volumeReal, plot=FALSE)
  
  xlabelDepth <- "Segment Average Depth (m)"
  xlabelWidth <- "Segment Average Width (m)"
  xlabelArea <- "Segment Surface Area (ha)"
  xlabelVolume <- "Segment Volume Change (ha m)"
  ylimDepth <- c(0, max(densityDepthToday$y, histDepth$density))
  ylimWidth <- c(0, max(densityWidthToday$y, histWidth$density))
  ylimArea <- c(0, max(densityArea$y, histArea$density))
  ylimVolume <- c(0, max(densityVolume$y, histVolume$density))  
  
  if(i ==1){
    pdf(file=paste("G TS time 1 ",segment,".pdf",sep=""), width=6, height=7, family="Times")
  } else {
    pdf(file=paste("G TS time 2 ",segment,".pdf",sep=""), width=6, height=7, family="Times")
  }
  par(mar=c(5.1,4.1,1.1,1.1))
  par(mfrow=c(4,1))
  hist(depthReal, freq=F, main="", xlab=xlabelDepth, ylim=ylimDepth)
  lines(densityDepth)
  hist(widthReal, freq=F, main="", xlab=xlabelWidth, ylim=ylimWidth)
  lines(densityWidth)
  hist(areaReal, freq=F, main="", xlab=xlabelArea, ylim=ylimArea)
  lines(densityArea)
  hist(volumeReal, freq=F, main="", xlab=xlabelVolume, ylim=ylimVolume)
  lines(densityVolume)
  dev.off()
}