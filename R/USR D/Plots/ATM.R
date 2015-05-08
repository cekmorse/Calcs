##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

setwd(models.D)
load(file="A evap.Rdata")
load(file="p.Rdata")
load(file="date.Rdata")

Evap <- Evap*1000 # convert from m to mm
p <- p*1000

statsEvap <- data.frame(mean(Evap, na.rm=TRUE),
                        sd(Evap, na.rm=TRUE),
                        skewness(Evap, na.rm=TRUE),
                        kurtosis(Evap, na.rm=TRUE),
                        quantile(Evap, probs=c(0.025), na.rm=TRUE),
                        quantile(Evap, probs=c(0.975), na.rm=TRUE))

statsP <- data.frame(mean(p, na.rm=TRUE),
                     sd(p, na.rm=TRUE),
                     skewness(p, na.rm=TRUE),
                     kurtosis(p, na.rm=TRUE),
                     quantile(p, probs=c(0.025), na.rm=TRUE),
                     quantile(p, probs=c(0.975), na.rm=TRUE))
colnames(statsEvap) <- c("Mean", "StdDev","Skew","Kurt","P.025","P.975")
colnames(statsP) <- c("Mean", "StdDev","Skew","Kurt","P.025","P.975")

save(statsEvap, file="A stats Evap.Rdata")
save(statsP, file="A stats Precip.Rdata")

setwd(plot.D)
pdf(file="A Evap.pdf", width=6, height=6, family="Times")
ylabel <- "Evaporation (mm)"
ylimit <- c(0,20)
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, Evap, type="l", ylim=ylimit, xlab="Date", ylab=ylabel)
abline(h=0, lty=2)
dev.off()

pdf(file="A Precip.pdf", width=6, height=6, family="Times")
ylabel <- "Precipitation (mm)"
ylimit <- c(0,50)
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, p, type="l", ylim=ylimit, xlab="Date", ylab=ylabel)
abline(h=0, lty=2)
dev.off()

rm(list=ls())
