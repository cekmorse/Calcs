source("~/Projects/Calcs/R/DSR CSe/Pre-Loader.R")

###  READ AND EDIT DATA  ###
loadA <- "aDBIG.Rdata"
loc <- "BIGLAMCO"
lod <- "bDBIG"

######  BIGLAMCO     #####################################
load(paste(modelsFile,loadA, sep=""))

resid <- aDBIG$residuals

z.file <- paste(resultsFile, loc, "_Residual Distribution Fitting.txt", sep="")
xx <- list(a.logis = fitdist(resid, distr="logis", method="mle"),
           a.norm = fitdist(resid, distr="norm", method="mle"))

gof <-gofstat(xx)
wins <- data.frame(matrix(0, nrow=1, ncol=length(xx)))
for(i in 1:length(xx)){
  if(gof$ks[[i]] == min(gof$ks, na.rm=T)){wins[i] <- wins[i] + 1}
  if(gof$cvm[[i]] == min(gof$cvm, na.rm=T)){wins[i] <- wins[i] + 1}
  if(gof$ad[[i]] == min(gof$ad, na.rm=T)){wins[i] <- wins[i] + 1}
}
colnames(wins) <- names(gof$ks)
rownames(wins) <- ""

zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Test Statistics for Scaled Residuals from ",loc,"\n\n", sep=""))
gof
cat("\n\n")
rbind("Kolmogorov-Smirnov Test"=gof$kstest,
      "Cramer-von Mises Test"=gof$cvmtest,
      "Anderson-Darling Test"=gof$adtest)
cat("\n\n     'Wins'\n\n")
wins
sink()
close(zz)
write(foo, z.file, append=FALSE)

# Open the text file to choose.  Close the file when done.

a <- fitdist(resid, distr="norm", method="mle")
bDBIG <- a
save(bDBIG, file=paste(modelsFile,lod,".Rdata", sep=""))

###  For UNSCALED data/distribution  ###
zz <- textConnection("foo", open="w")
sink(zz)
cat("\n\nChosen distribution  -  Logistic\n")
cat("\nDistribution data is not scaled\n\n")
summary(a)
cat("\nTest Statistics for Unscaled Residuals\n\n")
gofstat(a)
sink()
close(zz)
write(foo, z.file, append=TRUE)

## Plots
setwd(plotFile)
ylimit <- c(0, max(hist(resid, plot=FALSE)$density, density(resid)$y)*1.1)
xlimit <- c(floor(min(hist(resid, plot=FALSE)$breaks, density(resid)$x)*1.1), ceiling(max(hist(resid, plot=FALSE)$breaks, density(resid)$x)*1.1))
xlabel <- expression(CANSWKCO~C[Se]~Residuals~(mu*g~L^{-1}))
fileName <- paste(loc, "_Residual_vs_Random_Plot.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(resid, freq=FALSE, ylim=ylimit, xlim=xlimit, main="", xlab=xlabel)
lines(density(rlogis(10000, location=a$e[[1]], scale=a$e[[2]])), col="red", lwd=1)
lines(density(resid), lwd=1)
dev.off()

fileName <- paste(loc, "_Residual_Distribution_Plot.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
plot(a, pch=20)
dev.off()

fileName <- paste(loc, "_Residual_Distribution_CDF_comparison.pdf", sep="")
pdf(file=fileName, width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
cdfcomp(xx, main="", xlab="Residuals", horizontals=FALSE, legendtext=c("Logistic", "Normal"))
dev.off()

rm(list=ls())
