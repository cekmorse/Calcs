sValVect <- rowMeans(sValMatr, na.rm=TRUE)
sValDens <- density(sValVect, na.rm=TRUE)
sValMean <- mean(sValVect, na.rm=TRUE)

eValDens <- density(eValVect, na.rm=TRUE)
eValMean <- mean(eValVect, na.rm=TRUE)

diff <- sValVect - eValVect
pDiff <- (diff / eValVect) * 100

locDifMin <- which.min(diff)
locDifMax <- which.max(diff)
locPdifMin <- which.min(pDiff)
locPdifMax <- which.max(pDiff)
dMin <- signif(diff[locDifMin],3)
dMax <- signif(diff[locDifMax],3)
pMin <- signif(pDiff[locPdifMin],3)
pMax <- signif(pDiff[locPdifMax],3)

difMin <- as.numeric(sValMatr[locDifMin,])
difMax <- as.numeric(sValMatr[locDifMax,])
pdifMin <- as.numeric(sValMatr[locPdifMin,])
pdifMax <- as.numeric(sValMatr[locPdifMax,])

densDifMin <- density(difMin)
densDifMax <- density(difMax)
densPdifMin <- density(pdifMin)
densPdifMax <- density(pdifMax)

expDMin <- eValVect[locDifMin]
expDMax <- eValVect[locDifMax]
expPMin <- eValVect[locPdifMin]
expPMax <- eValVect[locPdifMax]
sPMin <- sValVect[locDifMin]
sDMax <- sValVect[locDifMax]
sPMin <- sValVect[locPdifMin]
sPMax <- sValVect[locPdifMax]

dtable <- signif(rbind(Determ=data.frame(Min=min(eValVect, na.rm=T),
                                         P_2.5=quantile(eValVect, 0.025, na.rm=T),
                                         Mean=eValMean,
                                         P_97.5=quantile(eValVect, 0.975, na.rm=T),
                                         Max=max(eValVect, na.rm=T),
                                         SD=sd(eValVect, na.rm=T),
                                         Skew=skewness(eValVect, na.rm=T),
                                         Kurt=kurtosis(eValVect, na.rm=T)),
                       Stoch=data.frame(Min=min(sValVect, na.rm=T),
                                        P_2.5=quantile(sValVect, 0.025, na.rm=T),
                                        Mean=mean(sValVect, na.rm=T),
                                        P_97.5=quantile(sValVect, 0.975, na.rm=T),
                                        Max=max(sValVect, na.rm=T),
                                        SD=sd(sValVect, na.rm=T),
                                        Skew=skewness(sValVect, na.rm=T),
                                        Kurt=kurtosis(sValVect, na.rm=T))),4)
setwd(resultsFile)
write.csv(dtable, file=paste("V density ",dName,".csv", sep=""))

dtable <- signif(rbind(Diff=data.frame(Min=min(diff, na.rm=T),
                                       P_2.5=quantile(diff, 0.025, na.rm=T),
                                       Mean=mean(diff, na.rm=T),
                                       P_97.5=quantile(diff, 0.975, na.rm=T),
                                       Max=max(diff, na.rm=T),
                                       SD=sd(diff, na.rm=T),
                                       Skew=skewness(diff, na.rm=T),
                                       Kurt=kurtosis(diff, na.rm=T)),
                       PctDiff=data.frame(Min=min(pDiff, na.rm=T),
                                          P_2.5=quantile(pDiff, 0.025, na.rm=T),
                                          Mean=mean(pDiff, na.rm=T),
                                          P_97.5=quantile(pDiff, 0.975, na.rm=T),
                                          Max=max(pDiff, na.rm=T),
                                          SD=sd(pDiff, na.rm=T),
                                          Skew=skewness(pDiff, na.rm=T),
                                          Kurt=kurtosis(pDiff, na.rm=T))),4)
write.csv(dtable, file=paste("V difference ",dName,".csv", sep=""))

setwd(plotFile)
pdf(file=paste("V density ",dName,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,5.1,1.1,1.1))
hist(eValVect, freq=F, breaks="Scott", main="", xlab=densXlab, xlim=densXlim, ylim=densYlim)
lines(eValDens)
lines(sValDens, col="red", lty=2)
abline(v=eValMean, lty=4)
abline(v=sValMean, col="red", lty=3)
legend("topright", legend=c("Determinsitic KDE","Stochastic KDE"), col=c("black","red"), lty=c(1,2))
dev.off()

pdf(file=paste("V dev diff ",dName,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,5.1,1.1,1.1))
if(substring(dName,1,1) == "t"){
  plot(density(diff, na.rm=T), main="", xlab=diffXlab, xlim=diffXlim)
} else {
  plot(density(diff, na.rm=T), main="", xlab=diffXlab)
}
abline(v=quantile(diff, probs=c(0.025,0.975), na.rm=TRUE), lty=2)
abline(v=quantile(diff, probs=c(0.5), na.rm=TRUE))
dev.off()

pdf(file=paste("V dev pdiff ",dName,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,5.1,1.1,1.1))
if(substring(dName,1,1) == "t"){
  plot(density(pDiff, na.rm=T), main="",xlab="Percent Deviation from Expected Value (%)", xlim=pdifXlim)
} else {
  plot(density(pDiff, na.rm=T), main="",xlab="Percent Deviation from Expected Value (%)")
}
abline(v=quantile(pDiff, probs=c(0.025,0.975), na.rm=TRUE), lty=2)
abline(v=quantile(diff, probs=c(0.5), na.rm=TRUE))
dev.off()

pdf(file=paste("V min-max diff ",dName,".pdf",sep=""), width=6, height=6, family="Times")
par(mfrow=c(2,1))
par(mar=c(5.1,5.1,1.1,1.1))
plot(densDifMin, main="", xlab=densXlab)
abline(v=quantile(difMin, probs=c(0.5), na.rm=TRUE), lty=2)
abline(v=expDMin, col="red")
mtext(paste("Difference = ", dMin,sep=""), 3, adj=0)
# mtext(paste("Expected Value = ", signif(expDMin,3),sep=""), 3, adj=1)
legend("topright", legend=c("Mean","Expected Value"), lty=c(2,1), col=c("black","red"))
plot(densDifMax, main="", xlab=densXlab)
abline(v=quantile(difMax, probs=c(0.5), na.rm=TRUE), lty=2)
abline(v=expDMax, col="red")
mtext(paste("Difference = ", dMax,sep=""), 3, adj=0)
# mtext(paste("Expected Value = ", signif(expDMax,3),sep=""), 3, adj=1)
dev.off()

pdf(file=paste("V min-max pdiff ",dName,".pdf",sep=""), width=6, height=6, family="Times")
par(mfrow=c(2,1))
par(mar=c(5.1,5.1,1.1,1.1))
plot(densPdifMin, main="", xlab=densXlab)
abline(v=quantile(pdifMin, probs=c(0.5), na.rm=TRUE), lty=2)
abline(v=expPMin, col="red")
mtext(paste("% Difference = ", pMin,sep=""), 3, adj=0)
legend("topright", legend=c("Mean","Expected Value"), lty=c(2,1), col=c("black","red"))
plot(densPdifMax, main="", xlab=densXlab)
abline(v=quantile(pdifMax, probs=c(0.5), na.rm=TRUE), lty=2)
abline(v=expPMax, col="red")
mtext(paste("% Difference = ", pMax,sep=""), 3, adj=0)
dev.off()

setwd(modelsFile)