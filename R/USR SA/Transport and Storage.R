cflux <- 0.0864                    # m^3/s * ug/L to kg/day conversion

setwd(outFolder)
attach(cd2)

locate <- "U163"
load("c U163.Rdata")
f.163 <- q.in * est * cflux
save(f.163, file=paste("f ",locate,".Rdata",sep=""))
rm(f.163)

locate <- "HOL"
load("c HOL.Rdata")
f.HOL <- q.HOL * est * cflux
save(f.HOL, file=paste("f ",locate,".Rdata",sep=""))
rm(f.HOL)

locate <- "RFD"
load("c RFD.Rdata")
f.RFD <- q.RFD * est * cflux
save(f.RFD, file=paste("f ",locate,".Rdata",sep=""))
rm(f.RFD)

locate <- "RFR"
load("c RFD.Rdata")                  # assumed same concentrations as RFR.  This locate diverts water from RFR back to the Ark.R.
f.RFR <- q.RFR * est * cflux
save(f.RFR, file=paste("f ",locate,".Rdata",sep=""))
rm(f.RFR)

locate <- "FLS"
load("c FLS.Rdata")
f.FLS <- q.FLS * est * cflux
save(f.FLS, file=paste("f ",locate,".Rdata",sep=""))
rm(f.FLS)

locate <- "TIM"
load("c TIM.Rdata")
f.TIM <- q.TIM * est * cflux
save(f.TIM, file=paste("f ",locate,".Rdata",sep=""))
rm(f.TIM)

locate <- "FLY"
load("c FLY.Rdata")
f.FLY <- q.FLY * est * cflux
save(f.FLY, file=paste("f ",locate,".Rdata",sep=""))
rm(f.FLY)

locate <- "CAN"
load("c CAN.Rdata")
f.CAN <- q.CAN * est * cflux
save(f.CAN, file=paste("f ",locate,".Rdata",sep=""))
rm(f.CAN)

locate <- "WTP"
load("c WTP.Rdata")
f.WTP <- q.WTP * est * cflux
save(f.WTP, file=paste("f ",locate,".Rdata",sep=""))
rm(f.WTP)

locate <- "CON"
load("c CON.Rdata")
f.CON <- q.CON * est * cflux
save(f.CON, file=paste("f ",locate,".Rdata",sep=""))
rm(f.CON)

locate <- "HRC"
load("c HRC.Rdata")
f.HRC <- q.HRC * est * cflux
save(f.HRC, file=paste("f ",locate,".Rdata",sep=""))
rm(f.HRC)

locate <- "U201"
load("c U201.Rdata")
f.U201 <- q.out * est * cflux
save(f.U201, file=paste("f ",locate,".Rdata",sep=""))
rm( f.U201)

cflux <- 1E-6

locate <- "Segment A"
load("c U163.Rdata"); est1 <- est
load("c HOL.Rdata"); est2 <- est
load("vola.Rdata")
est <- (est1 + est2)/2
f.A <- volumeChange * est * cflux
save(f.A, file=paste("f ",locate,".Rdata",sep=""))
rm(f.A)

locate <- "Segment B"
load("c HOL.Rdata"); est1 <- est
load("c FLS.Rdata"); est2 <- est
load("volb.Rdata")
est <- (est1 + est2)/2
f.B <- volumeChange * est * cflux
save(f.B, file=paste("f ",locate,".Rdata",sep=""))
rm(f.B)

locate <- "Segment C"
load("c FLS.Rdata"); est1 <- est
load("c FLY.Rdata"); est2 <- est
load("volc.Rdata")
est <- (est1 + est2)/2
f.C <- volumeChange * est * cflux
save(f.C, file=paste("f ",locate,".Rdata",sep=""))
rm(f.C)

locate <- "Segment D"
load("c FLY.Rdata"); est1 <- est
load("c CON.Rdata"); est2 <- est
load("vold.Rdata")
est <- (est1 + est2)/2
f.D <- volumeChange * est * cflux
save(f.D, file=paste("f ",locate,".Rdata",sep=""))
rm(f.D)

locate <- "Segment E"
load("c CON.Rdata"); est1 <- est
load("c U201.Rdata"); est2 <- est
load("vole.Rdata")
est <- (est1 + est2)/2
f.E <- volumeChange * est * cflux
save(f.E, file=paste("f ",locate,".Rdata",sep=""))

detach(cd2)
