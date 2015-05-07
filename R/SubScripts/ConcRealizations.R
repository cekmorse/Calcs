load(paste("c lm ",locate,".Rdata", sep=""))
load(paste("c variables ",locate,".Rdata", sep=""))
load(paste("c resid coef ",locate,".Rdata", sep=""))
variables <- variables[-1]
if(variables[length(variables)] == "di"){
  variables <- variables[-length(variables)]
  subsetData <- calcData[,variables]
  subsetData <- data.frame(cbind(subsetData, di))
} else if(variables[length(variables)] == "q.x"){
  variables[length(variables)] <- paste("q.",lName,sep="")
  subsetData <- data.frame(calcData[,variables])
  load(paste("c variables ",locate,".Rdata", sep=""))
  variables <- variables[-1]
  names(subsetData) <- variables
} else {
  subsetData <- data.frame(calcData[,variables])
}

if(locate == "WTP"){
  pred <- predict(estim, newdata=subsetData)
} else {
  pred <- predict.lm(estim, newdata=subsetData)  
}

pred[pred <= cMin] <- cMin

labErr <- rlogis(reals * times, labErP1, labErP2) / 100  # original calcs converted to percent

calcErP1 <- as.numeric(as.character(residCoef[[2]]))
calcErP2 <- as.numeric(as.character(residCoef[[3]]))
calcErDist <- as.character(residCoef[[1]])
if(calcErDist == "norm"){
  calcErr <- rnorm(reals * times, calcErP1, calcErP2)
} else if(calcErDist == "logis"){
  calcErr <- rlogis(reals * times, calcErP1, calcErP2)
}

est <- pred + labErr + calcErr

labErr1 <- 0
calcErr1 <- 0
killed <- 0
killWhileMax <- 100
bigKillWhile <- 0

for(i in 1:length(est)){
  if(is.na(est[i]) || est[i] >= cMin){
    next
  } else {
    killWhile <- 1
    while(killWhile <= killWhileMax && est[i] <= cMin){
      labErr1 <- rlogis(1, labErP1, labErP2) / 100
      if(calcErDist == "norm"){
        calcErr1 <- rnorm(1, calcErP1, calcErP2)
      } else if(calcErDist == "logis"){
        calcErr1 <- rlogis(1, calcErP1, calcErP2)
      }
      est[i] <- pred[i] + labErr1 + calcErr1
      killWhile <- killWhile + 1
    }
    if(killWhile == killWhileMax+1){est[i] <- NA; killed <- killed + 1}
    if(killWhile > bigKillWhile){bigKillWhile <- killWhile}
  }
#   print(i)
#   flush.console()
}

est <- data.frame(matrix(est, nrow=times))

# source("C:/Thesis/LARB/03 Thesis-Calcs/4 Output Se Flux/SubScripts/PlotConcentrations.R")
save(est, file=paste("c ",lName,".Rdata",sep=""))
print(paste("done w/",lName,"-",killed,"killed, max attempts =",bigKillWhile))
flush.console()
