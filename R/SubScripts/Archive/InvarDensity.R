
##########################
#
#  Density
#
##########################

mbb <- melt(bb)[,2]
ylimit <- c(0, max(density(mbb, na.rm=T)$y, density(aa, na.rm=T)$y, na.rm=T, hist(aa, breaks="FD", plot=F)$density))
pdf(file=paste("density ",f,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,5.1,1.1,1.1))
hist(aa, freq=F, breaks="Scott", main="", xlab=xlabel, xlim=xlimit, ylim=ylimit)
lines(density(aa, na.rm=T), lwd=2)
lines(density(mbb, na.rm=T), col="red")
abline(v=mean(aa, na.rm=T), lwd=2)
abline(v=mean(mbb, na.rm=T), col="red")
dev.off()
dtable <- signif(rbind(Determ=data.frame(Min=min(aa, na.rm=T),
                                         P_2.5=quantile(aa, 0.025, na.rm=T),
                                         Mean=mean(aa, na.rm=T),
                                         P_97.5=quantile(aa, 0.975, na.rm=T),
                                         Max=max(aa, na.rm=T),
                                         SD=sd(aa, na.rm=T)),
                       Stoch=data.frame(Min=min(mbb, na.rm=T),
                                        P_2.5=quantile(mbb, 0.025, na.rm=T),
                                        Mean=mean(mbb, na.rm=T),
                                        P_97.5=quantile(mbb, 0.975, na.rm=T),
                                        Max=max(mbb, na.rm=T),
                                        SD=sd(mbb, na.rm=T))),4)
write.csv(dtable, file=paste("density ",f,".csv", sep=""))
rm(mbb, dtable)

##########################
#
#  Percent Differnce
#
##########################

diff <- aa-bb
pdiff <- diff/aa*100
diff <- melt(diff)[[2]]
pdiff <- melt(pdiff)[[2]]
xlimit <- c(-40,40)
ylimit <- c(0, max(density(pdiff, na.rm=T)$y, na.rm=T))
pdf(file=paste("difference ",f,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,5.1,1.1,1.1))
plot(density(pdiff, na.rm=T), lwd=2, main="",xlab="Percent Deviation from Expected Value (%)", xlim=xlimit, ylim=ylimit, xaxt="n")
abline(v=qnorm(c(0.975,0.025), mean=mean(pdiff, na.rm=T), sd=sd(pdiff, na.rm=T)), lty=2)
abline(v=mean(pdiff, na.rm=T), lwd=2)
axis(1, at=c(-40,-20,-10,0,10,20,40))
dev.off()
dtable <- signif(rbind(Diff=data.frame(Min=min(diff, na.rm=T),
                                       P_2.5=quantile(diff, 0.025, na.rm=T),
                                       Mean=mean(diff, na.rm=T),
                                       P_97.5=quantile(diff, 0.975, na.rm=T),
                                       Max=max(diff, na.rm=T),
                                       SD=sd(diff, na.rm=T)),
                       PctDiff=data.frame(Min=min(pdiff, na.rm=T),
                                          P_2.5=quantile(pdiff, 0.025, na.rm=T),
                                          Mean=mean(pdiff, na.rm=T),
                                          P_97.5=quantile(pdiff, 0.975, na.rm=T),
                                          Max=max(pdiff, na.rm=T),
                                          SD=sd(pdiff, na.rm=T))),4)
write.csv(dtable, file=paste("difference ",f,".csv", sep=""))
# etable <- rbind(Diff=data.frame(t(fitdist(diff*100, "norm", method="mle")$est)),
#                 PctDiff=data.frame(t(fitdist(pdiff*100, "norm", method="mle")$est)))/100
etable <- signif(rbind(data.frame(mean=mean(diff), sd=sd(diff)),
                       data.frame(mean=mean(pdiff), sd=sd(pdiff))),4)
rownames(etable) <- c("Diff", "PctDiff")
write.csv(etable, file=paste("dif dist ",f,".csv", sep=""))
rm(diff, pdiff, dtable, etable)

##########################
#
#  Absolute Min-Max
#
##########################

diff <- aa-rowMeans(bb)
pdiff <- diff/aa*100
diff[is.na(diff)] <- 0
pdiff[is.na(pdiff)] <- 0
bbo <- data.frame(order=order(abs(diff)), bb)
aao <- data.frame(order=order(abs(diff)), aa)
bbmin <- melt(bbo[which(bbo$order==min(bbo$order)),-1])[,2]
bbmax <- melt(bbo[which(bbo$order==max(bbo$order)),-1])[,2]
aamin <- aao[which(aao$order==min(aao$order)),-1]
aamax <- aao[which(aao$order==max(aao$order)),-1]
pdf(file=paste("min-max diff ",f,".pdf",sep=""), width=6, height=6, family="Times")
par(mfrow=c(2,1))
par(mar=c(5.1,5.1,1.1,1.1))
ylimit <- c(0, max(hist(bbmax, plot=F)$density, density(bbmax)$y))
plot(density(bbmax), lwd=2, main="", ylim=ylimit, xlab=xlabel)
abline(v=mean(density(bbmax)$x), lwd=2)
abline(v=aamax, col="red")
d <- signif(mean(density(bbmax)$x - aamax),3)
mtext(paste("Difference = ", d,sep=""), 3, adj=0)
ylimit <- c(0, max(hist(bbmin, plot=F)$density, density(bbmin)$y))
plot(density(bbmin), lwd=2, main="", ylim=ylimit, xlab=xlabel)
abline(v=mean(density(bbmin)$x), lwd=2)
abline(v=aamin, col="red")
d <- signif(mean(density(bbmin)$x - aamin),3)
mtext(paste("Difference = ", d,sep=""), 3, adj=0)
dev.off()

bbo <- data.frame(order=order(abs(pdiff)), bb)
aao <- data.frame(order=order(abs(pdiff)), aa)
bbmin <- melt(bbo[which(bbo$order==min(bbo$order)),-1])[,2]
bbmax <- melt(bbo[which(bbo$order==max(bbo$order)),-1])[,2]
aamin <- aao[which(aao$order==min(aao$order)),-1]
aamax <- aao[which(aao$order==max(aao$order)),-1]
pdf(file=paste("min-max pdiff ",f,".pdf",sep=""), width=6, height=6, family="Times")
par(mfrow=c(2,1))
par(mar=c(5.1,5.1,1.1,1.1))
ylimit <- c(0, max(hist(bbmax, plot=F)$density, density(bbmax)$y))
plot(density(bbmax), lwd=2, main="", ylim=ylimit, xlab=xlabel)
abline(v=mean(density(bbmax)$x), lwd=2)
abline(v=aamax, col="red")
d <- signif(mean(density(bbmax)$x - aamax),3)
mtext(paste("Difference = ", d,sep=""), 3, adj=0)
ylimit <- c(0, max(hist(bbmin, plot=F)$density, density(bbmin)$y))
plot(density(bbmin), lwd=2, main="", ylim=ylimit, xlab=xlabel)
abline(v=mean(density(bbmin)$x))
abline(v=aamin, col="red")
d <- signif(mean(density(bbmin)$x - aamin),3)
mtext(paste("Difference = ", d,sep=""), 3, adj=0)
dev.off()
rm(diff, pdiff, bbo, aao, bbmin, bbmax, aamin, aamax)