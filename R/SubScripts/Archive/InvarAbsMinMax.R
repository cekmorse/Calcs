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