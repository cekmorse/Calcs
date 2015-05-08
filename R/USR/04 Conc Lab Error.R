##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

setwd(dataFile)
db <- read.csv("SeErrorData.csv")
setwd(modelsFile)

sem <- data.frame(sem=(db$sea+db$seb)/2)
difa <- data.frame(se=sem, dif=sem-db$sea)
difb <- data.frame(se=sem, dif=sem-db$seb)
dif <- rbind(difa,difb)
sem <- rbind(sem,sem)
pdb <- data.frame(sem=sem, pdif=dif[,2]/sem*100)
ds <- data.frame(sem=sem,dif=dif[,2],pdif=pdb[,2])

lm1 <- list(fitdist(ds$dif, "norm", "mle"),
            fitdist(ds$dif, "logis", "mle"))
lm2 <- list(fitdist(ds$pdif, "norm", "mle"),
            fitdist(ds$pdif, "logis", "mle"))

gof1 <- gofstat(lm1)
gof2 <- gofstat(lm2)

setwd(plotFile)
pdf(file="CSe Error Scatter.pdf", width=6, height=6, family="Times")
par(mfrow=c(2,1))
par(mar=c(5.1,4.1,1.1,1.1))
xlabel <- expression(C[Se]~(mu*g %.% L^{-1}))
ylabel <- expression(Difference~(mu*g %.% L^{-1}))
plot(ds$sem, ds$dif, pch=20, xlab=xlabel, ylab=ylabel)
ylabel <- expression(Percent~Difference~(mu*g %.% L^{-1}))
plot(ds$sem, ds$pdif, pch=20, xlab=xlabel, ylab=ylabel)
dev.off()

setwd(plotFile)
pdf(file="CSe Error.pdf", width=6, height=6, family="Times")
par(mfrow=c(2,1))
x <- as.numeric(ds$dif)
rng <- seq(-10,10,0.01)
xlabel <- "Difference"
dn <- lm1[[1]]$est
dl <- lm1[[2]]$est
rn <- dnorm(rng, mean=dn[[1]], sd=dn[[2]])
rl <- dlogis(rng, location=dl[[1]], scale=dl[[2]])
ylimit <- c(0, 4)
xlimit <- c(-2,2)
par(mar=c(5.1,4.1,1.1,1.1))
hist(x, freq=F, xlim=xlimit, ylim=ylimit, main="", xlab=xlabel)
rug(x)
lines(density(x, bw="SJ"), lwd=2, lty=2)
lines(rng, rn, lwd=2, col="red")
lines(rng, rl, lwd=2, col="blue")
legend("topleft", legend=c("Kernel Density", "Normal", "Logistic"), col=c("black","red","blue"), lwd=c(2,2,2), lty=c(2,1,1))
# dev.off()

x <- as.numeric(ds$pdif)
xlabel <- "Percent Difference"
dn <- lm2[[1]]$est
dl <- lm2[[2]]$est
rn <- dnorm(rng, mean=mean(x), sd=sd(x))
rl <- dlogis(rng, location=dl[[1]], scale=dl[[2]])
ylimit <- c(0, 0.5)
xlimit <- c(-10,10)
par(mar=c(5.1,4.1,1.1,1.1))
hist(x, freq=F, xlim=xlimit, ylim=ylimit, main="", xlab=xlabel)
rug(x)
lines(density(x, bw="SJ"), lwd=2, lty=2)
lines(rng, rn, lwd=2, col="red")
lines(rng, rl, lwd=2, col="blue")
dev.off()

setwd(resultsFile)
zz <- textConnection("foo", open="w")
sink(zz)
cat("CSe Error Analysis\n\n")
cat("Difference Model (DSe-Se)\n\n")
print(gof1)
cat("\n\nPercent Difference Model ((DSe-Se)/Se)\n\n")
print(gof2)
sink()
close(zz)
write(foo, file=paste("CSe error analysis.txt",sep=""))

setwd(modelsFile)
bSe <- lm2[[2]]
save(bSe, file="bSe.Rdata")

rm(list=ls())
