##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

runCalcs <- function() {
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/InvarCalcReals.R")
}

reals <- 5000
zscore <- 3.9 ## assuming 99.99% of the variance is within the cited range.

# Read in the data -----
setwd(dataFile)
USRvar <- read.csv("Data.csv", header=TRUE)
dates <- as.Date(USRvar$DATE, "%m/%d/%Y")
times <- length(dates)
setwd(modelsFile)
save(dates, file="date.Rdata")

# Q at ARKCATCO ----
percent <- 10 / 100
means <- USRvar$q.in
type <- "a"
runCalcs()
q.in <- meansMatrix
save(q.in, file="qin.Rdata")
rm(q.in)
print("done q.in");flush.console()

# EC at ARKCATCO ----
percent <- 10 / 100
means <- USRvar$ec.in
type <- "a"
runCalcs()
ec.in <- meansMatrix
save(ec.in, file="ecin.Rdata")
rm(ec.in)
print("done ec.in");flush.console()

# T at ARKCATCO ----
difference <- 0.5
means <- USRvar$t.in
meansMin <- 0
meansMax <- 43
type <- "b"
runCalcs()
t.in <- meansMatrix
save(t.in, file="tin.Rdata")
rm(t.in)
print("done t.in");flush.console()

# Q Holbrook Canal (HOLCANCO) ----
percent <- 20 / 100
means <- USRvar$q.HOL
type <- "a"
runCalcs()
q.HOL <- meansMatrix
save(q.HOL, file="qHOL.Rdata")
rm(q.HOL)
print("done q.HOL");flush.console()

# Q Rocky Ford Canal (RFDMANCO) ----
percent <- 20 / 100
means <- USRvar$q.RFD
type <- "a"
runCalcs()
q.RFD <- meansMatrix
save(q.RFD, file="qRFD.Rdata")
rm(q.RFD)
print("done q.RFD");flush.console()

# Q Fort Lyon Storage Canal (FLSCANCO) ----
percent <- 20 / 100
means <- USRvar$q.FLS
type <- "a"
runCalcs()
q.FLS <- meansMatrix
save(q.FLS, file="qFLS.Rdata")
rm(q.FLS)
print("done q.FLS");flush.console()

# Q Rocky Ford Return Canal (RFDRETCO) ----
percent <- 20 / 100
means <- USRvar$q.RFR
type <- "a"
runCalcs()
q.RFR <- meansMatrix
save(q.RFR, file="qRFR.Rdata")
rm(q.RFR)
print("done q.RFR");flush.console()

# Q Timpas Creek (TIMSWICO) ----
percent <- 15 / 100
means <- USRvar$q.TIM
type <- "a"
runCalcs()
q.TIM <- meansMatrix
save(q.TIM, file="qTIM.Rdata")
rm(q.TIM)
print("done q.TIM");flush.console()

# Q Fort Lyon Canal (FLYCANCO) ----
percent <- 20 / 100
means <- USRvar$q.FLY
type <- "a"
runCalcs()
q.FLY <- meansMatrix
save(q.FLY, file="qFLY.Rdata")
rm(q.FLY)
print("done q.FLY");flush.console()

# Q Crooked Arroyo (CANSWKCO) ----
percent <- 15 / 100
means <- USRvar$q.CAN
type <- "a"
runCalcs()
q.CAN <- meansMatrix
save(q.CAN, file="qCAN.Rdata")
rm(q.CAN)
print("done q.CAN");flush.console()

# Q Consolidated Ditch (CONDITCO) ----
percent <- 20 / 100
means <- USRvar$q.CON
type <- "a"
runCalcs()
q.CON <- meansMatrix
save(q.CON, file="qCON.Rdata")
rm(q.CON)
print("done q.CON");flush.console()

# Q Horse Creek @ CO-194 (HRC194CO) ----
percent <- 20 / 100
means <- USRvar$q.HRC
type <- "a"
runCalcs()
q.HRC <- meansMatrix
save(q.HRC, file="qHRC.Rdata")
rm(q.HRC)
print("done q.HRC");flush.console()

# Q LaJunta WTP & WWTP (No USGS or CDWR gauge) ----
percent <- 15 / 100
means <- USRvar$q.WTP
type <- "a"
runCalcs()
q.WTP <- meansMatrix
save(q.WTP, file="qWTP.Rdata")
rm(q.WTP)
print("done q.WTP");flush.console()

# Q at DS end (ARKLASCO) ----
percent <- 15 / 100
means <- USRvar$q.out
type <- "a"
runCalcs()
q.out <- meansMatrix
save(q.out, file="qout.Rdata")
rm(q.out)
print("done q.out");flush.console()

# EC at DS end (ARKLASCO) ----
percent <- 10 / 100
means <- USRvar$ec.out
type <- "a"
runCalcs()
ec.out <- meansMatrix
save(ec.out, file="ecout.Rdata")
rm(ec.out)
print("done ec.out");flush.console()

# T at DS end (ARKLASCO) ----
difference <- 0.5
means <- USRvar$t.out
type <- "a"
meansMin <- 0
meansMax <- 43
runCalcs()
t.out <- meansMatrix
save(t.out, file="tout.Rdata")
rm(t.out)
print("done t.out");flush.console()

# ETref ----
# Data error distribution from Dr. Jose Chavez
difference <- 0.00098
means <- USRvar$et + 0.00047
type <- "b"
meansMin <- 0
meansMax <- max(means, na.rm=TRUE)*1.5
runCalcs()
et <- meansMatrix
save(et, file="et.Rdata")
rm(et)
print("done et");flush.console()

# P ----
percent <- 1 / 100
means <- USRvar$p
type <- "a"
runCalcs()
p <- meansMatrix
save(p, file="p.Rdata")
rm(p)
print("done p");flush.console()

# Wind Speed ----
difference <- 0.5
means <- USRvar$u2
type <- "b"
meansMin <- 0
meansMax <- 10
runCalcs()
u2 <- meansMatrix
save(u2, file="u2.Rdata")
rm(u2)
print("done wind speed");flush.console()

# Relative Humidity (min) ----
difference <- 2
means <- USRvar$RHmin
type <- "b"
meansMin <- 0
meansMax <- 100
runCalcs()
RHmin <- meansMatrix
save(RHmin, file="RHmin.Rdata")
rm(RHmin)
print("done RHmin");flush.console()

rm(list=ls())