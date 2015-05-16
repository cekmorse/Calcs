# source("~/Projects/Calcs/R/USR/Pre-Loader.R")
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)

# x <- load("m massStoreChange.Rdata")
x <- load("m unknownMass.Rdata")
y <- get(x); rm(list=x)

z <- rep("X", dim(y)[[1]])
for(i in 1:dim(y)[[1]])
{
  tstep <- as.vector(as.matrix(y[i,]))
  if(is.nan(mean(tstep, na.rm=TRUE))){next}
  options(warn=-1)
  out <- try(fitData(tstep, fit=c("normal","logistic"), sample=1), silent=TRUE)
  if('try-error' %in% class(out)){next} else {df <- fitData(tstep, fit=c("normal","logistic"), sample=1)}
  options(warn=0)
  z[i] <- as.character(df[which.max(df[,5]),1])
  print(i)
}

vsize <- length(z) - length(z[which(z=="X")])
pctNorm <- signif(length(z[which(z=="norm")])/vsize*100,3)
pctLogis <- signif(length(z[which(z=="logis")])/vsize*100,3)

cat("norm = ",pctNorm,"\n","logis = ",pctLogis, sep="")
