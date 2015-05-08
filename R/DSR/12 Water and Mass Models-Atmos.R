##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)  # Set working directory
load("date.Rdata")

##############!
#
# Water balance model
#
# Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions)
#
##############!

##### Sum(river storage changes) #####
load("volF.Rdata"); volf <- volumeChange
load("volG.Rdata"); volg <- volumeChange


storageChange <- volf + volg
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / (61.7 * 1.609344)				# in m^3/(sec*km)

x <- storageChange
storageChangeStats <- data.frame(date=dates,
                                P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                                Mean=rowMeans(x, na.rm=TRUE),
                                P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                                SD=apply(x, 1, sd, na.rm=TRUE),
                                Skew=apply(x, 1, skewness, na.rm=TRUE),
                                Kurt=apply(x, 1, kurtosis, na.rm=TRUE))

x <- storageChangeStats[,-1]
storageChangeStatsStats <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                                     xMean=colMeans(x, na.rm=TRUE),
                                     xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                                     xSD=apply(x, 2, sd, na.rm=TRUE),
                                     xSkew=apply(x, 2, skewness, na.rm=TRUE),
                                     xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)
setwd(models.A)
save(storageChange, file="m storageChange.Rdata")
save(storageChangeStats, file="m storageChangeStats.Rdata")
setwd(results.A)
write.csv(storageChangeStatsStats, file="m storageChangeStatsStats.csv")
rm(volf, volg, storageChangeStats, storageChangeStatsStats)

##### Sum(Surface flows) #####
setwd(modelsFile)
load("qBIG.Rdata")
load("qBUF.Rdata")
load("qFRO.Rdata")
load("qin.Rdata")
load("qout.Rdata")
load("qWIL.Rdata")

flowChange <- q.in + q.BIG - q.BUF - q.FRO + q.WIL - q.out
flowChange <- flowChange / (61.7 * 1.609344)				# in m^3/(sec*km)

x <- flowChange
flowChangeStats <- data.frame(date=dates,
                                P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                                Mean=rowMeans(x, na.rm=TRUE),
                                P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                                SD=apply(x, 1, sd, na.rm=TRUE),
                                Skew=apply(x, 1, skewness, na.rm=TRUE),
                                Kurt=apply(x, 1, kurtosis, na.rm=TRUE))

x <- flowChangeStats[,-1]
flowChangeStatsStats <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                                     xMean=colMeans(x, na.rm=TRUE),
                                     xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                                     xSD=apply(x, 2, sd, na.rm=TRUE),
                                     xSkew=apply(x, 2, skewness, na.rm=TRUE),
                                     xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)
setwd(models.A)
save(flowChange, file="m flowChange.Rdata")
save(flowChangeStats, file="m flowChangeStats.Rdata")
setwd(results.A)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")
rm(q.in, q.BIG, q.BUF, q.FRO, q.WIL, q.out, flowChangeStats, flowChangeStatsStats)

##### Sum(Atmospheric contributions) #####!
# negated
##########################################!

##### Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions) #####
setwd(modelsFile)
load("m unknownWater.Rdata")
baseUnknown <- unknownWater
setwd(models.A)

unknownWater <- storageChange - flowChange
unknownWaterDif <- (unknownWater - baseUnknown)/baseUnknown*100

x <- unknownWater
unknownWaterStats <- data.frame(date=dates,
                             P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                             Mean=rowMeans(x, na.rm=TRUE),
                             P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                             SD=apply(x, 1, sd, na.rm=TRUE),
                             Skew=apply(x, 1, skewness, na.rm=TRUE),
                             Kurt=apply(x, 1, kurtosis, na.rm=TRUE))

x <- unknownWaterStats[,-1]
unknownWaterStatsStats <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                                  xMean=colMeans(x, na.rm=TRUE),
                                  xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                                  xSD=apply(x, 2, sd, na.rm=TRUE),
                                  xSkew=apply(x, 2, skewness, na.rm=TRUE),
                                  xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)
x <- unknownWaterDif
unknownWaterDifStats <- signif(data.frame(P.025=quantile(x, probs=0.025, na.rm=TRUE),
                                   Mean=mean(rowMeans(x, na.rm=TRUE), na.rm=TRUE),
                                   P.975=quantile(x, probs=0.975, na.rm=TRUE)),3)

setwd(models.A)
save(unknownWater, file="m unknownWater.Rdata")
save(unknownWaterStats, file="m unknownWaterStats.Rdata")
setwd(results.A)
write.csv(unknownWaterStatsStats, file="m unknownWaterStatsStats.csv")
write.csv(unknownWaterDifStats, file="m unknownWaterDifStats.csv")
rm(storageChange, flowChange, unknownWater, unknownWaterStats, unknownWaterStatsStats)


##############!
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
# No changes since atm is not part of this model
# 
##############!
rm(list=ls())
