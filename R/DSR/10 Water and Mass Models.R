##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

##############
#
# Water balance model
#
# Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions)
#
##############
reachLengthMiles <- 38.9          	## in miles
reachLength <- reachLengthMiles * 1.609344	## in kilometers

##### Sum(river storage changes) #####
load("volF.Rdata"); volf <- volumeChange
load("volG.Rdata"); volg <- volumeChange

storageChange <- volf + volg
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / reachLength  			# in m^3/(sec*km)

storageChangeStats <- changeStats(dates, storageChange)
storageChangeStatsStats <- changeStatsStats(storageChangeStats[,-1])

setwd(modelsFile)
save(storageChange, file="m storageChange.Rdata")
save(storageChangeStats, file="m storageChangeStats.Rdata")

setwd(resultsFile)
write.csv(storageChangeStatsStats, file="m storageChangeStatsStats.csv")
setwd(modelsFile)
rm(volf, volg)

##### Sum(Surface flows) #####
load("qBIG.Rdata")
load("qBUF.Rdata")
load("qFRO.Rdata")
load("qin.Rdata")
load("qout.Rdata")
load("qWIL.Rdata")
flowChange <- q.in + q.BIG - q.BUF - q.FRO + q.WIL - q.out      # in m^3/(sec)
flowChange <- flowChange / reachLength  			# in m^3/(sec*km)

flowChangeStats <- changeStats(dates, flowChange)
flowChangeStatsStats <- changeStatsStats(flowChangeStats[,-1])

setwd(modelsFile)
save(flowChange, file="m flowChange.Rdata")
save(flowChangeStats, file="m flowChangeStats.Rdata")

setwd(resultsFile)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")

setwd(modelsFile)

rm(q.in, q.BIG, q.BUF, q.FRO, q.WIL, q.out)

##### Sum(Atmospheric contributions) #####
load("A evap.Rdata")
load("p.Rdata")
p <- p * 0.5							# m/day. Approx % storm coverage
atm <- (p - Evap)							# m/day
rm(Evap,p)
load("areaF.Rdata"); areaF <- surfaceArea
load("areaG.Rdata"); areaG <- surfaceArea
surfaceArea <- areaF + areaG
atmChange <- atm * surfaceArea  					# in m^3/day
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
rm(areaF, areaG, atm, surfaceArea)

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
rm(storageChange, flowChange, atmChange, volumeChange)


##############
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
##############

##### Sum(river mass changes) #####
load("f Segment F.Rdata")
load("f Segment G.Rdata")
massStoreChange <- f.F + f.G                        # in kg / day
massStoreChange <- massStoreChange / reachLength  	# in kg / (day*km)

massStoreChangeStats <- changeStats(dates, massStoreChange)
massStoreChangeStatsStats <- changeStatsStats(massStoreChangeStats[,-1])

setwd(modelsFile)
save(massStoreChange, file="m massStoreChange.Rdata")
save(massStoreChangeStats, file="m massStoreChangeStats.Rdata")

setwd(resultsFile)
write.csv(massStoreChangeStatsStats, file="m massStoreChangeStatsStats.csv")

setwd(modelsFile)
rm(f.F, f.G)


# Sum(Surface flux)
load("f BIG.Rdata")
load("f BUF.Rdata")
load("f D101C.Rdata")
load("f D106C.Rdata")
load("f FRO.Rdata")
load("f WIL.Rdata")
massFlux <- f.101 + f.BIG - f.BUF - f.FRO + f.WIL - f.106  	# in kg / day
massFlux <- massFlux / reachLength				# in kg/(day*km)

massFluxStats <- changeStats(dates, massFlux)
massFluxStatsStats <- changeStatsStats(massFluxStats[,-1])

setwd(modelsFile)
save(massFlux, file="m massFlux.Rdata")
save(massFluxStats, file="m massFluxStats.Rdata")

setwd(resultsFile)
write.csv(massFluxStatsStats, file="m massFluxStatsStats.csv")

setwd(modelsFile)
rm(f.101, f.106, f.BIG, f.BUF, f.FRO, f.WIL)


# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
unknownMass <- massStoreChange - massFlux  # in kg /(day*km)

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
