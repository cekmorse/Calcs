##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/ConcModelPlots-USR.R")
}

run2 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/ConcModelPlots2.R")
}


setwd(dataFile)
seData <- read.csv("SeEstData.csv")
setwd(modelsFile)
load("date.Rdata")

locate <- "U163"
run1()

locate <- "U201"
run1()

locate <- "U167"
run1()

locate <- "UDIV"
run1()

locate <- "TIM"
run1()

locate <- "CAN"
run1()

locate <- "HRC"
run1()

locate <- "WTP"
run1()

setwd(dataFile)

measured <- read.csv("ARK.csv")
measured <- data.frame(point=measured$point, cse=measured$cse)
measured <- measured[which(measured$point != "U163.5"),]
measured <- droplevels(measured)

tempMeas <- read.csv("TIMSWICO.csv") 
tim <- data.frame(point="U60",cse=tempMeas$cse)
tempMeas <- read.csv("CANSWKCO.csv") 
can <- data.frame(point="U74",cse=tempMeas$cse)
tempMeas <- read.csv("HRC194CO.csv") 
hrc <- data.frame(point="U207",cse=tempMeas$cse)

measured <- rbind(measured, tim, can, hrc)

ptLabels <-c("U163","U161","U164","U167","U141","U12","U60","U127","U74","U95","U162","U209","U207","U201")

measured$point <- factor(measured$point, ptLabels)

bx <- boxplot(measured$cse ~ measured$point, plot=F)

ylabel <- expression(Measured~Selenium~Concentration~(C[Se])~(mu*g~L^{-1}))
xlabel <- "Sample Location"
c1 <- rgb(1,0.75, 0.5, 0.5)
c2 <- rgb(0.650, 0.930, 1.000, 0.5)
boxColors <- c(NA,NA,NA,NA,NA,NA,c2,NA,c2,NA,NA,NA,c2,NA)

setwd(plotFile)
pdf(file="c BOX Measure CSe.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
boxplot(measured$cse ~ measured$point, boxwex=0.5, ylim=c(0, 25), xaxt="n", 
        ylab=ylabel, col=boxColors, outline=FALSE)
axis(side=1, at=c(1:14), labels=FALSE)
text(seq(1.2, 14.2,1), par("usr")[3]-.9, labels=bx$names, srt=45, pos=2, xpd=TRUE, cex=1)
text(0.5, -0.1, "n =")
text(seq(1, 14,1), par("usr")[3], labels=bx$n, pos=3, xpd=TRUE, cex=1)
mtext(xlabel, side=1, line=3.5, outer=FALSE)
legend("topright", legend=c("River Main Stem","Tributaries"), fill=c(NA,c2))
dev.off()

setwd(modelsFile)
load("date.Rdata")
load("c U163.Rdata")
cat <- rowMeans(est, na.rm=T)
cat9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
cat2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=cat2, Mean=cat, P.975=cat9)
save(stats, file="c stats U163.Rdata")

load("c HOL.Rdata")
hol <- rowMeans(est, na.rm=T)
hol9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
hol2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=hol2, Mean=hol, P.975=hol9)
save(stats, file="c stats HOL.Rdata")

load("c RFD.Rdata")
rfd <- rowMeans(est, na.rm=T)
rfd9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
rfd2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=rfd2, Mean=rfd, P.975=rfd9)
save(stats, file="c stats RFD.Rdata")

load("c FLS.Rdata")
fls <- rowMeans(est, na.rm=T)
fls9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
fls2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=fls2, Mean=fls, P.975=fls9)
save(stats, file="c stats FLS.Rdata")

load("c TIM.Rdata")
tim <- rowMeans(est, na.rm=T)
tim9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
tim2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=tim2, Mean=tim, P.975=tim9)
save(stats, file="c stats TIM.Rdata")

load("c FLY.Rdata")
fly <- rowMeans(est, na.rm=T)
fly9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
fly2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=fly2, Mean=fly, P.975=fly9)
save(stats, file="c stats FLY.Rdata")

load("c CAN.Rdata")
can <- rowMeans(est, na.rm=T)
can9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
can2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=can2, Mean=can, P.975=can9)
save(stats, file="c stats CAN.Rdata")

load("c CON.Rdata")
con <- rowMeans(est, na.rm=T)
con9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
con2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=con2, Mean=con, P.975=con9)
save(stats, file="c stats CON.Rdata")

load("c HRC.Rdata")
hrc <- rowMeans(est, na.rm=T)
hrc9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
hrc2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=hrc2, Mean=hrc, P.975=hrc9)
save(stats, file="c stats HRC.Rdata")

load("c U201.Rdata")
las <- rowMeans(est, na.rm=T)
las9 <- apply(est, 1, quantile, probs=0.975, na.rm=TRUE)
las2 <- apply(est, 1, quantile, probs=0.025, na.rm=TRUE)
stats <- data.frame("Date"=dates, P.025=las2, Mean=las, P.975=las9)
save(stats, file="c stats U201.Rdata")

