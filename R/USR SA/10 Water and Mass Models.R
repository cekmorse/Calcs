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
load("volA.Rdata"); vola <- volumeChange
load("volB.Rdata"); volb <- volumeChange
load("volC.Rdata"); volc <- volumeChange
load("volD.Rdata"); vold <- volumeChange
load("volE.Rdata"); vole <- volumeChange

storageChange <- vola + volb + volc + vold + vole  	# in (m^3/day)
storageChange <- storageChange / 86400				# in m^3/sec
storageChange <- storageChange / reachLength				# in m^3/(sec*km)

##### Sum(Surface flows) #####
attach(cd2)

flowChange <- q.in - q.HOL - q.RFD - q.FLS + q.RFR + q.TIM - q.FLY + q.CAN - q.CON + q.HRC + q.WTP - q.out # in m^3/sec
flowChange <- flowChange / reachLength				# in m^3/(sec*km)

detach(cd2)

##### Sum(Atmospheric contributions) #####
load("A evap.Rdata")
atm <- (cd2$p * 0.5 - Evap)
rm(Evap)

load("areaA.Rdata"); areaA <- surfaceArea
load("areaB.Rdata"); areaB <- surfaceArea
load("areaC.Rdata"); areaC <- surfaceArea
load("areaD.Rdata"); areaD <- surfaceArea
load("areaE.Rdata"); areaE <- surfaceArea

surfaceArea <- areaA + areaB + areaC + areaD + areaE			# in m^2
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
load("f Segment A.Rdata")
load("f Segment B.Rdata")
load("f Segment C.Rdata")
load("f Segment D.Rdata")
load("f Segment E.Rdata")

massStoreChange <- f.A + f.B + f.C + f.D + f.E
massStoreChange <- massStoreChange / reachLength    # in kg / (sec * km)

##### Sum(Surface flux) #####
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
massFlux <- massFlux / reachLength				# in kg/(day*km)

##### Sum(unknown mass changes) = Sum(river mass changes) - Sum(Surface flux) #####
unknownMass <- massStoreChange - massFlux

x <- unknownMass

unknownMassStatsStats <- signif(data.frame(P0.025=quantile(unknownMass, probs=0.025, na.rm=TRUE),
                                           Mean=mean(unknownMass, na.rm=TRUE),
                                           P0.975=quantile(unknownMass, probs=0.975, na.rm=TRUE)), 4)
