cflux <- 0.0864                    # m^3/s * ug/L to kg/day conversion

setwd(outFolder)
attach(cd2)

locate <- "D101C"
load("c D101C.Rdata")
f.101 <- q.in * est * cflux
save(f.101, file=paste("f ",locate,".Rdata",sep=""))
rm(f.101)

locate <- "BIG"
load("c BIG.Rdata")
f.BIG <- q.BIG * est * cflux
save(f.BIG, file=paste("f ",locate,".Rdata",sep=""))
rm(f.BIG)

locate <- "BUF"
load("c BUF.Rdata")
f.BUF <- q.BUF * est * cflux
save(f.BUF, file=paste("f ",locate,".Rdata",sep=""))
rm(f.BUF)

locate <- "WIL"
load("c WIL.Rdata")
f.WIL <- q.WIL * est * cflux
save(f.WIL, file=paste("f ",locate,".Rdata",sep=""))
rm(f.WIL)

locate <- "FRO"
load("c D106C.Rdata")                        # Assumed same concentrations as at D106C
f.FRO <- q.FRO * est * cflux
save(f.FRO, file=paste("f ",locate,".Rdata",sep=""))
rm(f.FRO)

locate <- "D106C"
load("c D106C.Rdata")
f.106 <- q.out * est * cflux
save(f.106, file=paste("f ",locate,".Rdata",sep=""))
rm(f.106)

cflux <- 1E-6

locate <- "Segment F"
load("c D101C.Rdata"); est1 <- est
load("c BUF.Rdata"); est2 <- est
load("volf.Rdata")
est <- (est1 + est2)/2
f.F <- volumeChange * est * cflux
save(f.F, file=paste("f ",locate,".Rdata",sep=""))
rm(f.F)

locate <- "Segment G"
load("c BUF.Rdata"); est1 <- est
load("c D106C.Rdata"); est2 <- est
load("volg.Rdata")
est <- (est1 + est2)/2
f.G <- volumeChange * est * cflux
save(f.G, file=paste("f ",locate,".Rdata",sep=""))
rm(f.G)

detach(cd2)