rm(est)

calcm <- data.frame(ARKCATCO=cat, HOLCANCO=hol, RFDCANCO=rfd, FLSCANCO=fls, TIMSWICO=tim, 
                    FLYCANCO=fly, CANSWKCO=can, CONDITCO=con, HRC194CO=hrc, ARKLASCO=las)

calc9 <- data.frame(ARKCATCO=cat9, HOLCANCO=hol9, RFDCANCO=rfd9, FLSCANCO=fls9, TIMSWICO=tim9, 
                    FLYCANCO=fly9, CANSWKCO=can9, CONDITCO=con9, HRC194CO=hrc9, ARKLASCO=las9)

calc2 <- data.frame(ARKCATCO=cat2, HOLCANCO=hol2, RFDCANCO=rfd2, FLSCANCO=fls2, TIMSWICO=tim2, 
                    FLYCANCO=fly2, CANSWKCO=can2, CONDITCO=con2, HRC194CO=hrc2, ARKLASCO=las2)

rm(cat,hol,rfd,fls,tim,fly,can,con,hrc,las)
rm(cat9,hol9,rfd9,fls9,tim9,fly9,can9,con9,hrc9,las9)
rm(cat2,hol2,rfd2,fls2,tim2,fly2,can2,con2,hrc2,las2)

nVars <- dim(calcm)[[1]]

ylabel <- expression(Estimated~Selenium~Concentration~(C[Se])~(mu*g~L^{-1}))
xlabel <- "Location"
boxColors <- c(c2,c1,c1,c1,c2,c1,c2,c1,c2,c1)
nlab <- bquote(paste("n = ", .(nVars)))

setwd(plotFile)
pdf(file="c BOX Estimated CSe.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
boxplot(calcm, boxwex=0.5, range=1, outline=FALSE, ylimit=c(0, 25), xaxt="n", ylab=ylabel, col=boxColors)
axis(side=1, at=c(1:length(calcm[1,])), labels=FALSE)
text(seq(1.2, length(calcm[1,])+0.2,1), par("usr")[3]-.9, labels=colnames(calcm), srt=45, pos=2, xpd=TRUE, cex=0.8)
text(1, 0, nlab)
mtext(xlabel, side=1, line=4)
legend("topright", legend=c("Gain to River Reach","Loss from River Reach"), fill=c(c2, c1))
dev.off()

setwd(models.D)
load("c U163.Rdata")
cat <- est
load("c HOL.Rdata")
hol <- est
load("c RFD.Rdata")
rfd <- est
load("c FLS.Rdata")
fls <- est
load("c TIM.Rdata")
tim <- est
load("c FLY.Rdata")
fly <- est
load("c CAN.Rdata")
can <- est
load("c CON.Rdata")
con <- est
load("c HRC.Rdata")
hrc <- est
load("c U201.Rdata")
las <- est
rm(est)

setwd(modelsFile)

Dcalcm <- data.frame(ARKCATCO=cat, HOLCANCO=hol, RFDCANCO=rfd, FLSCANCO=fls, TIMSWICO=tim, 
                     FLYCANCO=fly, CANSWKCO=can, CONDITCO=con, HRC194CO=hrc, ARKLASCO=las)
rm(cat,hol,rfd,fls,tim,fly,can,con,hrc,las)

for(n in 1:10){   # time series plots
  if(n == 1){
    locate <- "U163"
    xlimit <- c(0,20)
    ylimit <- c(0,0.15)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 2){
    locate <- "HOL"
    xlimit <- c(0,20)
    ylimit <- c(0,0.2)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 3){
    locate <- "RFD"
    xlimit <- c(0,20)
    ylimit <- c(0,0.15)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 4){
    locate <- "FLS"
    xlimit <- c(0,20)
    ylimit <- c(0,0.2)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 5){
    locate <- "TIM"
    xlimit <- c(0,30)
    ylimit <- c(0,0.15)
    ylimit2 <- c(0,30)
    legLoc <- "topleft"
    run2()
  }
  if(n == 6){
    locate <- "FLY"
    xlimit <- c(0,20)
    ylimit <- c(0,0.2)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 7){
    locate <- "CAN"
    xlimit <- c(0,60)
    ylimit <- c(0,0.1)
    ylimit2 <- c(0,50)
    legLoc <- "topright"
    run2()
  }
  if(n == 8){
    locate <- "CON"
    xlimit <- c(0,20)
    ylimit <- c(0,0.2)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
  if(n == 9){
    locate <- "HRC"
    xlimit <- c(0,20)
    ylimit <- c(0,0.35)
    ylimit2 <- c(0,25)
    legLoc <- "topleft"
    run2()
  }
  if(n == 10){
    locate <- "U201"
    xlimit <- c(0,15)
    ylimit <- c(0,0.3)
    ylimit2 <- c(0,20)
    legLoc <- "topleft"
    run2()
  }
}

rm(list=ls())
