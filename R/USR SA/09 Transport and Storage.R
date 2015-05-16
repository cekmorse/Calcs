calcRFlux <- function(flow, conc){
  # kg/day <- m^3/s * ug/L * C
  return <- flow  * conc * 0.0864
}

calcSFlux <- function(volumeChange, conc1, conc2){
  # kg/day <- m^3/day      * ug/L                         * C
  return <- volumeChange * rowMeans(cbind(conc1,conc2)) * 1E-6
}

setwd(models.SA)
attach(cd2)

locate <- "U163"
load("c U163.Rdata")
f.163 <- calcRFlux(q.in, est)
save(f.163, file=paste("f ",locate,".Rdata",sep=""))
rm(f.163)

locate <- "HOL"
load("c HOL.Rdata")
f.HOL <- calcRFlux(q.HOL, est)
save(f.HOL, file=paste("f ",locate,".Rdata",sep=""))
rm(f.HOL)

locate <- "RFD"
load("c RFD.Rdata")
f.RFD <- calcRFlux(q.RFD, est)
save(f.RFD, file=paste("f ",locate,".Rdata",sep=""))

locate <- "RFR" # assumed same concentrations as RFR.  This locate diverts water from RFR back to the Ark.R.
f.RFR <- calcRFlux(q.RFR, est)
save(f.RFR, file=paste("f ",locate,".Rdata",sep=""))
rm(f.RFR)

locate <- "FLS"
load("c FLS.Rdata")
f.FLS <- calcRFlux(q.FLS, est)
save(f.FLS, file=paste("f ",locate,".Rdata",sep=""))
rm(f.FLS)

locate <- "TIM"
load("c TIM.Rdata")
f.TIM <- calcRFlux(q.TIM, est)
save(f.TIM, file=paste("f ",locate,".Rdata",sep=""))
rm(f.TIM)

locate <- "FLY"
load("c FLY.Rdata")
f.FLY <- calcRFlux(q.FLY, est)
save(f.FLY, file=paste("f ",locate,".Rdata",sep=""))
rm(f.FLY)

locate <- "CAN"
load("c CAN.Rdata")
f.CAN <- calcRFlux(q.CAN, est)
save(f.CAN, file=paste("f ",locate,".Rdata",sep=""))
rm(f.CAN)

locate <- "WTP"
load("c WTP.Rdata")
f.WTP <- calcRFlux(q.WTP, est)
save(f.WTP, file=paste("f ",locate,".Rdata",sep=""))
rm(f.WTP)

locate <- "CON"
load("c CON.Rdata")
f.CON <- calcRFlux(q.CON, est)
save(f.CON, file=paste("f ",locate,".Rdata",sep=""))
rm(f.CON)

locate <- "HRC"
load("c HRC.Rdata")
f.HRC <- calcRFlux(q.HRC, est)
save(f.HRC, file=paste("f ",locate,".Rdata",sep=""))
rm(f.HRC)

locate <- "U201"
load("c U201.Rdata")
f.U201 <- calcRFlux(q.out, est)
save(f.U201, file=paste("f ",locate,".Rdata",sep=""))
rm( f.U201)


  
locate <- "Segment A"
load("c U163.Rdata"); est1 <- est
load("c HOL.Rdata"); est2 <- est
load("vola.Rdata")
f.A <- calcSFlux(volumeChange, est1, est2)
save(f.A, file=paste("f ",locate,".Rdata",sep=""))
rm(f.A)

locate <- "Segment B"
load("c HOL.Rdata"); est1 <- est
load("c FLS.Rdata"); est2 <- est
load("volb.Rdata")
f.B <- calcSFlux(volumeChange, est1, est2)
save(f.B, file=paste("f ",locate,".Rdata",sep=""))
rm(f.B)

locate <- "Segment C"
load("c FLS.Rdata"); est1 <- est
load("c FLY.Rdata"); est2 <- est
load("volc.Rdata")
f.C <- calcSFlux(volumeChange, est1, est2)
save(f.C, file=paste("f ",locate,".Rdata",sep=""))
rm(f.C)

locate <- "Segment D"
load("c FLY.Rdata"); est1 <- est
load("c CON.Rdata"); est2 <- est
load("vold.Rdata")
f.D <- calcSFlux(volumeChange, est1, est2)
save(f.D, file=paste("f ",locate,".Rdata",sep=""))
rm(f.D)

locate <- "Segment E"
load("c CON.Rdata"); est1 <- est
load("c U201.Rdata"); est2 <- est
load("vole.Rdata")
f.E <- calcSFlux(volumeChange, est1, est2)
save(f.E, file=paste("f ",locate,".Rdata",sep=""))

detach(cd2)
