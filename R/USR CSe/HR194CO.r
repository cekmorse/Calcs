source("~/Projects/Thesis/Thesis-Calcs/R/USR CSe/Pre-Loader.R")

###  READ AND EDIT DATA  ###
loadA <- "aUHRC.Rdata"
loc <- "HRC194CO"
lod <- "bUHRC"

load(paste(modelsFile,loadA, sep=""))

resid <- aUHRC$residuals

z.file <- paste(resultsFile, loc, "_Residual Distribution Fitting.txt", sep="")
xx <- list(a.logis = fitdist(resid, distr="logis", method="mle"),
               a.norm = fitdist(resid, distr="norm", method="mle"))

## none of the GOF tests pass.  Get code from CANSWKCO.r

zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Test Statistics for Scaled Residuals from ",loc,"\n\n", sep=""))
cat("\n\nInsufficent data to perform tests (n<5)")
sink()
close(zz)
write(foo, z.file, append=FALSE)

# Open the text file to choose.  Close the file when done.

a <- fitdist(resid, distr="norm", method="mle")
bUHRC <- a
save(bUHRC, file=paste(modelsFile,lod,".Rdata", sep=""))

###  For UNSCALED data/distribution  ###
zz <- textConnection("foo", open="w")
sink(zz)
cat("\n\nChosen distribution  -  Normal\n")
cat("\nDistribution data is not scaled\n\n")
summary(a)
sink()
close(zz)
write(foo, z.file, append=TRUE)

## Plots
ylimit <- c(0, ceiling(max(hist(resid, plot=FALSE)$density*10, density(resid)$y*10)))/10
xlimit <- c(floor(min(hist(resid, plot=FALSE)$breaks, density(resid)$x)), ceiling(max(hist(resid, plot=FALSE)$breaks, density(resid)$x)))
xlabel <- expression(HRC194Co~C[Se]~Residuals~(mu*g~L^{-1}))
pdf(file=paste(loc, "_Residual_vs_Random_Plot.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(resid, freq=FALSE, ylim=ylimit, xlim=xlimit, main="", xlab=xlabel)
lines(density(rnorm(10000, mean=mean(resid), sd=sd(resid))), col="red", lwd=1)
lines(density(resid), lwd=1)
dev.off()

pdf(file=paste(loc, "_Residual_Distribution_Plot.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
plot(a, pch=20)
dev.off()

# pdf(file=paste(loc, "_Residual_Distribution_CDF_comparison.pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,2.1,1.1))
cdfcomp(xx, main="", xlab="Residuals", horizontals=FALSE, legendtext=c("Logistic", "Normal"))
dev.off()

rm(list=ls())
