Stats <- data.frame(date=dates,
                    P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                    Mean=rowMeans(x, na.rm=TRUE),
                    P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                    SD=apply(x, 1, sd, na.rm=TRUE),
                    Skew=apply(x, 1, skewness, na.rm=TRUE),
                    Kurt=apply(x, 1, kurtosis, na.rm=TRUE)
)

x <- Stats[,-1]
StatsStats <- data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                         xMean=colMeans(x, na.rm=TRUE),
                         xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                         xSD=apply(x, 2, sd, na.rm=TRUE),
                         xSkew=apply(x, 2, skewness, na.rm=TRUE),
                         xKurt=apply(x, 2, kurtosis, na.rm=TRUE)
)

setwd(modelsFile)
save(Stats, file=paste("f stats ",locate,".Rdata"))
setwd(resultsFile)
write.csv(StatsStats, paste("f stats ",locate,".csv"))

if(locate =="Segment A" || locate=="Segment B" || locate=="Segment C" || locate=="Segment D" || locate=="Segment E" || locate=="Segment F" || locate=="Segment G"){
  ytest <- c(abs(floor(min(Stats$Mean, na.rm=TRUE))), abs(ceiling(max(Stats$Mean, na.rm=TRUE))))
  ytest <- max(ytest)
  ylimit <- c(-ytest,ytest)
} else {
  ylimit <- c(0, ceiling(max(x, na.rm=TRUE)))
}

setwd(plotFile)
pdf(file=paste("f ",locate,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.4,1.1,1.1))
polys <- polylims(Stats$date, Stats$P.025, Stats$P.975)
plot(Stats$date, Stats$Mean, type="n", xlab="Date", ylab=ylabel, ylim=ylimit, las=1)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(Stats$date, Stats$Mean, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()
setwd(modelsFile)
