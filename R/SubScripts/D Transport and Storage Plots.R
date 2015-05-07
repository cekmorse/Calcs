Stats <- signif(data.frame(P.025=quantile(x, probs=0.025, na.rm=TRUE),
                    Mean=mean(x, na.rm=TRUE),
                    P.975=quantile(x, probs=0.975, na.rm=TRUE),
                    SD=sd(x, na.rm=TRUE),
                    Skew=skewness(x, na.rm=TRUE),
                    Kurt=kurtosis(x, na.rm=TRUE)),4)

setwd(models.D)
write.csv(Stats, paste("f stats ",locate,".Rdata"))

if(locate =="Segment A" || locate=="Segment B" || locate=="Segment C" || locate=="Segment D" || locate=="Segment E" || locate=="Segment F" || locate=="Segment G"){
  ytest <- c(abs(floor(min(x, na.rm=TRUE))), abs(ceiling(max(x, na.rm=TRUE))))
  ytest <- max(ytest)
  ylimit <- c(-ytest,ytest)
} else {
  ylimit <- c(0, ceiling(max(x, na.rm=TRUE)))
}

setwd(plot.D)
pdf(file=paste("f ",locate,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.4,1.1,1.1))
plot(dates, x, type="l", xlab="Date", ylab=ylabel, ylim=ylimit, las=1)
abline(h=0, lty=2)
dev.off()
setwd(models.D)