##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/InvarPlots.R")
}

setwd(dataFile)
USRvar <- read.csv("data.csv", header=TRUE)

setwd(modelsFile)
load("date.Rdata")

dName <- "qin"
load("qin.Rdata")
eValVect <- USRvar$q.in
times <- dim(q.in)[[1]]
reals <- dim(q.in)[[2]]
sValMatr <- q.in
rm(q.in)
densXlim <- c(0,100)
densYlim <- c(0, 0.08)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "ecin"
load("ecin.Rdata")
eValVect <- USRvar$ec.in
sValMatr <- ec.in
rm(ec.in)
densXlim <- c(0,2)
densYlim <- c(0, 2.0)
densXlab <- expression(Spec~Conductivity~(dS~m^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(dS~m^-1))
run1()

dName <- "tin"
load("tin.Rdata")
eValVect <- USRvar$t.in
sValMatr <- t.in
rm(t.in)
densXlim <- c(0,30)
densYlim <- c(0, .08)
diffXlim <- c(-0.02,0.1)
pdifXlim <- c(-10,400)
densXlab <- expression(Water~Temperature~(degree~C))
diffXlab <- expression(Deviation~from~Expected~Value~(degree~C))
run1()

dName <- "qHOL"
load("qHOL.Rdata")
eValVect <- USRvar$q.HOL
sValMatr <- q.HOL
rm(q.HOL)
densXlim <- c(0,10)
densYlim <- c(0,0.8)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qRFD"
load("qRFD.Rdata")
eValVect <- USRvar$q.RFD
sValMatr <- q.RFD
rm(q.RFD)
densXlim <- c(0,2)
densYlim <- c(0,2)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qFLS"
load("qFLS.Rdata")
eValVect <- USRvar$q.FLS
sValMatr <- q.FLS
rm(q.FLS)
densXlim <- c(0,15)
densYlim <- c(0,0.8)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qRFR"
load("qRFR.Rdata")
eValVect <- USRvar$q.RFR
sValMatr <- q.RFR
rm(q.RFR)
densXlim <- c(0,1)
densYlim <- c(0,4)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qTIM"
load("qTIM.Rdata")
eValVect <- USRvar$q.TIM
sValMatr <- q.TIM
rm(q.TIM)
densXlim <- c(0,8)
densYlim <- c(0,0.6)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qFLY"
load("qFLY.Rdata")
eValVect <- USRvar$q.FLY
sValMatr <- q.FLY
rm(q.FLY)
densXlim <- c(0,35)
densYlim <- c(0,0.2)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qCAN"
load("qCAN.Rdata")
eValVect <- USRvar$q.CAN
sValMatr <- q.CAN
rm(q.CAN)
densXlim <- c(0,2.0)
densYlim <- c(0,2.5)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qCON"
load("qCON.Rdata")
eValVect <- USRvar$q.CON
sValMatr <- q.CON
rm(q.CON)
densXlim <- c(0,5)
densYlim <- c(0,0.8)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qHRC"
load("qHRC.Rdata")
eValVect <- USRvar$q.HRC
sValMatr <- q.HRC
rm(q.HRC)
densXlim <- c(0,2)
densYlim <- c(0,5)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qWTP"
load("qWTP.Rdata")
eValVect <- USRvar$q.WTP
sValMatr <- q.WTP
rm(q.WTP)
densXlim <- c(0,0.2)
densYlim <- c(0,35)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qout"
load("qout.Rdata")
eValVect <- USRvar$q.out
sValMatr <- q.out
rm(q.out)
densXlim <- c(0,50)
densYlim <- c(0,.2)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "ecout"
load("ecout.Rdata")
eValVect <- USRvar$ec.out
sValMatr <- ec.out
rm(ec.out)
densXlim <- c(0,4)
densYlim <- c(0, 1.5)
densXlab <- expression(Spec~Conductivity~(dS~m^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(dS~m^-1))
run1()

dName <- "tout"
load("tout.Rdata")
eValVect <- USRvar$t.out
sValMatr <- t.out
rm(t.out)
densXlim <- c(0,30)
densYlim <- c(0, .08)
diffXlim <- c(-0.02,0.02)
pdifXlim <- c(-10,10)
densXlab <- expression(Water~Temperature~(degree~C))
diffXlab <- expression(Deviation~from~Expected~Value~(degree~C))
run1()

dName <- "et"
load("et.Rdata")
eValVect <- USRvar$et
sValMatr <- et
rm(et)
densXlim <- c(0,.02)
densYlim <- c(0, 125)
densXlab <- expression(Reference~ET~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "p"
load("p.Rdata")
eValVect <- USRvar$p
sValMatr <- p
rm(p)
densXlim <- c(0,0.05)
densYlim <- c(0, 1000)
densXlab <- expression(Precipitation~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "depthA1"
load("depthA1.Rdata")
eValVect <- USRvar$da.0
sValMatr <- depthToday
rm(depthToday)
densXlim <- c(0,1.6)
densYlim <- c(0, 2.5)
densXlab <- expression(Flow~Depth~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "depthC1"
load("depthC1.Rdata")
eValVect <- USRvar$dc.0
sValMatr <- depthToday
rm(depthToday)
densXlim <- c(0,1.6)
densYlim <- c(0, 3.5)
densXlab <- expression(Flow~Depth~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "depthD1"
load("depthD1.Rdata")
eValVect <- USRvar$dd.0
sValMatr <- depthToday
rm(depthToday)
densXlim <- c(0,1.6)
densYlim <- c(0, 3.5)
densXlab <- expression(Flow~Depth~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "depthE1"
load("depthE1.Rdata")
eValVect <- USRvar$de.0
sValMatr <- depthToday
rm(depthToday)
densXlim <- c(0,1.6)
densYlim <- c(0, 3.5)
densXlab <- expression(Flow~Depth~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

rm(list=ls())
