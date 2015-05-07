##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)

calcRFlux <- function(flow, conc){
# kg/day <- m^3/s * ug/L * C
  return <- flow  * conc * 0.0864
}

calcSFlux <- function(volumeChange, conc1, conc2){
# kg/day <- m^3/day      * ug/L                         * C
  return <- volumeChange * rowMeans(cbind(conc1,conc2)) * 1E-6
}

locate <- "U163"
load("qin.Rdata")
load("c U163.Rdata")
f.163 <- calcRFlux(q.in, est)
save(f.163, file=paste("f ",locate,".Rdata",sep=""))
rm(q.in, f.163)

locate <- "HOL"
load("qHOL.Rdata")
load("c HOL.Rdata")
f.HOL <- calcRFlux(q.HOL, est)
save(f.HOL, file=paste("f ",locate,".Rdata",sep=""))
rm(q.HOL, f.HOL)

locate <- "RFD"
load("qRFD.Rdata")
load("c RFD.Rdata")
f.RFD <- calcRFlux(q.RFD, est)
save(f.RFD, file=paste("f ",locate,".Rdata",sep=""))
rm(q.RFD, f.RFD)

locate <- "RFR"
load("qRFR.Rdata")
load("c RFD.Rdata")                  # assumed same concentrations as RFR.  This locate diverts water from RFR back to the Ark.R.
f.RFR <- calcRFlux(q.RFR, est)
save(f.RFR, file=paste("f ",locate,".Rdata",sep=""))
rm(q.RFR, f.RFR)

locate <- "FLS"
load("qFLS.Rdata")
load("c FLS.Rdata")
f.FLS <- calcRFlux(q.FLS, est)
save(f.FLS, file=paste("f ",locate,".Rdata",sep=""))
rm(q.FLS, f.FLS)

locate <- "TIM"
load("qTIM.Rdata")
load("c TIM.Rdata")
f.TIM <- calcRFlux(q.TIM, est)
save(f.TIM, file=paste("f ",locate,".Rdata",sep=""))
rm(q.TIM, f.TIM)

locate <- "FLY"
load("qFLY.Rdata")
load("c FLY.Rdata")
f.FLY <- calcRFlux(q.FLY, est)
save(f.FLY, file=paste("f ",locate,".Rdata",sep=""))
rm(q.FLY, f.FLY)

locate <- "CAN"
load("qCAN.Rdata")
load("c CAN.Rdata")
f.CAN <- calcRFlux(q.CAN, est)
save(f.CAN, file=paste("f ",locate,".Rdata",sep=""))
rm(q.CAN, f.CAN)

locate <- "WTP"
load("qWTP.Rdata")
load("c WTP.Rdata")
f.WTP <- calcRFlux(q.WTP, est)
save(f.WTP, file=paste("f ",locate,".Rdata",sep=""))
rm(q.WTP, f.WTP)

locate <- "CON"
load("qCON.Rdata")
load("c CON.Rdata")
f.CON <- calcRFlux(q.CON, est)
save(f.CON, file=paste("f ",locate,".Rdata",sep=""))
rm(q.CON, f.CON)

locate <- "HRC"
load("qHRC.Rdata")
load("c HRC.Rdata")
f.HRC <- calcRFlux(q.HRC, est)
save(f.HRC, file=paste("f ",locate,".Rdata",sep=""))
rm(q.HRC, f.HRC)

locate <- "U201"
load("qout.Rdata")
load("c U201.Rdata")
f.U201 <- calcRFlux(q.out, est)
save(f.U201, file=paste("f ",locate,".Rdata",sep=""))
rm(q.out, f.U201)

locate <- "Segment A"
load("c U163.Rdata"); est1 <- est
load("c HOL.Rdata"); est2 <- est
load("vola.Rdata")
f.A <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.A, file=paste("f ",locate,".Rdata",sep=""))
rm(f.A)

locate <- "Segment B"
load("c HOL.Rdata"); est1 <- est
load("c FLS.Rdata"); est2 <- est
load("volb.Rdata")
f.B <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.B, file=paste("f ",locate,".Rdata",sep=""))
rm(f.B)

locate <- "Segment C"
load("c FLS.Rdata"); est1 <- est
load("c FLY.Rdata"); est2 <- est
load("volc.Rdata")
f.C <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.C, file=paste("f ",locate,".Rdata",sep=""))
rm(f.C)

locate <- "Segment D"
load("c FLY.Rdata"); est1 <- est
load("c CON.Rdata"); est2 <- est
load("vold.Rdata")
f.D <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.D, file=paste("f ",locate,".Rdata",sep=""))
rm(f.D)

locate <- "Segment E"
load("c CON.Rdata"); est1 <- est
load("c U201.Rdata"); est2 <- est
load("vole.Rdata")
f.E <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.E, file=paste("f ",locate,".Rdata",sep=""))

rm(list=ls())