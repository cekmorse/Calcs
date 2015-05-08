##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

runS <- function(){
  p97 <- apply(x, 1, quantile, probs=0.975, na.rm=TRUE)
  p50 <- rowMeans(x, na.rm=TRUE)
  p03 <- apply(x, 1, quantile, probs=0.025, na.rm=TRUE)
  
  fileName <- paste(plotFile,"Q ",locate,".pdf", sep="")
  
  polys <- polylims(dates, p97, p03)
  pdf(file=fileName, width=6, height=6, family="Times")
  par(mar=c(5.1,4.4,1.1,1.1)) 
  plot(dates, p50, type="n", ylim=c(0, flowMax), xlab="Time", ylab=ylabel)
  for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
  lines(dates, p50, lwd=1, col="black")
  abline(h=0, lty=2)
  dev.off()
}

runD <- function(){
  fileName <- paste("Q ",locate,".pdf", sep="")
  
  pdf(file=fileName, width=6, height=6, family="Times")
  par(mar=c(5.1,4.4,1.1,1.1)) 
  plot(dates, x, type="l", ylim=c(0, flowMax), xlab="Time", ylab=ylabel)
  abline(h=0, lty=2)
  dev.off()
}

ylabel <- expression("Water Flow Rate"~~(m^3 %.% s^-1))

setwd(modelsFile)
load("date.Rdata")

locate <- "BIG"
flowMax <- 2.5
setwd(modelsFile)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plotFile)
runS()
setwd(models.D)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plot.D)
runD()

locate <- "BUF"
flowMax <- 5
setwd(modelsFile)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plotFile)
runS()
setwd(models.D)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plot.D)
runD()

locate <- "FRO"
flowMax <- 1.2
setwd(modelsFile)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plotFile)
runS()
setwd(models.D)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plot.D)
runD()

locate <- "WIL"
flowMax <- 2
setwd(modelsFile)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plotFile)
runS()
setwd(models.D)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plot.D)
runD()

locate <- "in"
flowMax <- 30
setwd(modelsFile)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plotFile)
runS()
setwd(models.D)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plot.D)
runD()

locate <- "out"
flowMax <- 25
setwd(modelsFile)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plotFile)
runS()
setwd(models.D)
y <- load(paste("q",locate,".Rdata", sep="")); x <- get(y); rm(list=y)
setwd(plot.D)
runD()

rm(list=ls())
