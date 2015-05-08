##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/InvarPlots.R")
}

setwd(dataFile)
DSRvar <- read.csv("data.csv", header=TRUE)

setwd(modelsFile)
load("date.Rdata")

dName <- "qin"
load("qin.Rdata")
eValVect <- DSRvar$q.in
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
eValVect <- DSRvar$ec.in
sValMatr <- ec.in
rm(ec.in)
densXlim <- c(0,2)
densYlim <- c(0, 2.0)
densXlab <- expression(Spec~Conductivity~(dS~m^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(dS~m^-1))
run1()

dName <- "tin"
load("tin.Rdata")
eValVect <- DSRvar$t.in
sValMatr <- t.in
rm(t.in)
densXlim <- c(0,30)
densYlim <- c(0, .08)
diffXlim <- c(-0.02,0.1)
pdifXlim <- c(-10,400)
densXlab <- expression(Water~Temperature~(degree~C))
diffXlab <- expression(Deviation~from~Expected~Value~(degree~C))
run1()

dName <- "qBIG"
load("qBIG.Rdata")
eValVect <- DSRvar$q.BIG
sValMatr <- q.BIG
rm(q.BIG)
densXlim <- c(0,10)
densYlim <- c(0,0.8)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qWIL"
load("qWIL.Rdata")
eValVect <- DSRvar$q.WIL
sValMatr <- q.WIL
rm(q.WIL)
densXlim <- c(0,2)
densYlim <- c(0,2)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qBUF"
load("qBUF.Rdata")
eValVect <- DSRvar$q.BUF
sValMatr <- q.BUF
rm(q.BUF)
densXlim <- c(0,15)
densYlim <- c(0,0.8)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qFRO"
load("qFRO.Rdata")
eValVect <- DSRvar$q.FRO
sValMatr <- q.FRO
rm(q.FRO)
densXlim <- c(0,1)
densYlim <- c(0,4)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "qout"
load("qout.Rdata")
eValVect <- DSRvar$q.out
sValMatr <- q.out
rm(q.out)
densXlim <- c(0,50)
densYlim <- c(0,.2)
densXlab <- expression(Flow~(m^3~s^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(m^3~s^-1))
run1()

dName <- "ecout"
load("ecout.Rdata")
eValVect <- DSRvar$ec.out
sValMatr <- ec.out
rm(ec.out)
densXlim <- c(0,4)
densYlim <- c(0, 1.5)
densXlab <- expression(Spec~Conductivity~(dS~m^-1))
diffXlab <- expression(Deviation~from~Expected~Value~(dS~m^-1))
run1()

dName <- "tout"
load("tout.Rdata")
eValVect <- DSRvar$t.out
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
eValVect <- DSRvar$et
sValMatr <- et
rm(et)
densXlim <- c(0,.02)
densYlim <- c(0, 125)
densXlab <- expression(Reference~ET~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "p"
load("p.Rdata")
eValVect <- DSRvar$p
sValMatr <- p
rm(p)
densXlim <- c(0,0.05)
densYlim <- c(0, 1000)
densXlab <- expression(Precipitation~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "depthF1"
load("depthF1.Rdata")
eValVect <- DSRvar$df.0
sValMatr <- depthToday
rm(depthToday)
densXlim <- c(0,1.6)
densYlim <- c(0, 2.5)
densXlab <- expression(Flow~Depth~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

dName <- "depthG1"
load("depthG1.Rdata")
eValVect <- DSRvar$dg.0
sValMatr <- depthToday
rm(depthToday)
densXlim <- c(0,1.6)
densYlim <- c(0, 3.5)
densXlab <- expression(Flow~Depth~(m))
diffXlab <- expression(Deviation~from~Expected~Value~(m))
run1()

rm(list=ls())