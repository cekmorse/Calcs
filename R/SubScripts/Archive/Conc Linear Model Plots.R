seer <- rlogis(10000, se.er$est[[1]], se.er$est[[2]])

pdf(file=paste("Conc Model Full Pairs",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,4.1,1.1))
pairs(zz, pch=20, upper.panel=panel.pearson, labels=pair.LAB, cex=1)
dev.off()

pdf(file=paste("Conc Model Pairs",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,4.1,1.1))
pairs(z, pch=20, upper.panel=panel.pearson, labels=pair.lab, cex=1)
dev.off()

pdf(file=paste("Conc Model lm-fit ",locate,".pdf",sep=""), width=6, height=6, family="Times")
if(locate == "UWTP"){
     par(mfrow=c(2,1))
     par(mar=c(5.1,4.1,1.5,1.1))
     resplot <- nlsResiduals(se.lm)
     plot(resplot, which=1)
     plot(resplot, which=4)
} else {
     par(mfrow=c(2,2))
     par(mar=c(5.1,4.1,1.5,1.1))
     plot(se.lm, pch=20)
}
dev.off()

pdf(file=paste("Conc Model pred v meas ",locate,".pdf",sep=""), width=6, height=6, family="Times")
ylabel <- expression(Predicted~C[Se]~(mu*g %.% L^-1))
xlabel <- expression(Measured~C[Se]~(mu*g %.% L^-1))
par(mar=c(5.1,4.1,1.1,1.1))
plot(z$se, predict(se.lm), pch=20, xlab=xlabel, ylab=ylabel)
abline(a=0, b=1)
dev.off()

pdf(file=paste("Conc Model res-fit ",locate,".pdf",sep=""), width=6, height=6, family="Times")
plot(se.er, pch=20)
dev.off()

pdf(file=paste("Conc Model ResDist ",locate,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
h1 <- hist(se.res, plot=F)
h2 <- hist(seer, plot=F)
d1 <- density(se.res)
d2 <- density(seer)
ylimit <- c(0, max(h1$density, h2$density, d1$y, d2$y))
xlimit <- c(min(h1$breaks, h2$breaks, d1$x, d2$x), max(h1$breaks, h2$breaks, d1$x, d2$x))
xlabel <- expression(paste(C[Se] ," (", mu*g %.% L^-1, ")"))
hist(se.res, freq=F, ylim=ylimit, xlim=xlimit, main="", xlab=xlabel)
lines(density(se.res), lwd=2)
lines(density(seer), lwd=2, col="red")
legend("topleft", legend=c("Kernel Density", "Fitted"), lwd=c(2,2), col=c("black","red"))
dev.off()

if(locate == "UWTP"){
     tst <- nlsResiduals(se.lm)$resi1[,1]
     resid <- nlsResiduals(se.lm)$resi1[,2]
     nas <- summary(se.lm)$na.action
} else {tst <- se.lm$fitted
        resid <- se.lm$resid
        nas <- se.lm$na.action[]      
}
if(is.null(nas)){meas <- z$se} else {meas <- z$se[-nas]}

# Get statistics
stats <- signif(rbind(Meas=data.frame(Min=min(meas, na.rm=T),
                                      P_2.5=quantile(meas, 0.025, na.rm=T),
                                      Mean=mean(meas, na.rm=T),
                                      P_97.5=quantile(meas, 0.975, na.rm=T),
                                      Max=max(meas, na.rm=T),
                                      SD=sd(meas, na.rm=T),
                                      Skew=skewness(meas, na.rm=T),
                                      Kurt=kurtosis(meas, na.rm=T)),
                      Fitted=data.frame(Min=min(tst, na.rm=T),
                                        P_2.5=quantile(tst, 0.025, na.rm=T),
                                        Mean=mean(tst, na.rm=T),
                                        P_97.5=quantile(tst, 0.975, na.rm=T),
                                        Max=max(tst, na.rm=T),
                                        SD=sd(tst, na.rm=T),
                                        Skew=skewness(tst, na.rm=T),
                                        Kurt=kurtosis(tst, na.rm=T)),
                      Resid=data.frame(Min=min(resid, na.rm=T),
                                       P_2.5=quantile(resid, 0.025, na.rm=T),
                                       Mean=mean(resid, na.rm=T),
                                       P_97.5=quantile(resid, 0.975, na.rm=T),
                                       Max=max(resid, na.rm=T),
                                       SD=sd(resid, na.rm=T),
                                       Skew=skewness(resid, na.rm=T),
                                       Kurt=kurtosis(resid, na.rm=T))),4)