##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)  # Set working directory

load(file="A evap.Rdata")
load(file="p.Rdata")
load(file="date.Rdata")

Evap <- Evap*1000 # convert from m to mm
p <- p*1000

evapStats <- changeStats(dates, Evap)
evapStatsStats <- changeStatsStats(evapStats[,-1])

pStats <- changeStats(dates, p)
pStatsStats <- changeStatsStats(pStats[,-1])

save(evapStats, file="A Evap Stats.Rdata")
save(pStats, file="A Precip Stats.Rdata")

setwd(resultsFile)
write.csv(evapStatsStats, file="A Evap Stats Stats.Rdata")
write.csv(pStatsStats, file="A Precip Stats Stats.Rdata")

setwd(plotFile)
pdf(file="A Evap.pdf", width=6, height=6, family="Times")
polys <- polylims(dates, evapStats$P.025, evapStats$P.975)
ylabel <- "Evaporation (mm)"
ylimit <- c(0,20)
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, evapStats$Mean, type="n", ylim=ylimit, xlab="Date", ylab=ylabel)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(dates, evapStats$Mean, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()

pdf(file="A Precip.pdf", width=6, height=6, family="Times")
polys <- polylims(dates, pStats$P.025, pStats$P.975)
ylabel <- "Precipitation (mm)"
ylimit <- c(0,50)
par(mar=c(5.1,4.1,1.1,1.1))
plot(dates, pStats$Mean, type="n", ylim=ylimit, xlab="Date", ylab=ylabel)
for(i in 1:length(polys)){polygon(polys[[i]]$x, polys[[i]]$y, col = rgb(0,0,1,0.25), border = rgb(0,0,1,0.25))}
lines(dates, pStats$Mean, lwd=1, col="black")
abline(h=0, lty=2)
dev.off()

rm(list=ls())
