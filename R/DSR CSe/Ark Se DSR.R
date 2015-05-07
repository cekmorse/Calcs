region <- "DSR"
source("~/Projects/Thesis/Thesis-Calcs/R/DSR CSe/Pre-Loader.R")

###  READ AND EDIT DATA  ###
setwd(dataFile)
db <- read.csv("DSR ARK R.csv")
db <- db[, c("point","cse","q.in","ec.in","t.in","q.out","ec.out","t.out","di")]
db$ec.out[which(db$ec.out==-999)]=NA
db$ec.in <- db$ec.in/1000  ## CHANGE UNITS FROM uS/cm to mS/dm  ##
db$ec.out <- db$ec.out/1000

### labels for scatterplot matrix diagonal
pair.lab.full <- c(expression(Q[ARKLAMCO]), expression(EC[ARKJMRCO]), expression(t[ARKJMRCO]), expression(Q[ARKCOOKS]), expression(EC[ARKCOOKS]), expression(t[ARKCOOKS]), expression(d[i]))
pair.lab.se <- c(expression(C["Se,D101"]), expression(C["Se,D106"]), expression(C["Se,Diversions"]))
pair.lab.trib <- c(expression(C["Se,BIGLAMCO"]), expression(C["Se,WILDHOCO"]))

#####  DSR INLET  #####
#  Subset data
ttl <- "D101C"
tt2 <- "aD101"
y <- db[db$point=="D101C",]
y <- y[, c(-1,-9)]

