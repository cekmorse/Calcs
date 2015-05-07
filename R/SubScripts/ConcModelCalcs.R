subsetData <- seData[seData$locate == locate, variables]
subsetData <- subsetData[complete.cases(subsetData),]
estim <- lm(model, data=subsetData, na.action=na.exclude)
estimCoef <- data.frame(t(estim$coef))
measToFit <- data.frame(cbind(meas=as.vector(na.omit(subsetData$cse)), fit=estim$fitted, resid=estim$resid))
options(warn=-1)
res <- fitData(estim$resid, fit=c("logistic", "normal"), sample=1)
options(warn=0)
residCoef <- res[which.min(res[,4]),]
residFit <- fitdist(estim$resid, as.character(residCoef$dist), "mle")

stats <- signif(rbind(Meas=data.frame(Min=min(measToFit$meas),
                                      P_2.5=quantile(measToFit$meas, 0.025),
                                      Mean=mean(measToFit$meas),
                                      P_97.5=quantile(measToFit$meas, 0.975),
                                      Max=max(measToFit$meas),
                                      SD=sd(measToFit$meas),
                                      Skew=skewness(measToFit$meas),
                                      Kurt=kurtosis(measToFit$meas)),
                      Fitted=data.frame(Min=min(measToFit$fit),
                                        P_2.5=quantile(measToFit$fit, 0.025),
                                        Mean=mean(measToFit$fit),
                                        P_97.5=quantile(measToFit$fit, 0.975),
                                        Max=max(measToFit$fit),
                                        SD=sd(measToFit$fit),
                                        Skew=skewness(measToFit$fit),
                                        Kurt=kurtosis(measToFit$fit)),
                      Resid=data.frame(Min=min(measToFit$resid),
                                       P_2.5=quantile(measToFit$resid, 0.025),
                                       Mean=mean(measToFit$resid),
                                       P_97.5=quantile(measToFit$resid, 0.975),
                                       Max=max(measToFit$resid),
                                       SD=sd(measToFit$resid),
                                       Skew=skewness(measToFit$resid),
                                       Kurt=kurtosis(measToFit$resid))),4)

save(variables, file=paste("c variables ",locate,".Rdata",sep=""))
save(estim, file=paste("c lm ",locate,".Rdata",sep=""))
save(estimCoef, file=paste("c lm coef ",locate,".Rdata",sep=""))
save(measToFit, file=paste("c meas to fit ",locate,".Rdata",sep=""))
save(residFit, file=paste("c resid fit ",locate,".Rdata",sep=""))
save(residCoef, file=paste("c resid coef ",locate,".Rdata",sep=""))
setwd(resultsFile)
write.csv(stats, file=paste("c meas-fit-resid stats ",locate,".csv",sep=""))
setwd(modelsFile)