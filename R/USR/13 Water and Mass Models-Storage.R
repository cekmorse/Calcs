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

##### Sum(river storage changes) #####!
# negated
######################################!

##### Sum(Surface flows) #####
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
  
setwd(models.S)
save(flowChange, file="m flowChange.Rdata")
save(flowChangeStats, file="m flowChangeStats.Rdata")
setwd(results.S)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")
rm(q.in, q.HOL, q.RFD, q.FLS, q.RFR, q.TIM, q.FLY, q.CAN, q.CON, q.HRC, q.WTP, q.out, flowChangeStats, flowChangeStatsStats)

##### Sum(Atmospheric contributions) #####
setwd(modelsFile)
load("A evap.Rdata")
load("p.Rdata")
p <- p * 0.5							# m/day. Approx % storm coverage
atm <- (p - Evap)							# m/day
rm(Evap,p)

load("areaA.Rdata"); areaA <- surfaceArea
load("areaB.Rdata"); areaB <- surfaceArea
load("areaC.Rdata"); areaC <- surfaceArea
load("areaD.Rdata"); areaD <- surfaceArea
load("areaE.Rdata"); areaE <- surfaceArea

surfaceArea <- areaA + areaB + areaC + areaD + areaE			# in m^2
atmChange <- atm * surfaceArea						# in m^3/day
atmChange <- atmChange / 86400					# in m^3/sec
atmChange <- atmChange / (61.7 * 1.609344)					# in m^3/(sec*km)

atmChangeStats <- changeStats(dates, atmChange)
atmChangeStatsStats <- changeStatsStats(atmChangeStats[,-1])

setwd(models.S)
save(atmChange, file="m atmChange.Rdata")
save(atmChangeStats, file="m atmChangeStats.Rdata")
setwd(results.S)
write.csv(atmChangeStatsStats, file="m atmChangeStatsStats.csv")
rm(areaA, areaB, areaC, areaD, areaE, atm, surfaceArea, atmChangeStats, atmChangeStatsStats)

##### Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions) #####
setwd(modelsFile)
load("m unknownWater.Rdata")
baseUnknown <- unknownWater
setwd(models.S)

unknownWater <-  - flowChange - atmChange
unknownWaterDif <- (unknownWater - baseUnknown)/baseUnknown*100

unknownWaterStats <- changeStats(dates, unknownWater)
unknownWaterStatsStats <- changeStatsStats(unknownWaterStats[,-1])
unknownWaterDifStats <- difStats(unknownWaterDif)

setwd(models.S)
save(unknownWater, file="m unknownWater.Rdata")
save(unknownWaterStats, file="m unknownWaterStats.Rdata")
setwd(results.S)
write.csv(unknownWaterStatsStats, file="m unknownWaterStatsStats.csv")
write.csv(unknownWaterDifStats, file="m unknownWaterDifStats.csv")
rm(flowChange, atmChange, unknownWater, unknownWaterStats, unknownWaterStatsStats)


##############!
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
##############!

##### Sum(river mass changes) ####!
# negated
##################################!

##### Sum(Surface flux) #####
setwd(modelsFile)
load("f CAN.Rdata")
load("f CON.Rdata")
load("f FLS.Rdata")
load("f FLY.Rdata")
load("f HOL.Rdata")
load("f HRC.Rdata")
load("f RFD.Rdata")
load("f RFR.Rdata")
load("f TIM.Rdata")
load("f U163.Rdata")
load("f U201.Rdata")
load("f WTP.Rdata")

massFlux <- f.163 - f.HOL - f.RFD - f.FLS + f.RFR + f.TIM - f.FLY + f.CAN - f.CON + f.HRC + f.WTP - f.U201
massFlux <- massFlux / (61.7 * 1.609344)				# in kg/(day*km)

massFluxStats <- changeStats(dates, massFlux)
massFluxStatsStats <- changeStatsStats(massFluxStats[,-1])

setwd(models.S)
save(massFlux, file="m massFlux.Rdata")
save(massFluxStats, file="m massFluxStats.Rdata")
setwd(results.S)
write.csv(massFluxStatsStats, file="m massFluxStatsStats.csv")
rm(f.163, f.CAN, f.CON, f.FLS, f.FLY, f.HOL, f.HRC, f.RFD, f.RFR, f.TIM, f.U201, f.WTP, massFluxStats, massFluxStatsStats)


# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
setwd(modelsFile)
load("m unknownMass.Rdata")
baseUnknown <- unknownMass
setwd(models.S)

unknownMass <- - massFlux
unknownMassDif <- (unknownMass - baseUnknown)/baseUnknown*100

unknownMassStats <- changeStats(dates, unknownMass)
unknownMassStatsStats <- changeStatsStats(unknownMassStats[,-1])
unknownMassDifStats <- difStats(unknownMassDif)

save(unknownMass, file="m unknownMass.Rdata")
save(unknownMassStats, file="m unknownMassStats.Rdata")
setwd(results.S)
write.csv(unknownMassStatsStats, file="m unknownMassStatsStats.csv")
write.csv(unknownMassDifStats, file="m unknownMassDifStats.csv")
rm(list=ls())
