##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

setwd(dataFile)
# Trim depths to 0.5 <= H <= 5'
ds <- read.csv("TW_USR.csv")
ds <- ds[which(ds$H <= 5*0.3048 & ds$H >= 0.5*0.3048 ),] ## SI Units

# Generate alpha, beta, residuals and plots of each for each section
AB <- data.frame(matrix(NA, nrow=max(ds$Section)-1, ncol=3))
R <- NA
for(i in 1:(max(ds$Section)-1)){
  if( i %in% ds$Section == FALSE ) {next}
  h <- ds[which(ds$Section==i),which(colnames(ds)=="H")]
  tw <- ds[which(ds$Section==i),which(colnames(ds)=="Tw")]
  dx <- data.frame(tw=tw, h=h)
  source("~/Projects/Calcs/R/SubScripts/Survey 1.R")
  AB[i,] <- cbind(a,b,rse)
  R <- append(R, r)
}
R <- R[2:length(R)]
colnames(AB) <- c("a","b","rse")
AB <- AB[complete.cases(AB),]
setwd(modelsFile)
save(AB, file="AB.Rdata")

# Alpha Distribution ----
data <- AB$a
options(warn=-1)
res = fitData(data, fit=c("logistic", "normal", "exponential", "poisson", "weibull", "lognormal"), sample=1)
options(warn=0)
res <- data.frame(res)
setwd(resultsFile)
write.table(res, file="USR B1 K-S values.txt", sep="\t") #view the data set to choose the best fit

setwd(plotFile)
pdf("USR B1 Dist.pdf", width=6, height=6, family="Times")
xlimit <- c(0,300)
ylimit <- c(0,0.008)
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(USR~beta[1]~Values))
rug(data)
rng <- seq(0,xlimit[2],0.1)
lines(density(data), lwd=2, lty=2)  #, bw="SJ"
lines(rng, dlogis(rng, as.numeric(as.character(res[1,2])), as.numeric(as.character(res[1,3]))), col="red", lwd=2)
lines(rng, dnorm(rng, as.numeric(as.character(res[2,2])), as.numeric(as.character(res[2,3]))), col="blue", lwd=2)
lines(rng, dexp(rng, as.numeric(as.character(res[3,2]))), col="Chartreuse4", lwd=2)
lines(rng, dweibull(rng, as.numeric(as.character(res[5,2])), as.numeric(as.character(res[5,3]))), col="darkorange2", lwd=2)
lines(rng, dlnorm(rng, as.numeric(as.character(res[6,2])), as.numeric(as.character(res[6,3]))), col="cyan3", lwd=2)
legend("topright", legend=c("data density", "logistic","normal","exponential", "weibull","log-normal"), 
       col=c("black","red","blue","chartreuse4","darkorange2","cyan3"), 
       lty=c(2,1,1,1,1,1), lwd=c(2,2,2,2,2,2))
dev.off()

###################################
### --- Chosen Distribution --- ###
# Logistic
setwd(modelsFile)
USRB1 <- fitdistr(data, "logistic")
save(USRB1, file="USRB1.Rdata")
### --- Chosen Distribution --- ###
###################################

AFit <- c(USRB1$est[[1]], USRB1$est[[2]])
fittest <- dtrunc(rng, "logis", a=0, location=AFit[[1]], scale=AFit[[2]])
Arandom <- rtrunc(5000, "logis", a=0, location=AFit[[1]], scale=AFit[[2]])

