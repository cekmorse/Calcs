##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

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

##### Sum(river storage changes) #####
load("volA.Rdata"); vola <- volumeChange
load("volB.Rdata"); volb <- volumeChange
load("volC.Rdata"); volc <- volumeChange
load("volD.Rdata"); vold <- volumeChange
load("volE.Rdata"); vole <- volumeChange

storageChange <- vola + volb + volc + vold + vole  	# in (m^3/day)
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / (61.7 * 1.609344)				# in m^3/(sec*km)

x <- storageChange

storageChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                     Mean=mean(x, na.rm=TRUE),
                                     P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                     SD=sd(x, na.rm=TRUE),
                                     Skew=skewness(x, na.rm=TRUE),
                                     Kurt=kurtosis(x, na.rm=TRUE)
                                     ), 4)
save(storageChange, file="m storageChange.Rdata")
setwd(results.D)
write.csv(storageChangeStatsStats, file="m storageChangeStatsStats.csv")
rm(vola, volb, volc, vold, vole, storageChangeStatsStats)

##### Sum(Surface flows) #####
attach(calcData)

flowChange <- q.in - q.HOL - q.RFD - q.FLS + q.RFR + q.TIM - q.FLY + q.CAN - q.CON + q.HRC + q.WTP - q.out
flowChange <- flowChange / (61.7 * 1.609344)				# in m^3/(sec*km)

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
atm <- (calcData$p * 0.5 - Evap)							# m/day
rm(Evap)

load("areaA.Rdata"); areaA <- surfaceArea
load("areaB.Rdata"); areaB <- surfaceArea
load("areaC.Rdata"); areaC <- surfaceArea
load("areaD.Rdata"); areaD <- surfaceArea
load("areaE.Rdata"); areaE <- surfaceArea

surfaceArea <- areaA + areaB + areaC + areaD + areaE			# in m^2
atmChange <- atm * surfaceArea						# in m^3/day
atmChange <- atmChange / 86400					# in m^3/sec
atmChange <- atmChange / (61.7 * 1.609344)					# in m^3/(sec*km)

x <- atmChange

atmChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                         Mean=mean(x, na.rm=TRUE),
                                         P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                         SD=sd(x, na.rm=TRUE),
                                         Skew=skewness(x, na.rm=TRUE),
                                         Kurt=kurtosis(x, na.rm=TRUE)), 4)
save(atmChange, file="m atmChange.Rdata")
setwd(results.D)
write.csv(atmChangeStatsStats, file="m atmChangeStatsStats.csv")
rm(areaA, areaB, areaC, areaD, areaE, atm, surfaceArea, atmChangeStatsStats)

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
load("f Segment A.Rdata")
load("f Segment B.Rdata")
load("f Segment C.Rdata")
load("f Segment D.Rdata")
load("f Segment E.Rdata")

massStoreChange <- f.A + f.B + f.C + f.D + f.E
massStoreChange <- massStoreChange / (61.7 * 1.609344)    # in kg / (sec * km)

x <- massStoreChange

massStoreChangeStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                               Mean=mean(x, na.rm=TRUE),
                                               P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                               SD=sd(x, na.rm=TRUE),
                                               Skew=skewness(x, na.rm=TRUE),
                                               Kurt=kurtosis(x, na.rm=TRUE)), 4)
save(massStoreChange, file="m massStoreChange.Rdata")
setwd(results.D)
write.csv(massStoreChangeStatsStats, file="m massStoreChangeStatsStats.csv")
rm(f.A, f.B, f.C, f.D, f.E, massStoreChangeStatsStats)


##### Sum(Surface flux) #####
setwd(models.D)
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

x <- massFlux

massFluxStatsStats <- signif(data.frame(P0.025=quantile(x, probs=0.025, na.rm=TRUE),
                                        Mean=mean(x, na.rm=TRUE),
                                        P0.975=quantile(x, probs=0.975, na.rm=TRUE),
                                        SD=sd(x, na.rm=TRUE),
                                        Skew=skewness(x, na.rm=TRUE),
                                        Kurt=kurtosis(x, na.rm=TRUE)), 4)
save(massFlux, file="m massFlux.Rdata")
setwd(results.D)
write.csv(massFluxStatsStats, file="m massFluxStatsStats.csv")
rm(f.163, f.CAN, f.CON, f.FLS, f.FLY, f.HOL, f.HRC, f.RFD, f.RFR, f.TIM, f.U201, f.WTP, massFluxStatsStats)


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
