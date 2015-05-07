ha <- ha * 0.0001
hv <- hv * 0.0001
md <- density(hd)
mw <- density(hw)
ma <- density(ha)
mv <- density(hv)
hsd <- hist(hd, plot=F)
hsw <- hist(hw, plot=F)
hsa <- hist(ha, plot=F)
hsv <- hist(hv, plot=F)
xld <- "Reach Average Depth (m)"
xlw <- "Reach Average Width (m)"
xla <- paste("Reach Surface Area (ha)", sep="")
xlv <- expression(paste("Reach Volume Change (",ha %.% m,")", sep=""))
yld <- c(0, max(md$y, hsd$density))
ylw <- c(0, max(mw$y, hsw$density))
yla <- c(0, max(ma$y, hsa$density))
ylv <- c(0, max(mv$y, hsv$density))


pdf(file=paste("Geo Reach ",locate," Dist ",i,".pdf",sep=""), width=6, height=7, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
par(mfrow=c(4,1))
hist(hd, freq=F, main="", xlab=xld, ylim=yld)
lines(md)
hist(hw, freq=F, main="", xlab=xlw, ylim=ylw)
lines(mw)
hist(ha, freq=F, main="", xlab=xla, ylim=yla)
lines(ma)
hist(hv, freq=F, main="", xlab=xlv, ylim=ylv)
lines(mv)
dev.off()

rm(md,mw,ma,mv,hsd,hsw,hsa,hsv,xld,xlw,xla,xlv,yld,ylw,yla,ylv)