##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

setwd(models.D)
load("calcData.Rdata")

##############!
#
# Water balance model
#
# Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions)
#
##############!
reachLengthMiles <- 38.9            ## in miles
reachLength <- reachLengthMiles * 1.609344	## in kilometers

##### Sum(river storage changes) #####
load("volF.Rdata"); volf <- volumeChange
load("volG.Rdata"); volg <- volumeChange

storageChange <- volf + volg                  # in m^3 / day
storageChange <- storageChange / 86400				# in m^3 / sec
storageChange <- storageChange / reachLength				# in m^3 / (sec*km)

x <- storageChange

storageChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                             Mean=mean(x, na.rm=TRUE),
                                             P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                             SD=sd(x, na.rm=TRUE),
                                             Skew=skewness(x, na.rm=TRUE),
                                             Kurt=kurtosis(x, na.rm=TRUE)), 4)
save(storageChange, file="m storageChange.Rdata")
setwd(results.D)
write.csv(storageChangeStatsStats, file="m storageChangeStatsStats.csv")
rm(volf, volg, storageChangeStatsStats)

##### Sum(Surface flows) #####
attach(calcData)

flowChange <- q.in + q.BIG - q.BUF - q.FRO + q.WIL - q.out  # in m^3 / sec
flowChange <- flowChange / reachLength				# in m^3/(sec*km)

x <- flowChange

flowChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                          Mean=mean(x, na.rm=TRUE),
                                          P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                          SD=sd(x, na.rm=TRUE),
                                          Skew=skewness(x, na.rm=TRUE),
                                          Kurt=kurtosis(x, na.rm=TRUE)), 4)

setwd(models.D)
save(flowChange, file="m flowChange.Rdata")
setwd(results.D)
write.csv(flowChangeStatsStats, file="m flowChangeStatsStats.csv")
rm(flowChangeStatsStats)
detach(calcData)

##### Sum(Atmospheric contributions) #####
setwd(models.D)
load("A evap.Rdata")
atm <- (calcData$p * 0.5 - Evap)
rm(Evap)

load("areaF.Rdata"); areaF <- surfaceArea
load("areaG.Rdata"); areaG <- surfaceArea

surfaceArea <- areaF + areaG
atmChange <- atm * surfaceArea						# in m^3/day
atmChange <- atmChange / 86400					# in m^3/sec
atmChange <- atmChange / reachLength					# in m^3/(sec*km)

x <- atmChange

atmChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                         Mean=mean(x, na.rm=TRUE),
                                         P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                         SD=sd(x, na.rm=TRUE),
                                         Skew=skewness(x, na.rm=TRUE),
                                         Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(atmChange, file="m atmChange.Rdata")
setwd(results.D)
write.csv(atmChangeStatsStats, file="m atmChangeStatsStats.csv")
rm(areaF, areaG, atm, surfaceArea, atmChangeStatsStats)

##### Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions) #####
unknownWater <- storageChange - flowChange - atmChange

x <- unknownWater

unknownWaterStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                            Mean=mean(x, na.rm=TRUE),
                                            P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                            SD=sd(x, na.rm=TRUE),
                                            Skew=skewness(x, na.rm=TRUE),
                                            Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(unknownWater, file="m unknownWater.Rdata")
setwd(results.D)
write.csv(unknownWaterStatsStats, file="m unknownWaterStatsStats.csv")
rm(storageChange, flowChange, atmChange, unknownWaterStatsStats)


##############!
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
##############!

##### Sum(river mass changes) #####
setwd(models.D)
load("f Segment F.Rdata")
load("f Segment G.Rdata")

massStoreChange <- f.F + f.G
massStoreChange <- massStoreChange / reachLength    # in kg / (sec * km)

x <- massStoreChange

massStoreChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                               Mean=mean(x, na.rm=TRUE),
                                               P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                               SD=sd(x, na.rm=TRUE),
                                               Skew=skewness(x, na.rm=TRUE),
                                               Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(massStoreChange, file="m massStoreChange.Rdata")
setwd(results.D)
write.csv(massStoreChangeStatsStats, file="m massStoreChangeStatsStats.csv")
rm(f.F, f.G, massStoreChangeStatsStats)


##### Sum(Surface flux) #####
setwd(models.D)
load("f BIG.Rdata")
load("f BUF.Rdata")
load("f D101C.Rdata")
load("f D106C.Rdata")
load("f FRO.Rdata")
load("f WIL.Rdata")

massFlux <- f.101 + f.BIG - f.BUF - f.FRO + f.WIL - f.106
massFlux <- massFlux / reachLength				# in kg/(day*km)

x <- massFlux

massFluxStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                        Mean=mean(x, na.rm=TRUE),
                                        P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                        SD=sd(x, na.rm=TRUE),
                                        Skew=skewness(x, na.rm=TRUE),
                                        Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(massFlux, file="m massFlux.Rdata")
setwd(results.D)
write.csv(massFluxStatsStats, file="m massFluxStatsStats.csv")
rm(f.101, f.106, f.BIG, f.BUF, f.FRO, f.WIL, massFluxStatsStats)


##### Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux) #####
unknownMass <- massStoreChange - massFlux

x <- unknownMass

unknownMassStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                           Mean=mean(x, na.rm=TRUE),
                                           P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                           SD=sd(x, na.rm=TRUE),
                                           Skew=skewness(x, na.rm=TRUE),
                                           Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(unknownMass, file="m unknownMass.Rdata")
setwd(results.D)
write.csv(unknownMassStatsStats, file="m unknownMassStatsStats.csv")

unknownC <- unknownMass / unknownWater * 11.574074

unknownC <- unknownMass / unknownWater * 11.574074

x <- unknownC
unknownCStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                        Mean=mean(x, na.rm=TRUE),
                                        P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                        SD=sd(x, na.rm=TRUE),
                                        Skew=skewness(x, na.rm=TRUE),
                                        Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(unknownC, file="m unknownC.Rdata")
setwd(results.D)
write.csv(unknownCStatsStats, file="m unknownCStatsStats.csv")

unknownCin <- unknownC
unknownCin[unknownCin < 0] <- NA
x <- unknownCin
unknownCinStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                          Mean=mean(x, na.rm=TRUE),
                                          P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                          SD=sd(x, na.rm=TRUE),
                                          Skew=skewness(x, na.rm=TRUE),
                                          Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(unknownCin, file="m unknownCin.Rdata")
setwd(results.D)
write.csv(unknownCinStatsStats, file="m unknownCinStatsStats.csv")

unknownCout <- unknownC
unknownCout[unknownCout > 0] <- NA
x <- unknownCout
unknownCoutStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                           Mean=mean(x, na.rm=TRUE),
                                           P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                           SD=sd(x, na.rm=TRUE),
                                           Skew=skewness(x, na.rm=TRUE),
                                           Kurt=kurtosis(x, na.rm=TRUE)), 4)
setwd(models.D)
save(unknownCout, file="m unknownCout.Rdata")
setwd(results.D)
write.csv(unknownCoutStatsStats, file="m unknownCoutStatsStats.csv")

rm(list=ls())
