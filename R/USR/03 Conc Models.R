##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

run <- function() {
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/ConcModelCalcs.R")
}

setwd(dataFile)
seData <- read.csv("SeEstData.csv")
setwd(modelsFile)

locate <- "U163"
variables <- c("cse", "q.in", "ec.in", "t.in")
model <- "cse ~ q.in + ec.in + t.in"
run()

locate <- "U201"
variables <- c("cse", "q.out", "t.out")
model <- "cse ~ q.out + t.out"
run()

locate <- "U167"
variables <- c("cse", "q.out", "ec.out", "t.out")
model <- "cse ~ q.out + ec.out + t.out"
run()

locate <- "UDIV"
variables <- c("cse", "ec.in", "q.out", "t.out", "di")
model <- "cse ~ ec.in + q.out + t.out + di"
run()

locate <- "TIM"
variables <- c("cse", "ec.in", "q.x")
model <- "cse ~ ec.in + q.x"
run()

locate <- "CAN"
variables <- c("cse", "q.in", "ec.in", "q.out", "t.out", "q.x")
model <- "cse ~ ec.in + q.out + t.out + q.x + q.x:q.in + q.x:q.out"
run()

locate <- "HRC"
variables <- c("cse", "q.x")
model <- "cse ~ q.x"
run()

# special case where non-linear regression is applied. nls and lm have different outputs.
# original code for lm left in place (commented) for reference.
locate <- "WTP"    
variables <- c("cse", "q.x")
model <- "cse ~ a * q.x ^ b"
modelStart <- list(a=20, b=1)
#run()

# require(fitdistrplus)
subsetData <- seData[seData$locate == locate, variables]
#estim <- lm(model, data=subsetData, na.action=na.exclude)
estim <- nls(model, data=subsetData, na.action=na.exclude, start=modelStart)
#estimCoef <- data.frame(t(estim$coef))
estimCoef <- data.frame(t(summary(estim)$coef[,1]))
#measToFit <- cbind(meas=as.vector(na.omit(subsetData$cse)), fit=estim$fitted)
measToFit <- data.frame(cbind(meas=as.vector(na.omit(subsetData$cse)), fit=predict(estim)))
#res <- fitData(estim$resid, fit=c("logistic", "normal"), sample=1)
options(warn=-1)
res <- fitData(summary(estim)$resid, fit=c("logistic", "normal"), sample=1)
options(warn=0)
residCoef <- res[which.min(res[,4]),]
#residFit <- fitdist(estim$resid, as.character(residCoef$dist), "mle")
residFit <- fitdist(summary(estim)$resid, as.character(residCoef$dist), "mle")

save(variables, file=paste("c variables ",locate,".Rdata",sep=""))
save(estim, file=paste("c lm ",locate,".Rdata",sep=""))
save(estimCoef, file=paste("c lm coef ",locate,".Rdata",sep=""))
save(measToFit, file=paste("c meas to fit ",locate,".Rdata",sep=""))
save(residFit, file=paste("c resid fit ",locate,".Rdata",sep=""))
save(residCoef, file=paste("c resid coef ",locate,".Rdata",sep=""))
setwd(resultsFile)
write.csv(stats, file=paste("c meas-fit-resid stats ",locate,".csv",sep=""))

rm(list=ls())
