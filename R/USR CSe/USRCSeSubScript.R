if(ttl == "LAJWWTP"){
  meas <- y$cse
  tst <- nlsResiduals(lm.x)$resi1[,1]
  resid <- nlsResiduals(lm.x)$resi1[,2]
} else {
  meas <- lm.x$model[,1][!is.na(lm.x$model[,1])]
  tst <- lm.x$fitted.values[!is.na(lm.x$fitted.values)]
  resid <- lm.x$residuals[!is.na(lm.x$residuals)]
}

fileName <- paste(ttl, "_Scatter_Matrix-Base.pdf", sep="")
pdf(file=fileName, width = 6, height = 6, family = "Times")
par(mar = c(5.1,4.1,1.1,1.1))
pairs(y, lower.panel = panel.points, upper.panel = panel.cor, labels = pair.lab)
dev.off()

# Plot enhanced scatterplot matrix
fileName <- paste(ttl, "_Scatter_Matrix.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.1,4.1,1.1))
pairs(y.sub, lower.panel=panel.points, upper.panel=panel.cor, labels=pair.lab.sub)
dev.off()

# Plot predicted vs. measured
fileName <- paste(ttl,"_Meas_vs_Pred.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(tst, meas, pch=20, main="", ylab=expression(Measured~C[Se]~(mu*g~L^-1)), xlab=expression(Predicted~C[Se]~(mu*g~L^-1)))
abline(a=0, b=1, lty=1)
dev.off()

# Plot residual analysis plots
fileName <- paste(ttl,"_Resid_Analysis.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(4.1,4.1,1.5,2.1))
par(mfrow=c(2,2))
if(ttl == "LAJWWTP"){
     plot(nlsResiduals(lm.x), pch=20, which=0)    
} else {
     plot(lm.x, pch=20)
}
dev.off()

# Plot histogram of residuals
ylimit <- c(0, max(hist(resid, plot=FALSE)$density , density(resid)$y))
sigs <- 10^(nchar(signif(ylimit[2],2))-3)
ylimit <- ceiling(ylimit*sigs)/sigs
xlimit <- c(floor(min(hist(resid, plot=FALSE)$breaks, density(resid)$x)), ceiling(max(hist(resid, plot=FALSE)$breaks, density(resid)$x)))
xlimit <- c(-max(abs(xlimit)), max(abs(xlimit)))
fileName <- paste(ttl,"_Histogram_of_Residuals.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(resid, freq=FALSE, main="", xlab=expression(Residual~C[Se]~(mu*g~L^{-1})), col="grey90", ylim=ylimit, xlim=xlimit)
lines(density(resid),  lty=1, lwd=1)
dev.off()
