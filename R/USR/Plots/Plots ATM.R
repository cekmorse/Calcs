##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")
source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/polylims.R")

setwd(modelsFile)  # Set working directory

load(file="A evap.Rdata")
load(file="p.Rdata")
load(file="date.Rdata")

Evap <- Evap*1000 # convert from m to mm
p <- p*1000

statsEvap <- data.frame(dates,
                        rowMeans(Evap, na.rm=TRUE),
                        apply(Evap, 1, sd, na.rm=TRUE),
                        apply(Evap, 1, skewness, na.rm=TRUE),
                        apply(Evap, 1, kurtosis, na.rm=TRUE),
                        apply(Evap, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        apply(Evap, 1, quantile, probs=c(0.975), na.rm=TRUE))
statsP <- data.frame(dates,
                        rowMeans(p, na.rm=TRUE),
                        apply(p, 1, sd, na.rm=TRUE),
                        apply(p, 1, skewness, na.rm=TRUE),
                        apply(p, 1, kurtosis, na.rm=TRUE),
                        apply(p, 1, quantile, probs=c(0.025), na.rm=TRUE),
                        apply(p, 1, quantile, probs=c(0.975), na.rm=TRUE))
colnames(statsEvap) <- c("Date","Mean", "StdDev","Skew","Kurt","P.025","P.975")
colnames(statsP) <- c("Date","Mean", "StdDev","Skew","Kurt","P.025","P.975")

save(statsEvap, file="A stats Evap.Rdata")
save(statsP, file="A stats Precip.Rdata")

setwd(plotFile)
pdf(file="A Evap.pdf", width=6, height=6, family="Times")
polys <- polylims(statsEvap$Date, statsEvap$P.025, statsEvap$P.975)
ylabel <- "Evaporation (mm)"
ylimit <- c(0,20)
par(mar=c(5.1,4.1,1.1,1.1))
plot(statsEvap$Date, statsEvap$Mean, type="n", ylim=ylimit, xlab="Date", ylab=ylabel)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(statsEvap$Date, statsEvap$Mean, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()

pdf(file="A Precip.pdf", width=6, height=6, family="Times")
polys <- polylims(statsP$Date, statsP$P.025, statsP$P.975)
ylabel <- "Precipitation (mm)"
ylimit <- c(0,50)
par(mar=c(5.1,4.1,1.1,1.1))
plot(statsP$Date, statsP$Mean, type="n", ylim=ylimit, xlab="Date", ylab=ylabel)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(statsP$Date, statsP$Mean, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()

rm(list=ls())
