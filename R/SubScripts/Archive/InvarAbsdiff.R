diff <- aa-bb
pdiff <- diff/aa*100
diff <- melt(diff)[[2]]
pdiff <- melt(pdiff)[[2]]
ylimit <- c(0, max(density(diff, na.rm=T)$y, na.rm=T))
pdiff[is.na(pdiff)] <- 0
pdf(file=paste("difference ",f,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,5.1,1.1,1.1))
plot(density(diff, na.rm=T), main="", xlab="Deviation", xlim=xlimit, ylim=ylimit, lwd=2)
abline(v=qnorm(c(0.025, 0.975), mean=mean(diff, na.rm=T), sd=sd(diff, na.rm=T)), lty=2)
abline(v=mean(diff, na.rm=T), lwd=2)
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
etable <- signif(rbind(data.frame(mean=mean(diff), sd=sd(diff)),
                data.frame(mean=mean(pdiff), sd=sd(pdiff))),4)
rownames(etable) <- c("Diff", "PctDiff")
write.csv(etable, file=paste("dif dist ",f,".csv", sep=""))
rm(diff, pdiff, dtable, etable)