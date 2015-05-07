##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

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
setwd(models.S)
save(flowChange, file="m flowChange.Rdata")
save(flowChangeStats, file="m flowChangeStats.Rdata")
setwd(results.S)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")
rm(q.in, q.BIG, q.BUF, q.FRO, q.WIL, q.out, flowChangeStats, flowChangeStatsStats)

##### Sum(Atmospheric contributions) #####
setwd(modelsFile)
load("A evap.Rdata")
load("p.Rdata")
p <- p * 0.5							# m/day. Approx % storm coverage
atm <- (p - Evap)							# m/day
rm(Evap,p)

load("areaF.Rdata"); areaF <- surfaceArea
load("areaG.Rdata"); areaG <- surfaceArea

surfaceArea <- areaF + areaG
atmChange <- atm * surfaceArea						# in m^3/day
atmChange <- atmChange / 86400					# in m^3/sec
atmChange <- atmChange / (61.7 * 1.609344)					# in m^3/(sec*km)

x <- atmChange
atmChangeStats <- data.frame(date=dates,
                              P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                              Mean=rowMeans(x, na.rm=TRUE),
                              P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                              SD=apply(x, 1, sd, na.rm=TRUE),
                              Skew=apply(x, 1, skewness, na.rm=TRUE),
                              Kurt=apply(x, 1, kurtosis, na.rm=TRUE))

x <- atmChangeStats[,-1]
atmChangeStatsStats <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                                   xMean=colMeans(x, na.rm=TRUE),
                                   xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                                   xSD=apply(x, 2, sd, na.rm=TRUE),
                                   xSkew=apply(x, 2, skewness, na.rm=TRUE),
                                   xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)
setwd(models.S)
save(atmChange, file="m atmChange.Rdata")
save(atmChangeStats, file="m atmChangeStats.Rdata")
setwd(results.S)
write.csv(atmChangeStatsStats, file="m atmChangeStatsStats.csv")
rm(areaF, areaG, atm, surfaceArea, atmChangeStats, atmChangeStatsStats)

##### Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions) #####
setwd(modelsFile)
load("m unknownWater.Rdata")
baseUnknown <- unknownWater
setwd(models.S)

unknownWater <-  - flowChange - atmChange
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
setwd(models.S)
save(unknownWater, file="m unknownWater.Rdata")
save(unknownWaterStats, file="m unknownWaterStats.Rdata")
setwd(results.S)
write.csv(unknownWaterStatsStats, file="m unknownWaterStatsStats.csv")
write.csv(unknownWaterDifStats, file="m unknownWaterDifStats.csv")
rm(flowChange, atmChange, unknownWater, unknownWaterStats, unknownWaterStatsStats)


##############
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
##############

##### Sum(river mass changes) #####!
# negated
###################################!

##### Sum(Surface flux) #####
setwd(modelsFile)
load("f BIG.Rdata")
load("f BUF.Rdata")
load("f D101C.Rdata")
load("f D106C.Rdata")
load("f FRO.Rdata")
load("f WIL.Rdata")

massFlux <- f.101 + f.BIG - f.BUF - f.FRO + f.WIL - f.106
massFlux <- massFlux / (61.7 * 1.609344)				# in kg/(day*km)

x <- massFlux
massFluxStats <- data.frame(date=dates,
                              P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                              Mean=rowMeans(x, na.rm=TRUE),
                              P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                              SD=apply(x, 1, sd, na.rm=TRUE),
                              Skew=apply(x, 1, skewness, na.rm=TRUE),
                              Kurt=apply(x, 1, kurtosis, na.rm=TRUE))

x <- massFluxStats[,-1]
massFluxStatsStats <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                                   xMean=colMeans(x, na.rm=TRUE),
                                   xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                                   xSD=apply(x, 2, sd, na.rm=TRUE),
                                   xSkew=apply(x, 2, skewness, na.rm=TRUE),
                                   xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)
setwd(models.S)
save(massFlux, file="m massFlux.Rdata")
save(massFluxStats, file="m massFluxStats.Rdata")
setwd(results.S)
write.csv(massFluxStatsStats, file="m massFluxStatsStats.csv")
rm(f.101, f.106, f.BIG, f.BUF, f.FRO, f.WIL, massFluxStats, massFluxStatsStats)


# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
setwd(modelsFile)
load("m unknownMass.Rdata")
baseUnknown <- unknownMass
setwd(models.S)

unknownMass <- - massFlux
unknownMassDif <- (unknownMass - baseUnknown)/baseUnknown*100

x <- unknownMass
unknownMassStats <- data.frame(date=dates,
                               P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                               Mean=rowMeans(x, na.rm=TRUE),
                               P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                               SD=apply(x, 1, sd, na.rm=TRUE),
                               Skew=apply(x, 1, skewness, na.rm=TRUE),
                               Kurt=apply(x, 1, kurtosis, na.rm=TRUE))

x <- unknownMassStats[,-1]
unknownMassStatsStats <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                                           xMean=colMeans(x, na.rm=TRUE),
                                           xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                                           xSD=apply(x, 2, sd, na.rm=TRUE),
                                           xSkew=apply(x, 2, skewness, na.rm=TRUE),
                                           xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)

x <- unknownMassDif
unknownMassDifStats <- signif(data.frame(P.025=quantile(x, probs=0.025, na.rm=TRUE),
                                   Mean=mean(rowMeans(x, na.rm=TRUE), na.rm=TRUE),
                                   P.975=quantile(x, probs=0.975, na.rm=TRUE)),3)

save(unknownMass, file="m unknownMass.Rdata")
save(unknownMassStats, file="m unknownMassStats.Rdata")
setwd(results.S)
write.csv(unknownMassStatsStats, file="m unknownMassStatsStats.csv")
write.csv(unknownMassDifStats, file="m unknownMassDifStats.csv")
rm(list=ls())
