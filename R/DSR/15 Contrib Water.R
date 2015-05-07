##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("m storageChange.Rdata")
load("m flowChange.Rdata")
load("m atmChange.Rdata")
load("date.Rdata")

# test set
storageChange <- abs(storageChange)
flowChange <- abs(flowChange)
atmChange <- abs(atmChange)

cTotal <- storageChange + flowChange + atmChange
cStorage <- storageChange / cTotal * 100
cFlow <- flowChange / cTotal * 100
cAtm <- atmChange / cTotal * 100

sStorage <- data.frame(P.025=apply(cStorage, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        Mean=rowMeans(cStorage, na.rm=TRUE),
                        P.975=apply(cStorage, 1, quantile, probs=c(0.975), na.rm=TRUE))
sFlow <- data.frame(P.025=apply(cFlow, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        Mean=rowMeans(cFlow, na.rm=TRUE),
                        P.975=apply(cFlow, 1, quantile, probs=c(0.975), na.rm=TRUE))
sAtm <- data.frame(P.025=apply(cAtm, 1, quantile, probs=c(0.025), na.rm=TRUE),
                       Mean=rowMeans(cAtm, na.rm=TRUE),
                       P.975=apply(cAtm, 1, quantile, probs=c(0.975), na.rm=TRUE))

ssStorage <- signif(colMeans(sStorage, na.rm=TRUE),3)
ssFlow <- signif(colMeans(sFlow, na.rm=TRUE),3)
ssAtm <- signif(colMeans(sAtm, na.rm=TRUE),3)
stats <- t(data.frame(Store=ssStorage, Flow=ssFlow, Atm=ssAtm))
setwd(resultsFile)
write.csv(stats, "m contrib water.csv")

setwd("~/Projects/Thesis/Thesis-Text/Tables/")
zz <- textConnection("foo", open="w")
sink(zz)
cat("\\begin{tabular}{cccc} \n",
    "\\toprule \n",
    "Model Portion  & 2.5\\% & Mean & 97.5\\% \\\\ \n",
    "\\toprule \n",
    "$ \\displaystyle \\frac{\\Delta S}{\\Delta t} $ & ", ssStorage[[1]],"	& ", ssStorage[[2]],"	& ", ssStorage[[3]]," \\\\ \n",
    "\\\\ \n",
    "$ \\displaystyle \\sum Q_{Total} $	& ", ssFlow[[1]],"  & ", ssFlow[[2]],"	& ", ssFlow[[3]]," \\\\ \n",
    "\\\\ \n",
    "$ \\displaystyle Q_{Atm} $  & ", ssAtm[[1]],"  & ", ssAtm[[2]],"	& ", ssAtm[[3]]," \\\\ \n",
    "\\bottomrule \n",
    "\\end{tabular}", sep="")
sink()
close(zz)
write(foo, "DSR W Contrib.txt", append=FALSE)

polyStore <- polylims(dates, sStorage$P.025, sStorage$P.975)
polyFlow <- polylims(dates, sFlow$P.025, sFlow$P.975)
polyAtm <- polylims(dates, sAtm$P.025, sAtm$P.975)
col1 <- rgb(1,0,0,.5) #red
col2 <- rgb(0,1,0,.5) #green
col3 <- rgb(0,0,1,.5) #blue

setwd(plotFile)
pdf(file="M Water Contrib 1.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sFlow$Mean, col=col3, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
legend("topright", legend=c("Surface Flow"), col=c(col3), lty=c(1))
dev.off()

pdf(file="M Water Contrib 2.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sAtm$Mean, col=col1, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
legend("topright", legend=c("Precip. & Evap."), col=c(col1), lty=c(1))
dev.off()

pdf(file="M Water Contrib 3.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sStorage$Mean, col=col2, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
legend("topright", legend=c("Storage Change"), col=c(col2), lty=c(1))
dev.off()

pdf(file="M Water Contrib 4.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sStorage$Mean, col=col2, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
lines(dates, sFlow$Mean, col=col3)
lines(dates, sAtm$Mean, col=col1)
dev.off()

rm(list=ls())