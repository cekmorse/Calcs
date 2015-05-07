##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

# Read in the data -----
setwd(dataFile)
DSRvar <- read.csv("Data.csv", header=TRUE)

times <- length(dates)

setwd(models.D)
save(dates, file="date.Rdata")

# Q at ARKLAMO ----
means <- DSRvar$q.in
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.in <- meansMatrix
save(q.in, file="qin.Rdata")
rm(q.in)

# EC at ARKJMRCO ----
means <- DSRvar$ec.in
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
ec.in <- meansMatrix
save(ec.in, file="ecin.Rdata")
rm(ec.in)

# T at ARKJMRCO ----
means <- DSRvar$t.in
meansMin <- 0
meansMax <- 43
meansMatrix <- means[means >= meansMin && means <= meansMax]
t.in <- meansMatrix
save(t.in, file="tin.Rdata")
rm(t.in)

# Q Big Sandy Creek (BIGLAMCO) ----
means <- DSRvar$q.BIG
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.BIG <- meansMatrix
save(q.BIG, file="qBIG.Rdata")
rm(q.BIG)

# Q Wild Horse Creek (WILDHOCO) ----
means <- DSRvar$q.WIL
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.WIL <- meansMatrix
save(q.WIL, file="qWIL.Rdata")
rm(q.WIL)

# Q Buffalo Ditch (BUFDITCO) ----
means <- DSRvar$q.BUF
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.BUF <- meansMatrix
save(q.BUF, file="qBUF.Rdata")
rm(q.BUF)

# Q Frontier Ditch (FRODITKS) ----
means <- DSRvar$q.FRO
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.FRO <- meansMatrix
save(q.FRO, file="qFRO.Rdata")
rm(q.FRO)

# Q at DS end (ARKCOOKS) ----
means <- DSRvar$q.out
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
q.out <- meansMatrix
save(q.out, file="qout.Rdata")
rm(q.out)

# EC at DS end (ARKCOOKS) ----
means <- DSRvar$ec.out
meansMin <- min(means, na.rm=TRUE)/2
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
ec.out <- meansMatrix
save(ec.out, file="ecout.Rdata")
rm(ec.out)

# T at DS end (ARKCOOKS) ----
means <- DSRvar$t.out
meansMin <- 0
meansMax <- 43
meansMatrix <- means[means >= meansMin && means <= meansMax]
t.out <- meansMatrix
save(t.out, file="tout.Rdata")
rm(t.out)

# ET ----
means <- DSRvar$et + .00047
meansMin <- 0
meansMax <- max(means, na.rm=TRUE)*1.5
meansMatrix <- means[means >= meansMin && means <= meansMax]
et <- meansMatrix
save(et, file="et.Rdata")
rm(et)

# P ----
means <- DSRvar$p
meansMin <- 0
meansMax <- 0.1379
meansMatrix <- means[means >= meansMin && means <= meansMax]
p <- meansMatrix
save(p, file="p.Rdata")
rm(p)

# Wind Speed ----
means <- DSRvar$u2
meansMin <- 0
meansMax <- 10
meansMatrix <- means[means >= meansMin && means <= meansMax]
u2 <- meansMatrix
save(u2, file="u2.Rdata")
rm(u2)

# Relative Humidity (min) ----
means <- DSRvar$RHmin
meansMin <- 0
meansMax <- 10
meansMatrix <- means[means >= meansMin && means <= meansMax]
RHmin <- meansMatrix
save(RHmin, file="RHmin.Rdata")

rm(list=ls())
