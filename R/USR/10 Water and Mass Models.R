##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

##############
#
# Water balance model
#
# Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions)
#
##############
reachLengthMiles <- 61.7        		## in miles
reachLength <- reachLengthMiles * 1.609344	## in kilometers

##### Sum(river storage changes) #####
load("volA.Rdata"); vola <- volumeChange
load("volB.Rdata"); volb <- volumeChange
load("volC.Rdata"); volc <- volumeChange
load("volD.Rdata"); vold <- volumeChange
load("volE.Rdata"); vole <- volumeChange
storageChange <- vola + volb + volc + vold + vole  	# in (m^3/day)
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / reachLength				# in m^3/(sec*km)

storageChangeStats <- changeStats(dates, storageChange)
storageChangeStatsStats <- changeStatsStats(storageChangeStats[,-1])

setwd(modelsFile)
save(storageChange, file="m storageChange.Rdata")
save(storageChangeStats, file="m storageChangeStats.Rdata")

setwd(resultsFile)
write.csv(storageChangeStatsStats, file="m storageChangeStatsStats.csv")
setwd(modelsFile)
rm(vola, volb, volc, vold, vole)

##### Sum(Surface flows) #####
files <- list.files(pattern=glob2rx("q*.Rdata"))               # in(m^3/sec)
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
flowChange <- flowChange / reachLength				# in m^3/(sec*km)

flowChangeStats <- changeStats(dates, flowChange)
flowChangeStatsStats <- changeStatsStats(flowChangeStats[,-1])

setwd(modelsFile)
save(flowChange, file="m flowChange.Rdata")
save(flowChangeStats, file="m flowChangeStats.Rdata")

setwd(resultsFile)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")

setwd(modelsFile)
rm(q.in, q.HOL, q.RFD, q.FLS, q.RFR, q.TIM, q.FLY, q.CAN, q.CON, q.HRC, q.WTP, q.out)

##### Sum(Atmospheric contributions) #####
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
atmChange <- atmChange / reachLength					# in m^3/(sec*km)

atmChangeStats <- changeStats(dates, atmChange)
atmChangeStatsStats <- changeStatsStats(atmChangeStats[,-1])

setwd(modelsFile)
save(atmChange, file="m atmChange.Rdata")
save(atmChangeStats, file="m atmChangeStats.Rdata")

setwd(resultsFile)
write.csv(atmChangeStatsStats, file="m atmChangeStatsStats.csv")

setwd(modelsFile)
rm(areaA, areaB, areaC, areaD, areaE, atm)

# Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions)
unknownWater <- storageChange - flowChange - atmChange

unknownWaterStats <- changeStats(dates, unknownWater)
unknownWaterStatsStats <- changeStatsStats(unknownWaterStats[,-1])

setwd(modelsFile)
save(unknownWater, file="m unknownWater.Rdata")
save(unknownWaterStats, file="m unknownWaterStats.Rdata")

setwd(resultsFile)
write.csv(unknownWaterStatsStats, file="m unknownWaterStatsStats.csv")

setwd(modelsFile)
rm(storageChange, flowChange, atmChange, surfaceArea, volumeChange)

##############
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
##############

##### Sum(river mass changes) #####
load("f Segment A.Rdata")
load("f Segment B.Rdata")
load("f Segment C.Rdata")
load("f Segment D.Rdata")
load("f Segment E.Rdata")

massStoreChange <- f.A + f.B + f.C + f.D + f.E			# in kg / day
massStoreChange <- massStoreChange / reachLength		# in kg / (day*km)

massStoreChangeStats <- changeStats(dates, massStoreChange)
massStoreChangeStatsStats <- changeStatsStats(massStoreChangeStats[,-1])

setwd(modelsFile)
save(massStoreChange, file="m massStoreChange.Rdata")
save(massStoreChangeStats, file="m massStoreChangeStats.Rdata")

setwd(resultsFile)
write.csv(massStoreChangeStatsStats, file="m massStoreChangeStatsStats.csv")

setwd(modelsFile)
rm(f.A, f.B, f.C, f.D, f.E)

# Sum(Surface flux)
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

massFlux <- f.163 - f.HOL - f.RFD - f.FLS + f.RFR + f.TIM - f.FLY + f.CAN - f.CON + f.HRC + f.WTP - f.U201		# in kg / day
massFlux <- massFlux / reachLength				# in kg/(day*km)

massFluxStats <- changeStats(dates, massFlux)
massFluxStatsStats <- changeStatsStats(massFluxStats[,-1])

setwd(modelsFile)
save(massFlux, file="m massFlux.Rdata")
save(massFluxStats, file="m massFluxStats.Rdata")

setwd(resultsFile)
write.csv(massFluxStatsStats, file="m massFluxStatsStats.csv")

setwd(modelsFile)
rm(f.163, f.CAN, f.CON, f.FLS, f.FLY, f.HOL, f.HRC, f.RFD, f.RFR, f.TIM, f.U201, f.WTP)

# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
unknownMass <- massStoreChange - massFlux

unknownMassStats <- changeStats(dates, unknownMass)
unknownMassStatsStats <- changeStatsStats(unknownMassStats[,-1])

setwd(modelsFile)
save(unknownMass, file="m unknownMass.Rdata")
save(unknownMassStats, file="m unknownMassStats.Rdata")

setwd(resultsFile)
write.csv(unknownMassStatsStats, file="m unknownMassStatsStats.csv")


# Average daily concentration of unaccounted for flow
unknownC <- unknownMass / unknownWater * 11.574074

unknownCStats <- changeStats(dates, unknownC)
unknownCStatsStats <- changeStatsStats(unknownCStats[,-1])

setwd(modelsFile)
save(unknownC, file="m unknownC.Rdata")
save(unknownCStats, file="m unknownCStats.Rdata")

setwd(resultsFile)
write.csv(unknownCStatsStats, file="m unknownCStatsStats.csv")

rm(list=ls())
