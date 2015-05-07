setwd(stochFolder)
load(paste("c lm ",locate,".Rdata", sep=""))
load(paste("c variables ",locate,".Rdata", sep=""))
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

setwd(outFolder)

if(locate == "WTP"){
  est <- predict(estim, newdata=subsetData)
} else {
  est <- predict.lm(estim, newdata=subsetData)  
}

est[est <= cMin] <- cMin
setwd(outFolder)

save(est, file=paste("c ",lName,".Rdata",sep=""))