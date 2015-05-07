##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)

calcRFlux <- function(flow, conc){
  return <- flow * conc * 0.0864
}

calcSFlux <- function(volumeChange, conc1, conc2){
  return <- volumeChange * rowMeans(cbind(conc1,conc2)) * 1E-6
}

locate <- "D101C"
load("qin.Rdata")
load("c D101C.Rdata")
f.101 <- calcRFlux(q.in, est)
save(f.101, file=paste("f ",locate,".Rdata",sep=""))
rm(q.in, f.101)

locate <- "BIG"
load("qBIG.Rdata")
load("c BIG.Rdata")
f.BIG <- calcRFlux(q.BIG, est)
save(f.BIG, file=paste("f ",locate,".Rdata",sep=""))
rm(q.BIG, f.BIG)

locate <- "BUF"
load("qBUF.Rdata")
load("c BUF.Rdata")
f.BUF <- calcRFlux(q.BUF, est)
save(f.BUF, file=paste("f ",locate,".Rdata",sep=""))
rm(q.BUF, f.BUF)

locate <- "WIL"
load("qWIL.Rdata")
load("c WIL.Rdata")
f.WIL <- calcRFlux(q.WIL, est)
save(f.WIL, file=paste("f ",locate,".Rdata",sep=""))
rm(q.WIL, f.WIL)

locate <- "FRO"
load("qFRO.Rdata")
load("c D106C.Rdata")                        # Assumed same concentrations as at D106C
f.FRO <- calcRFlux(q.FRO, est)
save(f.FRO, file=paste("f ",locate,".Rdata",sep=""))
rm(q.FRO, f.FRO)

locate <- "D106C"
load("qout.Rdata")
load("c D106C.Rdata")
f.106 <- calcRFlux(q.out, est)
save(f.106, file=paste("f ",locate,".Rdata",sep=""))
rm(q.out, f.106)

cflux <- 1E-6

locate <- "Segment F"
load("c D101C.Rdata"); est1 <- est
load("c BUF.Rdata"); est2 <- est
load("volf.Rdata")
f.F <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.F, file=paste("f ",locate,".Rdata",sep=""))
rm(f.F)

locate <- "Segment G"
load("c BUF.Rdata"); est1 <- est
load("c D106C.Rdata"); est2 <- est
load("volg.Rdata")
f.G <- calcSFlux(volumeChange, est1, est2)
save(est, file=paste("c ",locate,".Rdata",sep=""))
save(f.G, file=paste("f ",locate,".Rdata",sep=""))

rm(list=ls())