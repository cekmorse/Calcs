fd <- data.frame(DATE=DATE, f=rowMeans(f))
fd <- fd[which(fd$DATE >= trange[1] & fd$DATE <= trange[2]),]
fd <- merge(tline, fd, by="DATE", all=TRUE)
fd <- fd$f
tseries <- ts(data=fd, start=c(2006,274), frequency=365)

if(type == 1){
     ylabel <- expression(paste("Selenium Transport ( ",kg %.% day^-1,")"))
     pdf(file=paste(n,"-01Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(tseries, ylab=ylabel)
     dev.off()
     
     pdf(file=paste(n,"-07Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(rollapply(tseries, 7, mean, na.rm=T), ylab=ylabel)
     dev.off()
     
     pdf(file=paste(n,"-14Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(rollapply(tseries, 14, mean, na.rm=T), ylab=ylabel)
     dev.off()
     
     pdf(file=paste(n,"-30Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(rollapply(tseries, 30, mean, na.rm=T), ylab=ylabel)
     dev.off()
}
if(type == 2){
     ylabel <- expression(paste("Selenium Storage Change ( ",kg %.% day^-1,")"))
     pdf(file=paste(n,"-01Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(tseries, ylab=ylabel)
     abline(h=0, lty=2)
     dev.off()
     
     pdf(file=paste(n,"-07Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(rollapply(tseries, 7, mean, na.rm=T), ylab=ylabel)
     abline(h=0, lty=2)
     dev.off()
     
     pdf(file=paste(n,"-14Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(rollapply(tseries, 14, mean, na.rm=T), ylab=ylabel)
     abline(h=0, lty=2)
     dev.off()
     
     pdf(file=paste(n,"-30Day.pdf", sep=""), width=6, height=6, family="Times")
     par(mar=c(5.1,4.1,1.1,1.1))
     plot(rollapply(tseries, 30, mean, na.rm=T), ylab=ylabel)
     abline(h=0, lty=2)
     dev.off()
}