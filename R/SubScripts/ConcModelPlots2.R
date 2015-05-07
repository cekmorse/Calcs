dHist <- hist(Dcalcm[,n], plot=F)
dDensity <- density(Dcalcm[,n], na.rm=T)
sDensity <- density(calcm[,n], na.rm=T)

setwd(plotFile)
pdf(file=paste("c d&s est ",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dHist, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(Dissolved~Se~Concentration~(C[Se])~(mu*g~L^-1)))
lines(dDensity)
lines(sDensity, col="red", lty=2)
legend(legLoc, legend=c("Determinsitic KDE","Stochastic KDE"), col=c("black","red"), lty=c(1,2))
dev.off()

polys <- polylims(dates, calc2[,n], calc9[,n])

pdf(file=paste("c TS ",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, calcm[,n], type="n", ylim=ylimit2, xlab="Date", ylab=expression(Dissolved~Selenium~Concentration~(C[Se])~(mu*g~L^-1)))
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(dates, calcm[,n], lwd=1, col="black")
abline(h=0, lty=2)
dev.off()

setwd(plot.D)
pdf(file=paste("c TS ",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, Dcalcm[,n], type="l", ylim=ylimit2, xlab="Date", ylab=expression(Dissolved~Selenium~Concentration~(C[Se])~(mu*g~L^-1)))
abline(h=0, lty=2)
dev.off()
