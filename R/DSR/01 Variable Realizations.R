##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

runCalcs <- function() {
  source("~/Projects/Calcs/R/SubScripts/InvarCalcReals.R")
}

reals <- 5000
zscore <- 3.9 ## assuming 99.99% of the variance is within the cited range.

# Read in the data -----
setwd(dataFile)
DSRvar <- read.csv("Data.csv", header=TRUE)
dates <- as.Date(DSRvar$DATE, "%m/%d/%Y")
times <- length(dates)
save(dates, file="date.Rdata")

setwd(modelsFile)
# Q at ARKLAMO ----
percent <- 15 / 100
means <- DSRvar$q.in
type <- "a"
runCalcs()
q.in <- meansMatrix
save(q.in, file="qin.Rdata")
rm(q.in)
print("done q.in");flush.console()

# EC at ARKJMRCO ----
percent <- 20 / 100
means <- DSRvar$ec.in
type <- "a"
runCalcs()
ec.in <- meansMatrix
save(ec.in, file="ecin.Rdata")
rm(ec.in)
print("done ec.in");flush.console()

# T at ARKJMRCO ----
difference <- 0.8
means <- DSRvar$t.in
type <- "b"
meansMin <- 0
meansMax <- 43
runCalcs()
t.in <- meansMatrix
save(t.in, file="tin.Rdata")
rm(t.in)
print("done t.in");flush.console()

# Q Big Sandy Creek (BIGLAMCO) ----
percent <- 20 / 100
means <- DSRvar$q.BIG
type <- "a"
runCalcs()
q.BIG <- meansMatrix
save(q.BIG, file="qBIG.Rdata")
rm(q.BIG)
print("done q.BIG");flush.console()

# Q Wild Horse Creek (WILDHOCO) ----
percent <- 15 / 100
means <- DSRvar$q.WIL
type <- "a"
runCalcs()
q.WIL <- meansMatrix
save(q.WIL, file="qWIL.Rdata")
rm(q.WIL)
print("done q.WIL");flush.console()

# Q Buffalo Ditch (BUFDITCO) ----
percent <- 20 / 100
means <- DSRvar$q.BUF
type <- "a"
runCalcs()
q.BUF <- meansMatrix
save(q.BUF, file="qBUF.Rdata")
rm(q.BUF)
print("done q.BUF");flush.console()

# Q Frontier Ditch (FRODITKS) ----
percent <- 20 / 100
means <- DSRvar$q.FRO
type <- "a"
runCalcs()
q.FRO <- meansMatrix
save(q.FRO, file="qFRO.Rdata")
rm(q.FRO)
print("done q.FRO");flush.console()

# Q at DS end (ARKCOOKS) ----
percent <- 15 / 100
means <- DSRvar$q.out
type <- "a"
runCalcs()
q.out <- meansMatrix
save(q.out, file="qout.Rdata")
rm(q.out)
print("done q.out");flush.console()

# EC at DS end (ARKCOOKS) ----
percent <- 10 / 100
means <- DSRvar$ec.out
type <- "a"
runCalcs()
ec.out <- meansMatrix
save(ec.out, file="ecout.Rdata")
rm(ec.out)
print("done ec.out");flush.console()

# T at DS end (ARKCOOKS) ----
difference <- 0.5
means <- DSRvar$t.out
meansMin <- 0
meansMax <- 43
type <- "b"
runCalcs()
t.out <- meansMatrix
save(t.out, file="tout.Rdata")
rm(t.out)
print("done t.out");flush.console()

# ET ----
difference <- 0.00098
means <- DSRvar$et + 0.00047
meansMin <- 0
meansMax <- max(means, na.rm=TRUE)*1.5
type <- "b"
runCalcs()
et <- meansMatrix
save(et, file="et.Rdata")
rm(et)
print("done et");flush.console()

# P ----
percent <- 1 / 100
means <- DSRvar$p
type <- "a"
runCalcs()
p <- meansMatrix
save(p, file="p.Rdata")
rm(p)
print("done p");flush.console()

# Wind Speed ----
difference <- 0.5
means <- DSRvar$u2
meansMin <- 0
meansMax <- 10
type <- "b"
runCalcs()
u2 <- meansMatrix
save(u2, file="u2.Rdata")
rm(u2)
print("done wind speed");flush.console()

# Relative Humidity (min) ----
difference <- 2
means <- DSRvar$RHmin
meansMin <- 0
meansMax <- 100
type <- "b"
runCalcs()
RHmin <- meansMatrix
save(RHmin, file="RHmin.Rdata")
rm(RHmin)
print("done RHmin");flush.console()

rm(list=ls())
