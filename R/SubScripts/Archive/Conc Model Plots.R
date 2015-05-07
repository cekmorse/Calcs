se.res <- se.lm$resid
se.er <- fitdist(se.res, distr="logis", method="mle")
seer <- rlogis(10000, se.er$est[[1]], se.er$est[[2]])
se.coef <- se.lm$coef
se.adj <- summary(se.lm)$adj

pdf(file=paste("Conc Model lm-fit ",locate,".pdf",sep=""), width=6, height=7, family="Times")
par(mfrow=c(2,2))
par(mar=c(5.1,4.1,1.5,1.1))
if(locate == "LAJWWTP"){
     plot(nlsResiduals(se.lm), which=0)    
} else {
     plot(se.lm, pch=20)
}
dev.off()

pdf(file=paste("Conc Model pred v meas ",locate,".pdf",sep=""), width=6, height=7, family="Times")
xlabel <- expression(paste("Predicted ",C[Se] ," (", mu*g %.% L^-1, ")"))
ylabel <- expression(paste("Measured ",C[Se] ," (", mu*g %.% L^-1, ")"))
par(mar=c(5.1,4.1,1.1,1.1))
plot(predict(se.lm), stoch.se, pch=20, xlab=xlabel, ylab=ylabel)
abline(a=0, b=1)
dev.off()

pdf(file=paste("Conc Model res-fit ",locate,".pdf",sep=""), width=6, height=7, family="Times")
plot(se.er, pch=20)
dev.off()

pdf(file=paste("Conc Model ResDist ",locate,".pdf",sep=""), width=6, height=7, family="Times")
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

write.csv(se.coef, paste("lmCoef_",locate,".csv", sep=""))
write.csv(se.adj, paste("lmAdj_",locate,".csv", sep=""))
save(se.coef, file=paste("se coef",locate,".Rdata", sep=""))
save(se.res, file=paste("se",locate,".Rdata", sep=""))