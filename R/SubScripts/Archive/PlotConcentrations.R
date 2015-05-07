c1m <- melt(as.matrix(c1))$value
hist1 <- hist(se.est, plot=F)
den1 <- density(se.est, na.rm=T)
den2 <- density(c1m, na.rm=T)
ylimit <- c(0, max(hist1$density, den1$y, den2$y))
xlimit <- c(min(hist1$breaks, den1$x, den2$x), max(hist1$breaks, den1$x, den2$x))
pdf(file=paste("Concentrations ",loc,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(se.est, freq=F, ylim=ylimit, xlim=xlimit, main="", xlab=expression(paste("Se Concentration (",C[Se],") (", mu,"g/L)")))
lines(den1, lwd=2)
lines(den2, col="red", lwd=2)
legend("topright", legend=c("Kernel Density","Generated"), lwd=c(2,2), col=c("black","red"), bg="white")
mtext(paste("N =", length(se.est)), side=3, line=0, adj=.8)
dev.off()
t1 <- signif(rbind(Field=data.frame(Min=min(se.est, na.rm=T),
                                    P_2.5=quantile(se.est, 0.025, na.rm=T),
                                    Mean=mean(se.est, na.rm=T),
                                    P_97.5=quantile(se.est, 0.975, na.rm=T),
                                    Max=max(se.est, na.rm=T),
                                    SD=sd(se.est, na.rm=T),
                                    Skew=skewness(se.est, na.rm=T),
                                    Kurt=kurtosis(se.est, na.rm=T)), 
                   Generated=data.frame(Min=min(c1m, na.rm=T),
                                        P_2.5=quantile(c1m, 0.025, na.rm=T),
                                        Mean=mean(c1m, na.rm=T),
                                        P_97.5=quantile(c1m, 0.975, na.rm=T),
                                        Max=max(c1m, na.rm=T),
                                        SD=sd(c1m, na.rm=T),
                                        Skew=skewness(c1m, na.rm=T),
                                        Kurt=kurtosis(c1m, na.rm=T))), digits=4)
write.csv(t1, file=paste("Concentrations ",loc,".csv",sep=""))
rm(c1m,t1)