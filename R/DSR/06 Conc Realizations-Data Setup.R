##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)

load("qin.Rdata")
load("ecin.Rdata")
load("tin.Rdata")
load("qout.Rdata")
load("ecout.Rdata")
load("tout.Rdata")
load("qBIG.Rdata")
load("qWIL.Rdata")
load("qBUF.Rdata")
load("qFRO.Rdata")

q.in <- as.vector(as.matrix(q.in))
ec.in <- as.vector(as.matrix(ec.in))
t.in <- as.vector(as.matrix(t.in))
q.out <- as.vector(as.matrix(q.out))
ec.out <- as.vector(as.matrix(ec.out))
t.out <- as.vector(as.matrix(t.out))
q.BIG <- as.vector(as.matrix(q.BIG))
q.WIL <- as.vector(as.matrix(q.WIL))
q.BUF <- as.vector(as.matrix(q.BUF))
q.FRO <- as.vector(as.matrix(q.FRO))

calcData <-data.frame(q.in, ec.in, t.in, q.out, ec.out, t.out, q.BIG, q.WIL, q.BUF, q.FRO)
save(calcData, file="calcData.Rdata")

rm(list=ls())