setwd(plotFile)
pdf("USR B1 Dist Check.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(USR~beta[1]~Values))
rug(data)
lines(density(data), lwd=2, lty=2)
lines(rng,fittest, lwd=2, col="red")
lines(density(Arandom), lwd=2, lty=2, col="red")
legend("topright", legend=c("data density", "truncated logistic","random truncated logistic"), 
       col=c("black","red","red"), 
       lty=c(2,1,2), lwd=c(2,2,2))
dev.off()

# Beta Distribution ----
data <- AB$b
options(warn=-1)
res = fitData(data, fit=c("logistic", "normal", "exponential", "poisson", "weibull", "lognormal"), sample=1)
options(warn=0)
setwd(resultsFile)
write.table(res, file="USR B2 K-S values.txt", sep="\t") #view the data set to choose the best fit

setwd(plotFile)
pdf("USR B2 Dist.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
xlimit <- c(0,2.0)
ylimit <- c(0,2.1)
hist(data, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(USR~beta[2]~Values))
rug(data)
rng <- seq(0,2.0,0.1)
lines(density(data), lwd=2, lty=2)
lines(rng, dlogis(rng, as.numeric(as.character(res[1,2])), as.numeric(as.character(res[1,3]))), col="red", lwd=2)
lines(rng, dnorm(rng, as.numeric(as.character(res[2,2])), as.numeric(as.character(res[2,3]))), col="blue", lwd=2)
lines(rng, dexp(rng, as.numeric(as.character(res[3,2]))), col="Chartreuse4", lwd=2)
lines(rng, dweibull(rng, as.numeric(as.character(res[5,2])), as.numeric(as.character(res[5,3]))), col="darkorange2", lwd=2)
lines(rng, dlnorm(rng, as.numeric(as.character(res[6,2])), as.numeric(as.character(res[6,3]))), col="cyan3", lwd=2)
legend("topright", legend=c("data density", "logistic","normal","exponential", "weibull","log-normal"), 
       col=c("black","red","blue","chartreuse4","darkorange2","cyan3"), 
       lty=c(2,1,1,1,1,1), lwd=c(2,2,2,2,2,2))
dev.off()

###################################
### --- Chosen Distribution --- ###
# Log-normal
setwd(modelsFile)
USRB2 <- fitdistr(data, "lognormal")
save(USRB2, file="USRB2.Rdata")
### --- Chosen Distribution --- ###
###################################

BFit <- c(USRB2$est[[1]], USRB2$est[[2]])
fittest <- dlnorm(rng, meanlog=BFit[[1]], sdlog=BFit[[2]])
Brandom <- rlnorm(5000, meanlog=BFit[[1]], sdlog=BFit[[2]])

setwd(plotFile)
pdf("USR B2 Dist Check.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(USR~beta[2]~Values))
rug(data)
lines(density(data), lwd=2, lty=2)
lines(rng,fittest, lwd=2, col="cyan3")
lines(density(Brandom), lwd=2, lty=2, col="cyan3")
legend("topright", legend=c("data density", "log-normal","random log-normal"), 
       col=c("black","cyan3","cyan3"), 
       lty=c(2,1,2), lwd=c(2,2,2))
dev.off()

# Residual Distribution ----
data <- AB$rse
options(warn=-1)
res = fitData(data, fit=c("logistic", "normal", "exponential", "poisson", "weibull", "lognormal"), sample=1)
options(warn=0)
setwd(resultsFile)
write.table(res, file="USR B1B2 Error K-S values.txt", sep="\t") #view the data set to choose the best fit

setwd(plotFile)
pdf("USR AB Error Dist.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
xlimit <- c(0,35)
ylimit <- c(0,0.15)
hist(data, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(USR~Geometry~Residual~Values))
rug(data)
rng <- seq(0,xlimit[2],0.1)
lines(density(data), lwd=2, lty=2)
lines(rng, dlogis(rng, as.numeric(as.character(res[1,2])), as.numeric(as.character(res[1,3]))), col="red", lwd=2)
lines(rng, dnorm(rng, as.numeric(as.character(res[2,2])), as.numeric(as.character(res[2,3]))), col="blue", lwd=2)
lines(rng, dexp(rng, as.numeric(as.character(res[3,2]))), col="Chartreuse4", lwd=2)
lines(rng, dweibull(rng, as.numeric(as.character(res[5,2])), as.numeric(as.character(res[5,3]))), col="darkorange2", lwd=2)
lines(rng, dlnorm(rng, as.numeric(as.character(res[6,2])), as.numeric(as.character(res[6,3]))), col="cyan3", lwd=2)
legend("topright", legend=c("data density", "logistic","normal","exponential", "weibull","log-normal"), 
       col=c("black","red","blue","chartreuse4","darkorange2","cyan3"), 
       lty=c(2,1,1,1,1,1), lwd=c(2,2,2,2,2,2))
dev.off()

###################################
### --- Chosen Distribution --- ###
# Logistic
setwd(modelsFile)
USRBe <- fitdistr(data, "logistic")
save(USRBe, file="USRBe.Rdata")
### --- Chosen Distribution --- ###
###################################

RFit <- c(USRBe$est[[1]], USRBe$est[[2]])
fittest <- dtrunc(rng, "logis", a=0, location=RFit[[1]], scale=RFit[[2]])
Rrandom <- rtrunc(5000, "logis", a=0, location=RFit[[1]], scale=RFit[[2]])

setwd(plotFile)
pdf("USR AB Error Dist Check.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=xlimit, ylim=ylimit, main="", xlab=expression(USR~Geometry~Residual~Values))
rug(data)
lines(density(data), lwd=2, lty=2)
lines(rng,fittest, lwd=2, col="red")
lines(density(Rrandom), lwd=2, lty=2, col="red")
legend("topright", legend=c("data density", "log-normal","random log-normal"), 
       col=c("black","red","red"), 
       lty=c(2,1,2), lwd=c(2,2,2))
dev.off()

rm(list=ls())