#  Trial linear regressions
setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ ec.in + q.in + t.in, data=y, na.action=na.exclude))
nas <- lm(cse ~ ec.in + q.in + t.in, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ ec.in + q.in + t.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ q.in + t.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 3\n")
summary(lm(cse ~ (ec.in + t.in + q.in) * (ec.in + t.in + q.in), data=y[-nas,], na.action=na.exclude))
step(lm(cse ~ (ec.in + t.in + q.in) * (ec.in + t.in + q.in), data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 4\n")
summary(lm(cse ~ ec.in + t.in + q.in + ec.in:t.in + ec.in:q.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 5\n")
summary(lm(cse ~ ec.in + t.in + ec.in:t.in + ec.in:q.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 6\n")
summary(lm(cse ~ ec.in + ec.in:t.in + ec.in:q.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 7\n")
summary(lm(cse ~ ec.in + ec.in:q.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 8\n")
summary(lm(cse ~ ec.in, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Tests\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

#  Final linear regression model
aD101 <- lm.x <- lm(cse ~ ec.in + ec.in:t.in + ec.in:q.in, data=y[-nas], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aD101, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aD101, y$cse, fileName)  # Statistics of measured, fitted, and residuals

#  Plot figures
setwd(plotFile)
y.sub <- y[,c("cse","q.in","ec.in","t.in")]  # subset of y for plotting scatterplot matrix
pair.lab <- c(pair.lab.trib[1], pair.lab.full[c(1:6)])
pair.lab.sub <- c(pair.lab.se[1], pair.lab.full[c(1:3)])  # subset of labels for scatterplot matrix diagonal
plot.script()
rm(aD101)


#####  DSR OUTLET  #####
#  Subset data
ttl <- "D106C"
tt2 <- "aD106"
y <- db[db$point=="D106C",]
y <- y[, c(-1,-9)]
#  Trial linear regressions
setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ ec.out + q.out + t.out, data=y, na.action=na.exclude))
nas <- lm(cse ~ ec.out + q.out + t.out, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ ec.out + q.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 3\n")
summary(lm(cse ~ t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 4\n")
summary(lm(cse ~ (ec.out + q.out + t.out)*(ec.out + q.out + t.out), data=y, na.action=na.exclude))
nas <- lm(cse ~ (ec.out + q.out + t.out)*(ec.out + q.out + t.out), data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ (ec.out + q.out + t.out)*(ec.out + q.out + t.out), data=y, na.action=na.exclude))
cat("\n\nTest 5\n")
summary(lm(cse ~ ec.out + t.out + ec.out:q.out + ec.out:t.out + q.out:t.out, data=y, na.action=na.exclude))
cat("\n\nTest 6\n")
summary(lm(cse ~ ec.out + t.out + ec.out:t.out + q.out:t.out, data=y, na.action=na.exclude))
cat("\n\nTest 7\n")
summary(lm(cse ~ t.out + ec.out:t.out + q.out:t.out, data=y, na.action=na.exclude))
cat("\n\nTest 8\n")
summary(lm(cse ~ t.out + ec.out:t.out, data=y, na.action=na.exclude))
cat("\n\nTest 9\n")
summary(lm(cse ~ t.out, data=y, na.action=na.exclude))
cat("\n\nTest 10\n")
summary(lm(cse ~ ec.out + t.out + ec.out:t.out, data=y, na.action=na.exclude))
cat("\n\nTest 11\n")
summary(lm(cse ~ t.out, data=y, na.action=na.exclude))
cat("\n\nEnd of Tests\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

#  Final linear regression model
aD106 <- lm(cse ~ t.out + ec.out:t.out, data=y, na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aD106, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aD106, y$cse, fileName)  # Statistics of measured, fitted, and residuals

#  Plot figures
setwd(plotFile)
y.sub <- y[,c("cse","ec.out","t.out")]  # subset of y for plotting scatterplot matrix
pair.lab <- c(pair.lab.trib[1], pair.lab.full[c(1:6)])
pair.lab.sub <- c(pair.lab.se[2], pair.lab.full[c(5:6)])  # subset of labels for scatterplot matrix diagonal
plot.script()
rm(aD106)


#####  DSR DIVERSIONS  #####
#  Subset data
ttl <- "DDIV"
tt2 <- "aDDIV"
y <- db[db$point!="D101C",]
y <- y[y$point!="D106C",]
y <- y[, c(-1)]

#  Trial linear regressions
setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + di, data=y, na.action=na.exclude))
nas <- lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + di, data=y, na.action=na.exclude)$na.action[]
summary(lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + di, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ (ec.in + q.in + ec.out + q.out + t.out + di) * (ec.in + q.in + ec.out + q.out + t.out + di), data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 3\n")
summary(lm(cse ~ (ec.in + q.in + ec.out + q.out + t.out + di) * (ec.in + q.in + ec.out + q.out + t.out + di), data=y[-nas,], na.action=na.exclude))
step(lm(cse ~ (ec.in + q.in + ec.out + q.out + t.out + di) * (ec.in + q.in + ec.out + q.out + t.out + di), data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 4\n")
summary(lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + di + ec.in:ec.out + ec.in:q.out + ec.in:di + q.in:ec.out + q.in:q.out + q.in:t.out + ec.out:q.out + ec.out:t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 5\n")
summary(lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + ec.in:ec.out + ec.in:q.out + ec.in:di + q.in:ec.out + q.in:q.out + q.in:t.out + ec.out:q.out + ec.out:t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 6\n")
summary(lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + ec.in:ec.out + ec.in:q.out + ec.in:di + q.in:q.out + q.in:t.out + ec.out:q.out + ec.out:t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Tests\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

#  Final linear regression model
aDDIV <- lm(cse ~ ec.in + q.in + ec.out + q.out + t.out + ec.in:ec.out + ec.in:q.out + ec.in:di + q.in:q.out + q.in:t.out + ec.out:q.out + ec.out:t.out, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aDDIV, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aDDIV, y$cse, fileName)  # Statistics of measured, fitted, and residuals

#  Plot figures
setwd(plotFile)
y.sub <- y[,c("cse", "q.in", "ec.in", "q.out", "ec.out", "t.out", "di")]  # subset of y for plotting scatterplot matrix
attach(y.sub)
y.sub <- cbind(y.sub, ec.in*ec.out, ec.in*q.out, ec.in*di, q.in*q.out, q.in*t.out, ec.out*q.out, ec.out*t.out)
y.sub <- y.sub[,-y.sub$di]
colnames(y.sub)[7:13] <- c("ec.in*ec.out", "ec.in*q.out", "ec.in*di", "q.in*q.out", "q.in*t.out", "ec.out*q.out", "ec.out*t.out")
detach(y.sub)

pair.lab <- c(pair.lab.trib[1], pair.lab.full[c(1:7)])
pair.lab.sub <- c(pair.lab.se[3], 
                  pair.lab.full[c(1,2,4:6)], 
                  expression(atop(EC[ARKJMRCO],EC[ARKCOOKS])),
                  expression(atop(EC[ARKJMRCO],Q[ARKCOOKS])),
                  expression(atop(EC[ARKJMRCO],d[i])), 
                  expression(atop(Q[ARKLAMCO],Q[ARKCOOKS])), 
                  expression(atop(Q[ARKLAMCO],T[ARKCOOKS])), 
                  expression(atop(EC[ARKCOOKS],Q[ARKCOOKS])), 
                  expression(atop(EC[ARKCOOKS],T[ARKCOOKS])))  # subset of labels for scatterplot matrix diagonal

plot.script()
rm(aDDIV)

#Tributries
####  BIGLAMCO  ####
ttl <- "BIGLAMCO"
tt2 <- "aDBIG"
setwd(dataFile)
y <- read.csv("BIGLAMCO.csv")
y <- y[,c(-1)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y, na.action=na.exclude))
nas <- lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 2\n")
summary(lm(cse ~ q.out + q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 3\n")
summary(lm(cse ~ q.x, data=y[-nas,], na.action=na.exclude))
cat("\n Poor R-squared.  Try a different starting model.\n")
cat("\n\n Test 4\n")
summary(lm(cse ~ (q.in + ec.in + t.in + q.out + ec.out + t.out) * q.x, data=y[-nas,], na.action=na.exclude))
step(lm(cse ~ (q.in + ec.in + t.in + q.out + ec.out + t.out) * q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 5\n")
summary(lm(cse ~ q.in + t.in + q.out + t.out + q.x + q.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 6\n")
summary(lm(cse ~ q.in + t.in + q.out + q.x + q.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 7\n")
summary(lm(cse ~ q.in + q.out + q.x + q.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aDBIG <- lm.x <- lm(cse ~ q.in + q.out + q.x + q.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aDBIG, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aDBIG, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c("cse", "q.in", "q.out", "q.x")]
y.sub <- cbind(y.sub, y$q.in*y$q.x, y$q.out*y$q.x)
colnames(y.sub)[5:6] <- c("q.in*q.x", "q.out*q.x")
pair.lab <- c(pair.lab.trib[1], pair.lab.full[c(1:6)], expression(Q[BIGLAMCO]))
pair.lab.sub <- c(pair.lab.trib[1], pair.lab.full[c(1,4)], 
              expression(Q[BIGLAMCO]), 
              expression(atop(Q[ARKLAMCO],Q[BIGLAMCO])), 
              expression(atop(Q[ARKCOOKS],Q[BIGLAMCO])))
plot.script()
rm(aDBIG)



####  WILDHOCO  ####
ttl <- "WILDHOCO"
tt2 <- "aDWIL"
setwd(dataFile)
y <- read.csv("WILDHOCO.csv")
y <- y[,c(-1)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y, na.action=na.exclude))
nas <- lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 2\n")
summary(lm(cse ~ (q.in + ec.in + t.in + q.out + ec.out + t.out + q.x) * q.x, data=y[-nas,], na.action=na.exclude))
step(lm(cse ~ (q.in + ec.in + t.in + q.out + ec.out + t.out + q.x) * q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 3\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + q.x + q.in:q.x + ec.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 4\n")
summary(lm(cse ~ q.in + t.in + q.out + q.x + q.in:q.x + ec.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 5\n")
summary(lm(cse ~ t.in + q.out + q.x + q.in:q.x + ec.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 6\n")
summary(lm(cse ~ t.in + q.out + q.in:q.x + ec.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 7\n")
summary(lm(cse ~ t.in + q.out + ec.in:q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 8\n")
summary(lm(cse ~ t.in + q.out + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 9\n")
summary(lm(cse ~ t.in + q.out, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 10\n")
summary(lm(cse ~ t.in, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 11\n")
summary(lm(cse ~ t.in + q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aDWIL <- lm.x <- lm(cse ~ t.in + q.x, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aDWIL, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aDWIL, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c("cse", "t.in", "q.x")]
pair.lab <- c(pair.lab.trib[2], pair.lab.full[c(1:6)], expression(Q[WILDHOCO]))
pair.lab.sub <- c(pair.lab.trib[2], pair.lab.full[c(3)], 
                  expression(Q[WILDHOCO]))
plot.script()

rm(list=ls())