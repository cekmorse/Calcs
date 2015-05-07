ylimit <- c(-yMinMax,yMinMax)
if(oneway == 1){ylimit <- c(0,yMinMax)}

polys <- polylims(x$date, x$P.975, x$P.025)
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.4,1.1,1.1))
plot(x$date, x$Mean, type="n", ylim=ylimit, xlab="Time", ylab=ylabel)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(x$date, x$Mean, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()
