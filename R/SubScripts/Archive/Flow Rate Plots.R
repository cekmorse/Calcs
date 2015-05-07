dont use this file!!!

p97 <- apply(x, 1, quantile, probs=0.975, na.rm=TRUE)
p50 <- rowMeans(x, na.rm=TRUE)
p03 <- apply(x, 1, quantile, probs=0.025, na.rm=TRUE)

# ylimit <- c(-yMinMax,yMinMax)
# if(oneway == 1){ylimit <- c(0,yMinMax)}
fileName <- paste(plotFile,"Q ",locate,".pdf", sep="")

polys <- polylims(dates, p97, p03)
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.4,1.1,1.1)) 
plot(dates, p50, type="n", ylim=c(0, flowMax), xlab="Time", ylab=ylabel)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(dates, p50, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()
