##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("m massStoreChange.Rdata")
load("m massFlux.Rdata")
load("date.Rdata")

# test set
storageChange <- abs(massStoreChange)
flowChange <- abs(massFlux)

cTotal <- storageChange + flowChange
cStorage <- storageChange / cTotal * 100
cFlow <- flowChange / cTotal * 100

sStorage <- data.frame(P.025=apply(cStorage, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        Mean=rowMeans(cStorage, na.rm=TRUE),
                        P.975=apply(cStorage, 1, quantile, probs=c(0.975), na.rm=TRUE))
sFlow <- data.frame(P.025=apply(cFlow, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        Mean=rowMeans(cFlow, na.rm=TRUE),
                        P.975=apply(cFlow, 1, quantile, probs=c(0.975), na.rm=TRUE))

ssStorage <- signif(colMeans(sStorage, na.rm=TRUE),3)
ssFlow <- signif(colMeans(sFlow, na.rm=TRUE),3)
stats <- t(data.frame(Store=ssStorage, Flow=ssFlow))
setwd(resultsFile)
write.csv(stats, "m contrib mass.csv")


setwd("~/Projects/Text/Tables/")
zz <- textConnection("foo", open="w")
sink(zz)
cat("\\begin{tabular}{cccc} \n",
    "\\toprule \n",
    "Model Portion  & 2.5\\% & Mean & 97.5\\% \\\\ \n",
    "\\toprule \n",
    "$ \\displaystyle \\frac{\\Delta S_M}{\\Delta t} $ & ", ssStorage[[1]],"  & ", ssStorage[[2]],"	& ", ssStorage[[3]]," \\\\ \n",
    "\\\\ \n",
    "$ \\displaystyle \\sum L_{Surface} $	& ", ssFlow[[1]],"  & ", ssFlow[[2]],"	& ", ssFlow[[3]]," \\\\ \n",
    "\\bottomrule \n",
    "\\end{tabular}", sep="")
sink()
close(zz)
write(foo, "DSR M Contrib.txt", append=FALSE)

polyStore <- polylims(dates, sStorage$P.025, sStorage$P.975)
polyFlow <- polylims(dates, sFlow$P.025, sFlow$P.975)
col1 <- rgb(1,0,0,.5)
col2 <- rgb(0,1,0,.5)
col3 <- rgb(0,0,1,.5)

setwd(plotFile)
pdf(file="M Mass Contrib 1.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sFlow$Mean, col=col3, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
legend("topright", legend=c("Surface Flow"), col=c(col3), lty=c(1))
dev.off()

pdf(file="M Mass Contrib 2.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sStorage$Mean, col=col2, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
legend("topright", legend=c("Storage Change"), col=c(col2), lty=c(1))
dev.off()

pdf(file="M Mass Contrib 3.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, sStorage$Mean, col=col2, type="l", main="", ylim=c(0,100),
     ylab="Percent Contribution (%)", xlab="Date")
lines(dates, sFlow$Mean, col=col3)
dev.off()

rm(list=ls())
