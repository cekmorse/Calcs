##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

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
load("volA.Rdata"); vola <- volumeChange
load("volB.Rdata"); volb <- volumeChange
load("volC.Rdata"); volc <- volumeChange
load("volD.Rdata"); vold <- volumeChange
load("volE.Rdata"); vole <- volumeChange

storageChange <- vola + volb + volc + vold + vole  	# in (m^3/day)
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / (61.7 * 1.609344)				# in m^3/(sec*km)

storageChangeStats <- changeStats(dates, storageChange)
storageChangeStatsStats <- changeStatsStats(storageChangeStats[,-1])

setwd(models.A)
save(storageChange, file="m storageChange.Rdata")
save(storageChangeStats, file="m storageChangeStats.Rdata")
setwd(results.A)
write.csv(storageChangeStatsStats, file="m storageChangeStatsStats.csv")
rm(vola, volb, volc, vold, vole, storageChangeStats, storageChangeStatsStats)

##### Sum(Surface flows) #####
setwd(modelsFile)
load("qCAN.Rdata")
load("qCON.Rdata")
load("qFLS.Rdata")
load("qFLY.Rdata")
load("qHOL.Rdata")
load("qHRC.Rdata")
load("qin.Rdata")
load("qout.Rdata")
load("qRFD.Rdata")
load("qRFR.Rdata")
load("qTIM.Rdata")
load("qWTP.Rdata")

flowChange <- q.in - q.HOL - q.RFD - q.FLS + q.RFR + q.TIM - q.FLY + q.CAN - q.CON + q.HRC + q.WTP - q.out
flowChange <- flowChange / (61.7 * 1.609344)				# in m^3/(sec*km)

flowChangeStats <- changeStats(dates, flowChange)
flowChangeStatsStats <- changeStatsStats(flowChangeStats[,-1])

setwd(models.A)
save(flowChange, file="m flowChange.Rdata")
save(flowChangeStats, file="m flowChangeStats.Rdata")
setwd(results.A)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")
rm(q.in, q.HOL, q.RFD, q.FLS, q.RFR, q.TIM, q.FLY, q.CAN, q.CON, q.HRC, q.WTP, q.out, flowChangeStats, flowChangeStatsStats)

##### Sum(Atmospheric contributions) #####!
# negated
##########################################!

##### Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions) #####
setwd(modelsFile)
load("m unknownWater.Rdata")
baseUnknown <- unknownWater
setwd(models.A)

unknownWater <-  storageChange - flowChange
unknownWaterDif <- (unknownWater - baseUnknown)/baseUnknown*100

unknownWaterStats <- changeStats(dates, unknownWater)
unknownWaterStatsStats <- changeStatsStats(unknownWaterStats[,-1])
unknownWaterDifStats <- difStats(unknownWaterDif)

setwd(models.A)
save(unknownWater, file="m unknownWater.Rdata")
save(unknownWaterStats, file="m unknownWaterStats.Rdata")
setwd(results.A)
write.csv(unknownWaterStatsStats, file="m unknownWaterStatsStats.csv")
write.csv(unknownWaterDifStats, file="m unknownWaterDifStats.csv")
rm(flowChange, storageChange, unknownWater, unknownWaterStats, unknownWaterStatsStats)


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