##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/D Transport and Storage Plots.R")
}

setwd(models.D)
load("date.Rdata")

locate <- "CAN"
load("f CAN.Rdata")
x <- f.CAN
rm(f.CAN)
ylabel <- expression("Mass Flux"~~(kg %.% day^-1 %.% km^-1))
run1()

locate <- "CON"
load("f CON.Rdata")
x <- f.CON
rm(f.CON)
run1()

locate <- "FLS"
load("f FLS.Rdata")
x <- f.FLS
rm(f.FLS)
run1()

locate <- "FLY"
load("f FLY.Rdata")
x <- f.FLY
rm(f.FLY)
run1()

locate <- "HOL"
load("f HOL.Rdata")
x <- f.HOL
rm(f.HOL)
run1()

locate <- "HRC"
load("f HRC.Rdata")
x <- f.HRC
rm(f.HRC)
run1()

locate <- "RFD"
load("f RFD.Rdata")
x <- f.RFD
rm(f.RFD)
run1()

locate <- "RFR"
load("f RFR.Rdata")
x <- f.RFR
rm(f.RFR)
run1()

locate <- "TIM"
load("f TIM.Rdata")
x <- f.TIM
rm(f.TIM)
run1()

locate <- "U163"
load("f U163.Rdata")
x <- f.163
rm(f.163)
run1()

locate <- "U201"
load("f U201.Rdata")
x <- f.U201
rm(f.U201)
run1()

locate <- "WTP"
load("f WTP.Rdata")
x <- f.WTP
rm(f.WTP)
run1()

locate <- "Segment A"
load("f Segment A.Rdata")
x <- f.A
rm(f.A)
ylabel <- expression("Mass Storage Change"~~(kg %.% day^-1 %.% km^-1))
run1()

locate <- "Segment B"
load("f Segment B.Rdata")
x <- f.B
rm(f.B)
run1()

locate <- "Segment C"
load("f Segment C.Rdata")
x <- f.C
rm(f.C)
run1()

locate <- "Segment D"
load("f Segment D.Rdata")
x <- f.D
rm(f.D)
run1()

locate <- "Segment E"
load("f Segment E.Rdata")
x <- f.E
rm(f.E)
run1()

rm(list=ls())
