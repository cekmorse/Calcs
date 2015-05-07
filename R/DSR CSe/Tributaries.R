###  SET WORKING DIRECTORY  ###
setwd("C:/Thesis/LARB/03 Thesis-Calcs/3 Estimate Concentration/Est DSR")

###  PROGRAM REQUIREMENTS  ###
require(MASS)
require(moments)
require(KernSmooth)
windowsFonts(W=windowsFont("Times New Roman"))

###  FUNCTIONS  ###
panel.pearson <- function(x, y, ...)
  {horizontal <- (par("usr")[1] + par("usr")[2]) / 2;
  vertical <- (par("usr")[3] + par("usr")[4]) / 2;
  text(horizontal, vertical, format(cor(x,y, use="complete.obs"), digits=2), cex=1)
  }

#-----------------------------------------------------------------------------------
###  BIGLAMCO  ###
ttl <- "BIGLAMCO"
db <- read.csv("Data Est DSR/lm data BIGLAMCO.csv")
db <- db[1:46,]

# plot scatterplot matrix of data
pdf(file=paste(ttl,"_Scatter_Matrix-Base.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
pair.lab <- c(expression(C["Se,D23"]), expression(EC["ARKJMRCO"]), expression(EC["ARKCOOKS"]), expression(Q["BIGLAMCO"]), expression(Q["ARKLAMCO"]), expression(Q["ARKCOOKS"]), expression(t["ARKJMRCO"]), expression(t["ARKCOOKS"]))
pairs(db[,c(2:9)], pch=20, upper.panel=panel.pearson, labels=pair.lab, cex=1)
dev.off()

# linear model solution process
#attach(db)
#lma <- lm(cse ~ ec.in + ec.out + q.x + q.in + q.out + t.in, data=db, na.action=na.exclude)
#summary(lma)
#nas <- lma$na.action[]
#lmb <- lm(cse ~ ec.in + ec.out + q.x + q.in + q.out + t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmb)
#step(lmb)

#lmc <- lm(cse ~ ec.in + q.x + q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmc)

#lmd <- lm(cse ~ (ec.in + ec.out + q.x + q.in + q.out + t.in)*q.x, data=db, na.action=na.exclude)
#summary(lmd)
#nas <- lma$na.action[]
#lme <- lm(cse ~ (ec.in + ec.out + q.x + q.in + q.out + t.in)*q.x, data=db[-nas,], na.action=na.exclude)
#summary(lme)
#step(lme)

#lmf <- lm(cse ~ q.x + q.in + q.out + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmf)

lm.xa <- lm(cse ~ q.x + q.in + q.out + q.x:q.in + q.x:q.out, data=db, na.action=na.exclude)

# Get predicted and measured values
tst <- lm.xa$fitted
nas <- lm.xa$na.action[]
meas <- db$cse[-nas]

# Get statistics
bb <- paste("\n   max             =", round(max(lm.xa$resid),2))
cc <- paste("\n   97.5th quantile =", round(quantile(lm.xa$resid, c(.975)),2))
dd <- paste("\n   mean            =", round(mean(lm.xa$resid),2))
ee <- paste("\n   2.5th quantile  =", round(quantile(lm.xa$resid, c(.025)),2))
ff <- paste("\n   min             =", round(min(lm.xa$resid),2))
gg <- paste("\n   standard dev    =", round(sd(lm.xa$resid),2))
hh <- paste("\n   skewness        =", round(skewness(lm.xa$resid),2))
ii <- paste("\n   kurtosis        =", round(kurtosis(lm.xa$resid),2))
stats <- paste(bb,cc,dd,ee,ff,gg,hh,ii)
jj <- paste("Analysis of Selenium Concentrations at",ttl)
res <- data.frame(lm.xa$resid)[,1]
write.table(res, file=paste(ttl,"_res.txt", sep=""))
 
# Print statistics to .txt file
zz <- textConnection("foo", open="w")
sink(zz)
cat(jj)
cat("\n\nSummary of Analysis\n")
summary(lm.xa)
cat("\n\nResidual Statistics")
cat(stats)
cat("\n\nResiduals\n")
res
sink()
close(zz)
write(foo, paste(ttl,"_lm-cse.txt",sep="")) 

# Plot predicted vs. measured
pdf(file=paste(ttl,"_Meas_vs_Pred.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(tst, meas, pch=20, main="", ylab=expression(paste("Measured ",C[Se]," (",mu,"g/L)")), xlab=expression(paste("Predicted ",C[Se]," (",mu,"g/L)")))
abline(a=0, b=1, lty=1)
dev.off()

# Plot residual analysis plots
pdf(file=paste(ttl,"_Resid_Analysis.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(4.1,4.1,1.5,2.1))
par(mfrow=c(2,2))
plot(lm.xa, pch=20)
dev.off()

# Plot histogram of residuals
pdf(file=paste(ttl,"_Histogram_of_Residuals.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
d <- bkde(lm.xa$resid)
hist(lm.xa$resid, freq=FALSE, main="", xlab=expression(paste("Residual ",C[Se]," (",mu,"g/L)")), col="grey90", ylim=c(0,0.08), xlim=c(-15,15))
lines(d,  lty=1, lwd=1)
dev.off()

#-----------------------------------------------------------------------------------
###  WILDHOCO  ###
ttl <- "WILDHOCO"
db <- read.csv("Data Est DSR/lm data WILDHOCO.csv")
db <- db[1:46,]

# plot scatterplot matrix of data
pdf(file=paste(ttl,"_Scatter_Matrix-Base.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
pair.lab <- c(expression(C["Se,D57"]), expression(EC["ARKJMRCO"]), expression(EC["ARKCOOKS"]), expression(Q["BIGLAMCO"]), expression(Q["ARKLAMCO"]), expression(Q["ARKCOOKS"]), expression(t["ARKJMRCO"]), expression(t["ARKCOOKS"]))
pairs(db[,c(2:9)], pch=20, upper.panel=panel.pearson, labels=pair.lab, cex=1)
dev.off()

# linear model solution process
attach(db)
#lma <- lm(cse ~ ec.in + ec.out + q.x + q.in + q.out + t.in, data=db, na.action=na.exclude)
#summary(lma)
#nas <- lma$na.action[]
#lmb <- lm(cse ~ ec.in + ec.out + q.x + q.in + q.out + t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmb)
#step(lmb)

#lmc <- lm(cse ~ t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmc)

#lmd <- lm(cse ~ (ec.in + ec.out + q.x + q.in + q.out + t.in)*q.x, data=db, na.action=na.exclude)
#summary(lmd)
#nas <- lma$na.action[]
#lme <- lm(cse ~ (ec.in + ec.out + q.x + q.in + q.out + t.in)*q.x, data=db[-nas,], na.action=na.exclude)
#summary(lme)
#step(lme)

#lmf <- lm(cse ~ ec.in + q.x + q.in + q.out + t.in + ec.in:q.x + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmf)

#lmg <- lm(cse ~ q.x + q.in + q.out + t.in + ec.in:q.x + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmg)

#lmh <- lm(cse ~ q.x + q.out + t.in + ec.in:q.x + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmh)

#lmi <- lm(cse ~ (ec.in + ec.out + q.x + q.in + q.out + t.in)*(ec.in + ec.out + q.x + q.in + q.out + t.in), data=db[-nas,], na.action=na.exclude)
#summary(lmi)
#step(lmi)

#lmj <- lm(cse ~ ec.in + ec.out + q.x + q.in + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + ec.out:q.out + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + q.x:t.in + q.in:q.out + 
#    q.in:t.in + q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmj)

#lmk <- lm(cse ~ ec.in + ec.out + q.x + q.in + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + q.x:t.in + q.in:q.out + 
#    q.in:t.in + q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmk)
# + ec.out:q.out

#lml <- lm(cse ~ ec.in + ec.out + q.in + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + q.x:t.in + q.in:q.out + 
#    q.in:t.in + q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lml)
# + q.x

#lmm <- lm(cse ~ ec.in + ec.out + q.in + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + q.in:q.out + 
#    q.in:t.in + q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmm)
# + q.x:t.in

#lmn <- lm(cse ~ ec.in + ec.out + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + q.in:q.out + 
#    q.in:t.in + q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmn)
# + q.in

#lmo <- lm(cse ~ ec.in + ec.out + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + q.in:q.out + 
#    q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmo)
#+ q.in:t.in

#lmp <- lm(cse ~ ec.in + ec.out + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:q.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + 
#    q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmp)
# + q.in:q.out

#lmq <- lm(cse ~ ec.in + ec.out + q.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + 
#    q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmq)
# + ec.in:q.out

#lmr <- lm(cse ~ ec.in + ec.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out + 
#    q.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmr)
# + q.out

################ Best
#lms <- lm(cse ~ ec.in + ec.out + t.in + 
#    ec.in:ec.out + ec.in:q.x + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lms)
# + q.out:t.in
################# Best

#lmt <- lm(cse ~ ec.in + ec.out + t.in + 
#    ec.in:ec.out + ec.in:t.in + 
#    ec.out:t.in + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmt)
# + ec.in:q.x

#lmu <- lm(cse ~ ec.in + ec.out + t.in + ec.in:ec.out + 
#    ec.out:t.in + q.x:q.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmu)
# + ec.in:t.in

#lmv <- lm(cse ~ ec.in + ec.out + t.in + ec.in:ec.out + ec.out:t.in + q.x:q.out, data=db[-nas,], na.action=na.exclude)
#summary(lmv)
# + q.x:q.in

#lmw <- lm(cse ~ ec.in + ec.out + t.in + ec.in:ec.out + ec.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmw)
# + q.x:q.out

#lmx <- lm(cse ~ ec.out + t.in + ec.in:ec.out + ec.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmx)
#ec.in + 

#lmy <- lm(cse ~ ec.out + t.in + ec.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmy)
#  + ec.in:ec.out

#lmz <- lm(cse ~ t.in + ec.out:t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmz)
#ec.out + 

#lmaa <- lm(cse ~ t.in, data=db[-nas,], na.action=na.exclude)
#summary(lmaa)
# + ec.out:t.in

lm.xa <- lm(cse ~ ec.in + ec.out + t.in + 
    ec.in:ec.out + ec.in:q.x + ec.in:t.in + 
    ec.out:t.in + q.x:q.in + q.x:q.out, data=db, na.action=na.exclude)

# Get predicted and measured values
tst <- lm.xa$fitted
nas <- lm.xa$na.action[]
meas <- db$cse[-nas]

# Get statistics
bb <- paste("\n   max             =", round(max(lm.xa$resid),2))
cc <- paste("\n   97.5th quantile =", round(quantile(lm.xa$resid, c(.975)),2))
dd <- paste("\n   mean            =", round(mean(lm.xa$resid),2))
ee <- paste("\n   2.5th quantile  =", round(quantile(lm.xa$resid, c(.025)),2))
ff <- paste("\n   min             =", round(min(lm.xa$resid),2))
gg <- paste("\n   standard dev    =", round(sd(lm.xa$resid),2))
hh <- paste("\n   skewness        =", round(skewness(lm.xa$resid),2))
ii <- paste("\n   kurtosis        =", round(kurtosis(lm.xa$resid),2))
stats <- paste(bb,cc,dd,ee,ff,gg,hh,ii)
jj <- paste("Analysis of Selenium Concentrations at",ttl)
res <- data.frame(lm.xa$resid)[,1]
write.table(res, file=paste(ttl,"_res.txt", sep=""))
 
# Print statistics to .txt file
zz <- textConnection("foo", open="w")
sink(zz)
cat(jj)
cat("\n\nSummary of Analysis\n")
summary(lm.xa)
cat("\n\nResidual Statistics")
cat(stats)
cat("\n\nResiduals\n")
res
sink()
close(zz)
write(foo, paste(ttl,"_lm-cse.txt",sep="")) 

# Plot predicted vs. measured
pdf(file=paste(ttl,"_Meas_vs_Pred.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(tst, meas, pch=20, main="", ylab=expression(paste("Measured ",C[Se]," (",mu,"g/L)")), xlab=expression(paste("Predicted ",C[Se]," (",mu,"g/L)")))
abline(a=0, b=1, lty=1)
dev.off()

# Plot residual analysis plots
pdf(file=paste(ttl,"_Resid_Analysis.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(4.1,4.1,1.5,2.1))
par(mfrow=c(2,2))
plot(lm.xa, pch=20)
dev.off()

# Plot histogram of residuals
pdf(file=paste(ttl,"_Histogram_of_Residuals.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
d <- bkde(lm.xa$resid)
hist(lm.xa$resid, freq=FALSE, main="", xlab=expression(paste("Residual ",C[Se]," (",mu,"g/L)")), col="grey90", ylim=c(0,0.25), xlim=c(-10,10))
lines(d,  lty=1, lwd=1)
dev.off()
detach(db)

rm(list=ls())