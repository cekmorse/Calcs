##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")
load("USRB1.Rdata"); geomB1 <- USRB1$est[[1]]
load("USRB2.Rdata"); geomB2 <- exp(USRB2$est[[1]])

setwd(dataFile)
USRvar <- read.csv("data.csv")

setwd(models.D)
load("depthA1.Rdata")
dA1 <- depthToday
load("depthB1.Rdata")
dB1 <- depthToday
load("depthC1.Rdata")
dC1 <- depthToday
load("depthD1.Rdata")
dD1 <- depthToday
load("depthE1.Rdata")
dE1 <- depthToday
rm(depthToday)
USRvar$et <- USRvar$et + 0.00047

setwd(models.D)
attach(USRvar)
calcData <-data.frame(q.in, ec.in, t.in, q.out, ec.out, t.out, q.CAN, q.CON, q.FLS, q.FLY, q.HOL, q.HRC, q.RFD, q.RFR, q.TIM,
                      q.WTP, dA1, dB1, dC1, dD1, dE1, p, et, RHmin, u2, geomB1, geomB2)
detach(USRvar)

save(calcData, file="calcData.Rdata")

rm(list=ls())
