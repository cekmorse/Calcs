setwd(models.S)
load("date.Rdata")
setwd(models.SA)

##############!
#
# Water balance model
#
# Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions)
#
##############!
reachLengthMiles <- 61.7            ## in miles
reachLength <- reachLengthMiles * 1.609344	## in kilometers

##### Sum(river storage changes) #####
load("volF.Rdata"); volf <- volumeChange
load("volG.Rdata"); volg <- volumeChange


storageChange <- volf + volg
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / reachLength				# in m^3/(sec*km)

##### Sum(Surface flows) #####
attach(cd2)

flowChange <- q.in + q.BIG - q.BUF - q.FRO + q.WIL - q.out
flowChange <- flowChange / reachLength				# in m^3/(sec*km)

detach(cd2)

##### Sum(Atmospheric contributions) #####
load("A evap.Rdata")
atm <- (cd2$p * 0.5 - Evap)
rm(Evap)

load("areaF.Rdata"); areaF <- surfaceArea
load("areaG.Rdata"); areaG <- surfaceArea

surfaceArea <- areaF + areaG
atmChange <- atm * surfaceArea						# in m^3/day
atmChange <- atmChange / 86400					# in m^3/sec
atmChange <- atmChange / reachLength					# in m^3/(sec*km)

##### Sum(unknown volume changes) = Sum(river storage changes) - Sum(Surface flows) - Sum(Atmospheric contributions) #####
unknownWater <- storageChange - flowChange - atmChange

unknownWaterStatsStats <- signif(data.frame(P0.025=quantile(unknownWater, probs=0.025, na.rm=TRUE),
                                            Mean=mean(unknownWater, na.rm=TRUE),
                                            P0.975=quantile(unknownWater, probs=0.975, na.rm=TRUE)), 4)

##############!
#
# Mass balance model
#
# Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux)
#
##############!

##### Sum(river mass changes) #####
load("f Segment F.Rdata")
load("f Segment G.Rdata")

massStoreChange <- f.F + f.G
massStoreChange <- massStoreChange / reachLength    # in kg / (sec * km)

##### Sum(Surface flux) #####
load("f BIG.Rdata")
load("f BUF.Rdata")
load("f D101C.Rdata")
load("f D106C.Rdata")
load("f FRO.Rdata")
load("f WIL.Rdata")

massFlux <- f.101 + f.BIG - f.BUF - f.FRO + f.WIL - f.106
massFlux <- massFlux / reachLength				# in kg/(day*km)

##### Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux) #####
unknownMass <- massStoreChange - massFlux

x <- unknownMass

unknownMassStatsStats <- signif(data.frame(P0.025=quantile(unknownMass, probs=0.025, na.rm=TRUE),
                                           Mean=mean(unknownMass, na.rm=TRUE),
                                           P0.975=quantile(unknownMass, probs=0.975, na.rm=TRUE)), 4)