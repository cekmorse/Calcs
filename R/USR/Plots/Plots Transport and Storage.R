##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/Transport and Storage Plots.R")
}

ylabel1 <- expression("Mass Flux"~~(kg %.% day^-1 %.% km^-1))
ylabel2 <- expression("Mass Storage Change"~~(kg %.% day^-1 %.% km^-1))

setwd(modelsFile)
load("date.Rdata")

locate <- "CAN"
load("f CAN.Rdata")
x <- f.CAN
rm(f.CAN)
ylabel <- ylabel1
run1()

locate <- "CON"
load("f CON.Rdata")
x <- f.CON
rm(f.CON)
ylabel <- ylabel1
run1()

locate <- "FLS"
load("f FLS.Rdata")
x <- f.FLS
rm(f.FLS)
ylabel <- ylabel1
run1()

locate <- "FLY"
load("f FLY.Rdata")
x <- f.FLY
rm(f.FLY)
ylabel <- ylabel1
run1()

locate <- "HOL"
load("f HOL.Rdata")
x <- f.HOL
rm(f.HOL)
ylabel <- ylabel1
run1()

locate <- "HRC"
load("f HRC.Rdata")
x <- f.HRC
rm(f.HRC)
ylabel <- ylabel1
run1()

locate <- "RFD"
load("f RFD.Rdata")
x <- f.RFD
rm(f.RFD)
ylabel <- ylabel1
run1()

locate <- "RFR"
load("f RFR.Rdata")
x <- f.RFR
rm(f.RFR)
ylabel <- ylabel1
run1()

locate <- "TIM"
load("f TIM.Rdata")
x <- f.TIM
rm(f.TIM)
ylabel <- ylabel1
run1()

locate <- "U163"
load("f U163.Rdata")
x <- f.163
rm(f.163)
ylabel <- ylabel1
run1()

locate <- "U201"
load("f U201.Rdata")
x <- f.U201
rm(f.U201)
ylabel <- ylabel1
run1()

locate <- "WTP"
load("f WTP.Rdata")
x <- f.WTP
rm(f.WTP)
ylabel <- ylabel1
run1()

locate <- "Segment A"
load("f Segment A.Rdata")
x <- f.A
rm(f.A)
ylabel <- ylabel2
run1()

locate <- "Segment B"
load("f Segment B.Rdata")
x <- f.B
rm(f.B)
ylabel <- ylabel2
run1()

locate <- "Segment C"
load("f Segment C.Rdata")
x <- f.C
rm(f.C)
ylabel <- ylabel2
run1()

locate <- "Segment D"
load("f Segment D.Rdata")
x <- f.D
rm(f.D)
ylabel <- ylabel2
run1()

locate <- "Segment E"
load("f Segment E.Rdata")
x <- f.E
rm(f.E)
ylabel <- ylabel2
run1()

rm(list=ls())