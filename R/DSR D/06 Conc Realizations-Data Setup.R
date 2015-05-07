##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")
load("DSRB1.Rdata"); geomB1 <- DSRB1$est[[1]]
load("DSRB2.Rdata"); geomB2 <- exp(DSRB2$est[[1]])

setwd(dataFile)
DSRvar <- read.csv("data.csv")

setwd(models.D)
load("depthF1.Rdata")
dF1 <- depthToday
load("depthG1.Rdata")
dG1 <- depthToday
rm(depthToday)
DSRvar$et <- DSRvar$et + 0.00047

setwd(models.D)
attach(DSRvar)
calcData <-data.frame(q.in, ec.in, t.in, q.out, ec.out, t.out, q.BIG, q.BUF, q.WIL, q.FRO, dF1, dG1, p, et, RHmin, u2, geomB1, geomB2)
detach(DSRvar)

save(calcData, file="calcData.Rdata")

rm(list=ls())