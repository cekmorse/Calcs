##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/ConcModelPlots-DSR.R")
}

run2 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/ConcModelPlots2.R")
}

setwd(dataFile)
seData <- read.csv("SeEstData.csv")

setwd(modelsFile)
load("date.Rdata")

setwd(plotFile)
locate <- "D101C"
run1()

locate <- "D106C"
run1()

locate <- "DDIV"
run1()

locate <- "BIG"
run1()

locate <- "WIL"
run1()

setwd(dataFile)

measured <- read.csv("DSR ARK R.csv")
measured <- data.frame(point=measured$point, cse=measured$cse)
measured <- droplevels(measured)

tribData <- read.csv("BIGLAMCO.csv")
meas2 <- data.frame(point="D23", cse=tribData$cse)
measured <- rbind(measured, meas2)

tribData <- read.csv("WILDHOCO.csv")
meas2 <- data.frame(point="D57", cse=tribData$cse)
measured <- rbind(measured, meas2)

ptLabels <- c("D101C","D102C","D23","D103C","D104C","D105C","D57","D106C")

measured$point <- factor(measured$point, ptLabels)
setwd(plotFile)

bx <- boxplot(measured$cse ~ measured$point, plot=F)

ylabel <- expression(Measured~Selenium~Concentration~(C[Se])~(mu*g~L^{-1}))
xlabel <- "Sample Points"
c1 <- rgb(1,0.75, 0.5, 0.5)
c2 <- rgb(0.650, 0.930, 1.000, 0.5)
boxColors <- c(NA,NA,c2,NA,NA,NA,c2,NA)

pdf(file="c BOX Measure CSe.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
boxplot(measured$cse ~ measured$point, outline=FALSE, boxwex=0.5, ylim=c(0,40), xaxt="n", 
        ylab=ylabel, col=boxColors)
axis(side=1, at=c(1:8), labels=FALSE)
text(seq(1.2, 8.2,1), par("usr")[3]-.9, labels=bx$names, srt=45, pos=2, xpd=TRUE, cex=1)
text(0.5, -0.1, "n =")
text(seq(1, 8,1), par("usr")[3], labels=bx$n, pos=3, xpd=TRUE, cex=1)
mtext(xlabel, side=1, line=3.5, outer=FALSE)
legend("topright", legend=c("River Main Stem","Tributaries"), fill=c(NA,c2))
dev.off()

setwd(modelsFile)
load("c D101C.Rdata")
lam <- rowMeans(est, na.rm=T)
lam9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
lam2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=lam2, Mean=lam, P.975=lam9)
setwd(resultsFile)
save(stats, file="c stats D101C.Rdata")

setwd(modelsFile)
load("c BIG.Rdata")
big <- rowMeans(est, na.rm=T)
big9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
big2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=big2, Mean=big, P.975=big9)
setwd(resultsFile)
save(stats, file="c stats BIG.Rdata")

setwd(modelsFile)
load("c BUF.Rdata")
buf <- rowMeans(est, na.rm=T)
buf9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
buf2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=buf2, Mean=buf, P.975=buf9)
setwd(resultsFile)
save(stats, file="c stats BUF.Rdata")

setwd(modelsFile)
load("c WIL.Rdata")
wil <- rowMeans(est, na.rm=T)
wil9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
wil2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=wil2, Mean=wil, P.975=wil9)
setwd(resultsFile)
save(stats, file="c stats WIL.Rdata")

setwd(modelsFile)
load("c D106C.Rdata")
coo <- rowMeans(est, na.rm=T)
coo9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
coo2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=coo2, Mean=coo, P.975=coo9)
setwd(resultsFile)
save(stats, file="c stats D106C.Rdata")

rm(est)

calcm <- data.frame(ARKLAMCOCO=lam, BIGLAMCO=big, BUFDITCO=buf, WILDHOCO=wil, ARKCOOKS=coo)
calc9 <- data.frame(ARKLAMCOCO=lam9, BIGLAMCO=big9, BUFDITCO=buf9, WILDHOCO=wil9, ARKCOOKS=coo9)
calc2 <- data.frame(ARKLAMCOCO=lam2, BIGLAMCO=big2, BUFDITCO=buf2, WILDHOCO=wil2, ARKCOOKS=coo2)

rm(lam, big, buf, wil, coo)
rm(lam9, big9, buf9, wil9, coo9)
rm(lam2, big2, buf2, wil2, coo2)

nVars <- dim(calcm)[[1]]

ylabel <- expression(Estimated~Selenium~Concentration~(C[Se])~(mu*g~L^{-1}))
xlabel <- "Location"
nlab <- bquote(paste("n = ", .(nVars)))
boxColors <- c(c1,c2,c1,c2,c2)

setwd(plotFile)
pdf(file="c BOX Estimated CSe.pdf", width=6, height=6, family="Times")
par(mar=c(6.1,4.1,1.1,1.1))
boxplot(calcm, boxwex=0.5, range=1, outline=FALSE, ylimit=c(0, 30), xaxt="n", 
        ylab=ylabel, col=boxColors)
axis(side=1, at=c(1:dim(calcm)[[2]]), labels=FALSE)
text(seq(1.2, length(calcm[1,])+0.2,1), par("usr")[3]-.9, labels=colnames(calcm), srt=45, pos=2, xpd=TRUE, cex=0.8)
text(1, 0, nlab)
mtext(xlabel, side=1, line=4)
legend("topright", legend=c("Gain to River Reach","Loss from River Reach"), fill=c(c2, c1))
dev.off()

setwd(models.D)

load("c D101C.Rdata")
lam <- est
load("c BIG.Rdata")
big <- est
load("c BUF.Rdata")
buf <- est
load("c WIL.Rdata")
wil <- est
load("c D106C.Rdata")
coo <- est
rm(est)
setwd(plotFile)

Dcalcm <- data.frame(ARKLAMCOCO=lam, BIGLAMCO=big, BUFDITCO=buf, WILDHOCO=wil, ARKCOOKS=coo)
rm(lam, big, buf, wil, coo)

for(n in 1:5){
  if(n == 1){
    locate <- "D101C"
    xlimit <- c(0,20)
    ylimit <- c(0,0.25)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 2){
    locate <- "BIG"
    xlimit <- c(0,40)
    ylimit <- c(0,0.15)
    ylimit2 <- c(0,50)
    legLoc <- "topleft"
    run2()
  }
  if(n == 3){
    locate <- "BUF"
    xlimit <- c(0,15)
    ylimit <- c(0,0.4)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 4){
    locate <- "WIL"
    xlimit <- c(0,70)
    ylimit <- c(0,0.25)
    ylimit2 <- c(0,70)
    legLoc <- "topright"
    run2()
  }
  if(n == 5){
    locate <- "D106C"
    xlimit <- c(0,20)
    ylimit <- c(0,0.5)
    ylimit2 <- c(0,25)
    legLoc <- "topleft"
    run2()
  }
}

rm(list=ls())
