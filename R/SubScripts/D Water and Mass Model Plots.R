ylimit <- c(-yMinMax,yMinMax)
if(oneway == 1){ylimit <- c(0,yMinMax)}

pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.4,1.1,1.1))
plot(dates, x, type="l", ylim=ylimit, xlab="Time", ylab=ylabel)
abline(h=0, lty=2)
dev.off()
