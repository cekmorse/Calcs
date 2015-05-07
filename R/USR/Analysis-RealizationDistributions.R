# source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)

telliter <- 100

###  Change the source data file to get stats.  Results are not saved!
x <- load("m storageChange.Rdata")
load("date.Rdata")
y <- get(x); rm(list=x)
xMean <- rowMeans(y, na.rm=T)

a <- rep(NA, 2)
result <- rep(NA, dim(y)[[1]])

for(i in 1:dim(y)[[1]])
{
  z <- as.vector(as.matrix(y[i,]))
  z <- z[!is.na(z)]
  if (length(z) != 0)
  {
    ## NOTE: the other distribution types were removed because they do not support (-inf, +inf)
#     atry <- try(suppressWarnings(fitData(z, fit="gamma", sample=1)), silent=TRUE)
#     if(class(atry) != "try-error")
#     {
#       it <- suppressWarnings(fitData(z, fit="gamma", sample=1))
#       a[1] <- as.vector(it[,5])
#     }

#     atry <- try(suppressWarnings(fitData(z, fit="poisson", sample=1)), silent=TRUE)
#     if(class(atry) != "try-error")
#     {
#       it <- suppressWarnings(fitData(z, fit="poisson", sample=1))
#       a[2] <- as.vector(it[,5])
#     }
    
#     atry <- try(suppressWarnings(fitData(z, fit="weibull", sample=1)), silent=TRUE)
#     if(class(atry) != "try-error")
#     {
#       it <- suppressWarnings(fitData(z, fit="weibull", sample=1))
#       a[3] <- as.vector(it[,5])
#     }
    
#     atry <- try(suppressWarnings(fitData(z, fit="exponential", sample=1)), silent=TRUE)
#     if(class(atry) != "try-error")
#     {
#       it <- suppressWarnings(fitData(z, fit="exponential", sample=1))
#       a[4] <- as.vector(it[,5])
#     }
    
    atry <- try(suppressWarnings(fitData(z, fit="logistic", sample=1)), silent=TRUE)
    if(class(atry) != "try-error")
    {
      it <- suppressWarnings(fitData(z, fit="logistic", sample=1))
      a[1] <- as.vector(it[,1])
    }
    
    atry <- try(suppressWarnings(fitData(z, fit="normal", sample=1)), silent=TRUE)
    if(class(atry) != "try-error")
    {
      it <- suppressWarnings(fitData(z, fit="normal", sample=1))
      a[2] <- as.vector(it[,2])
    }
    
#     atry <- try(suppressWarnings(fitData(z, fit="lognormal", sample=1)), silent=TRUE)
#     if(class(atry) != "try-error")
#     {
#       it <- suppressWarnings(fitData(z, fit="lognormal", sample=1))
#       a[7] <- as.vector(it[,5])
#     }  
    result[i] <- which(a[] == max(a, na.rm=T))
  } else { result[i] <- NA}
  
  if( i %% telliter == 0 ) cat(paste("iteration", i, "complete\n"))
#   print(i)
}

d <- as.data.frame(table(result))
dSum <- sum(d$Freq)
d <- cbind(d, "pct"=signif(d$Freq/dSum*100,3))
dt <- rep("x", length(d$Freq))

for(i in 1:length(d$result))
{
  if(d$result[i] == 1){dt[i] <- "logistic"}
  if(d$result[i] == 2){dt[i] <- "normal"}
}

d <- cbind(d, "text"=dt)
d <- d[with(d, order(-pct)), ]
print(d)

plot(dates, result, type="l")

plot(result, xMean, xlab="", xaxt="n")
axis(1, at=c(1,2), labels=FALSE)
lablist=c("logistic", "normal")
text(c(1,2), par("usr")[3]-.05, labels=lablist, srt=90, pos=1, xpd=TRUE)
