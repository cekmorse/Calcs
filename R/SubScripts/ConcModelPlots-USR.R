setwd(modelsFile)
load(paste("c lm ",locate,".Rdata", sep=""))
load(paste("c meas to fit ",locate,".Rdata", sep=""))
load(paste("c resid fit ",locate,".Rdata", sep=""))
load(paste("c variables ",locate,".Rdata", sep=""))

#measToFit <- data.frame(measToFit)

subsetData <- seData[seData$locate == locate, variables]

if(locate == "U163" || locate == "U201" || locate == "U167" || locate == "WTP"){
  supvar <- c("cse","q.in","ec.in","t.in","q.out","ec.out","t.out")
  supsetData <- seData[seData$locate == locate, supvar]
}
if(locate == "UDIV"){
  supvar <- c("cse","q.in","ec.in","t.in","q.out","ec.out","t.out","di")
  supsetData <- seData[seData$locate == locate, supvar]
}
if(locate != "U163" && locate != "U201" && locate != "UDIV" && locate != "U167" && locate != "WTP"){
  supvar <- c("cse","q.in","ec.in","t.in","q.out","ec.out","t.out","q.x")
  supsetData <- seData[seData$locate == locate, supvar]
}

supvarLab <- as.list(colnames(supsetData))
for(i in 1:length(supvarLab)){
  if(supvarLab[i] == "cse"){supvarLab[i] <- expression(C[Se]);next}
  if(supvarLab[i] == "q.in"){supvarLab[i] <- expression(Q[ARKCATCO]); next}
  if(supvarLab[i] == "ec.in"){supvarLab[i] <- expression(EC[ARKCATCO]); next}
  if(supvarLab[i] == "t.in"){supvarLab[i] <- expression(T[ARKCATCO]); next}
  if(supvarLab[i] == "q.out"){supvarLab[i] <- expression(Q[ARKLASCO]); next}
  if(supvarLab[i] == "ec.out"){supvarLab[i] <- expression(EC[ARKLASCO]); next}
  if(supvarLab[i] == "t.out"){supvarLab[i] <- expression(T[ARKLASCO]); next}
  if(supvarLab[i] == "di"){supvarLab[i] <- expression(L[Segment]); next}
  if(supvarLab[i] == "q.x"){
    if(locate == "TIM"){supvarLab[i] <- expression(Q[TIMSWICO]); next}
    if(locate == "CAN"){supvarLab[i] <- expression(Q[CANSWKCO]); next}
    if(locate == "HRC"){supvarLab[i] <- expression(Q[HRC194CO]); next}
    if(locate == "WTP"){supvarLab[i] <- expression(Q[LAJWWTP]); next}
  }
}

varLab <- as.list(variables)
for(i in 1:length(varLab)){
  if(variables[i] == "cse"){varLab[i] <- expression(C[Se]);next}
  if(variables[i] == "q.in"){varLab[i] <- expression(Q[ARKCATCO]); next}
  if(variables[i] == "ec.in"){varLab[i] <- expression(EC[ARKCATCO]); next}
  if(variables[i] == "t.in"){varLab[i] <- expression(T[ARKCATCO]); next}
  if(variables[i] == "q.out"){varLab[i] <- expression(Q[ARKLASCO]); next}
  if(variables[i] == "ec.out"){varLab[i] <- expression(EC[ARKLASCO]); next}
  if(variables[i] == "t.out"){varLab[i] <- expression(T[ARKLASCO]); next}
  if(variables[i] == "di"){varLab[i] <- expression(L[Segment]); next}
  if(variables[i] == "q.x"){
    if(locate == "TIM"){expression(Q[TIMSWICO]); next}
    if(locate == "CAN"){expression(Q[CANSWKCO]); next}
    if(locate == "HRC"){expression(Q[HRC194CO]); next}
    if(locate == "WTP"){expression(Q[LAJWWTP]); next}
  }
}

setwd(plotFile)
pdf(file=paste("Conc Model Full Pairs",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,4.1,1.1))
pairs(supsetData, pch=20, upper.panel=panel.pearson, labels=as.expression(supvarLab), cex=1)
dev.off()

pdf(file=paste("Conc Model Pairs",locate,".pdf", sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,4.1,1.1))
pairs(subsetData, pch=20, upper.panel=panel.pearson, labels=as.expression(varLab), cex=1)
dev.off()

##### Check for WTP #####
pdf(file=paste("Conc Model lm-fit ",locate,".pdf",sep=""), width=6, height=6, family="Times")
if(locate == "WTP"){
  par(mfrow=c(2,1))
  par(mar=c(5.1,4.1,1.5,1.1))
  plot(nlsResiduals(estim), which=1)
  plot(nlsResiduals(estim), which=4)
} else {
  par(mfrow=c(2,2))
  par(mar=c(5.1,4.1,1.5,1.1))
  plot(estim, pch=20)
}
dev.off()

pdf(file=paste("Conc Model pred v meas ",locate,".pdf",sep=""), width=6, height=6, family="Times")
ylabel <- expression(Predicted~C[Se]~(mu*g~L^-1))
xlabel <- expression(Measured~C[Se]~(mu*g~L^-1))
par(mar=c(5.1,4.1,1.1,1.1))
plot(measToFit$meas, measToFit$fit, pch=20, xlab=xlabel, ylab=ylabel)
abline(a=0, b=1)
dev.off()

pdf(file=paste("Conc Model res-fit ",locate,".pdf",sep=""), width=6, height=6, family="Times")
plot(residFit, pch=20)
dev.off()

pdf(file=paste("Conc Model ResDist ",locate,".pdf",sep=""), width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
h1 <- hist(measToFit$meas, plot=F)
h2 <- hist(measToFit$fit, plot=F)
d1 <- density(measToFit$meas)
d2 <- density(measToFit$fit)
ylimit <- c(0, max(h1$density, h2$density, d1$y, d2$y))
xlimit <- c(min(h1$breaks, h2$breaks, d1$x, d2$x), max(h1$breaks, h2$breaks, d1$x, d2$x))
xlabel <- expression(C[Se]~(mu*g~L^-1))
hist(measToFit$meas, freq=F, ylim=ylimit, xlim=xlimit, main="", xlab=xlabel)
lines(d1, lwd=2, lty=2)
lines(d2, lwd=2, col="red")
legend("topleft", legend=c("Kernel Density", "Fitted"), lwd=c(2,2), lty=c(2,1), col=c("black","red"))
dev.off()