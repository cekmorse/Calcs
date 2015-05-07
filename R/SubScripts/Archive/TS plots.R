par(mar=c(5.1,4.4,1.1,1.1))
plot(xx$ti, xx$mean, type="n", ylim=ylimit, xlab="Time", ylab=ylabel, las=1)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(xx$ti, xx$mean, lwd=1, col="black")
abline(h=0, lty=2)