setwd(modelsFile)
geo.lm <- nls(tw ~ a*h^b, start=list(a=100, b=.1))
sumnl <- summary(geo.lm)
a <- sumnl$coef[[1]]
b <- sumnl$coef[[2]]
r <- sumnl$resid
# rse <- sumnl$sigma
rse <- RMSE(geo.lm)
save(geo.lm, file=paste("geolm sec ",i,".Rdata",sep=""))

setwd(plotFile)
Twest <- a*dx$h^b
compare <- data.frame(Obs=dx$tw, Est=Twest)
lmcompare <- lm(Obs~Est, data=compare)
sumlm <- summary(lmcompare)
comp.b <- sumlm$coef[[1]]
comp.m <- sumlm$coef[[2]]
comp.b.rnd <- round(comp.b,2)
comp.m.rnd <- round(comp.m,2)
comp.cor <- round(cor(compare)[[2]],2)
comp.r2 <- round(sumlm$r.s, 2)
comp.f <- round(sumlm$f[[1]], 2)
eq <- bquote(beta[1]==.(signif(a,4))~~~~~beta[2]==.(signif(b,4)))
eq1 <- bquote(Tw[Observed] == .(comp.m.rnd) %.% Tw[Estimated] + .(comp.b.rnd))
#eq2 <- bquote(R^2 == .(comp.r2)~~~~~F == .(comp.f)~~~~~df == .(sumlm$f[[2]])~and~.(sumlm$f[[3]]))
eq3 <- bquote(Correlation == .(comp.cor))
xlabel <- bquote(Tw[Estimated]~(m))
ylabel <- bquote(Tw[Observed]~(m))
xlabel1 <- bquote(Observed~Top~Width~(Tw[Observed])~(m))
ylabel1 <- bquote(Observed~Flow~Depth~(h[Observed])~(m))     

pdf(file=paste("Survey Tw Obs vs Est Analysis-Section ",i,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
par(mfrow=c(2,2))
plot(lmcompare, pch=20)
dev.off()

pdf(file=paste("Survey Tw Obs vs Est Comparison-Section ",i,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
plot(compare$Est, compare$Obs, pch=20, xlab=xlabel, ylab=ylabel)
abline(comp.b, comp.m, col="red")
mtext(eq1, 3, line=0, adj=0)
#mtext(eq2, 3, line=0, adj=0)
mtext(eq3, 3, line=0, adj=1)
dev.off()

pdf(file=paste("Survey Tw H Dist-Section ",i,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
par(mfrow=c(2,1))
ylimit <- c(0, max(hist(h, plot=F)$density, density(h)$y))
xlimit <- c(min(hist(h, plot=F)$breaks, density(h)$x), max(hist(h, plot=F)$breaks, density(h)$x))
hist(h, freq=F, ylim=ylimit, xlim=xlimit, main="", xlab=expression(Surveyed~Flow~Depth~(h)~(m)))
lines(density(h), lwd=2)
ylimit <- c(0, max(hist(tw, plot=F)$density, density(tw)$y))
xlimit <- c(min(hist(tw, plot=F)$breaks, density(tw)$x), max(hist(tw, plot=F)$breaks, density(tw)$x))
hist(tw, freq=F, ylim=ylimit, xlim=xlimit, main="", xlab=expression(Surveyed~Top~Width~(T[w])~(m)))
lines(density(tw), lwd=2)
dev.off()

pdf(file=paste("Survey Tw vs H-Section ",i,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
plot(dx$tw, dx$h, type="l", xlab=xlabel1, ylab=ylabel1)
points(dx$tw, dx$h, pch=20)
lines(Twest, dx$h, col="red")
points(Twest, dx$h, pch=20, col="red")
legend("topleft", legend=c("Observed","Estimated"), col=c("black","red"), lty=c(1,1), pch=c(20,20))
mtext(eq, 3, line=0, adj=0)
dev.off()

pdf(file=paste("Survey Tw Residuals-Section ",i,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
ylimit <- c(0, max(hist(r, plot=F)$density, density(r)$y))
xlimit <- c(min(hist(r, plot=F)$breaks, density(r)$x), max(hist(r, plot=F)$breaks, density(r)$x))
hist(r, freq=F, ylim=ylimit, xlim=xlimit, main="", xlab=expression(Surveyed~Top~Width~Residuals~(T[w])~(m)))
lines(density(r), lwd=2)
rug(r)
dev.off()