##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

# Read in the data -----
setwd(dataFile)
USRvar <- read.csv("Data.csv", header=TRUE)

times <- length(dates)

setwd(models.D)
save(dates, file="date.Rdata")

# Q at ARKCATCO ----
means <- USRvar$q.in
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.in <- meansMatrix
save(q.in, file="qin.Rdata")
rm(q.in)

# EC at ARKCATCO ----
means <- USRvar$ec.in
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
ec.in <- meansMatrix
save(ec.in, file="ecin.Rdata")
rm(ec.in)

# T at ARKCATCO ----
means <- USRvar$t.in
meansMin <- 0
meansMax <- 43
meansMatrix <- means[means >= meansMin && means <= meansMax]
t.in <- meansMatrix
save(t.in, file="tin.Rdata")
rm(t.in)

# Q Holbrook Canal (HOLCANCO) ----
means <- USRvar$q.HOL
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.HOL <- meansMatrix
save(q.HOL, file="qHOL.Rdata")
rm(q.HOL)

# Q Rocky Ford Canal (RFDMANCO) ----
means <- USRvar$q.RFD
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.RFD <- meansMatrix
save(q.RFD, file="qRFD.Rdata")
rm(q.RFD)

# Q Fort Lyon Storage Canal (FLSCANCO) ----
means <- USRvar$q.FLS
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.FLS <- meansMatrix
save(q.FLS, file="qFLS.Rdata")
rm(q.FLS)

# Q Rocky Ford Return Canal (RFDRETCO) ----
means <- USRvar$q.RFR
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.RFR <- meansMatrix
save(q.RFR, file="qRFR.Rdata")
rm(q.RFR)

# Q Timpas Creek (TIMSWICO) ----
means <- USRvar$q.TIM
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.TIM <- meansMatrix
save(q.TIM, file="qTIM.Rdata")
rm(q.TIM)

# Q Fort Lyon Canal (FLYCANCO) ----
means <- USRvar$q.FLY
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.FLY <- meansMatrix
save(q.FLY, file="qFLY.Rdata")
rm(q.FLY)

# Q Crooked Arroyo (CANSWKCO) ----
means <- USRvar$q.CAN
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.CAN <- meansMatrix
save(q.CAN, file="qCAN.Rdata")
rm(q.CAN)

# Q Consolidated Ditch (CONDITCO) ----
means <- USRvar$q.CON
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.CON <- meansMatrix
save(q.CON, file="qCON.Rdata")
rm(q.CON)

# Q Horse Creek @ CO-194 (HRC194CO) ----
means <- USRvar$q.HRC
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.HRC <- meansMatrix
save(q.HRC, file="qHRC.Rdata")
rm(q.HRC)

# Q LaJunta WTP & WWTP (No USGS or CDWR gauge) ----
means <- USRvar$q.WTP
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.WTP <- meansMatrix
save(q.WTP, file="qWTP.Rdata")
rm(q.WTP)

# Q at DS end (ARKLASCO) ----
means <- USRvar$q.out
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.out <- meansMatrix
save(q.out, file="qout.Rdata")
rm(q.out)

# EC at DS end (ARKLASCO) ----
means <- USRvar$ec.out
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
ec.out <- meansMatrix
save(ec.out, file="ecout.Rdata")
rm(ec.out)

# T at DS end (ARKLASCO) ----
means <- USRvar$t.out
meansMin <- 0
meansMax <- 43
meansMatrix <- means[means >= meansMin && means <= meansMax]
t.out <- meansMatrix
save(t.out, file="tout.Rdata")
rm(t.out)

# P ----
means <- USRvar$p
meansMin <- 0
meansMax <- 0.1379
meansMatrix <- means[means >= meansMin && means <= meansMax]
p <- meansMatrix
save(p, file="p.Rdata")
rm(p)

# ETref ----
# Data error distribution from Dr. Jose Chavez
means <- USRvar$et + 0.00047
meansMin <- 0
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
et <- meansMatrix
save(et, file="et.Rdata")
rm(et)

# Wind Speed ----
means <- USRvar$u2
meansMin <- 0
meansMax <- 10
meansMatrix <- means[means >= meansMin && means <= meansMax]
u2 <- meansMatrix
save(u2, file="u2.Rdata")
rm(u2)

# Relative Humidity (min) ----
means <- USRvar$RHmin
meansMin <- 0
meansMax <- 100
meansMatrix <- means[means >= meansMin && means <= meansMax]
RHmin <- meansMatrix
save(RHmin, file="RHmin.Rdata")
rm(RHmin)

rm(list=ls())
