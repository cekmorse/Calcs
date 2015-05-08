region <- "USR"
source("~/Projects/Calcs/R/USR CSe/Pre-Loader.R")  

###  READ AND EDIT DATA  ###
setwd(dataFile)
db <- read.csv("ARK.csv")
db$ec.out[which(db$ec.out==-999)]=NA  # change -999 values to NA values
db$ec.in <- db$ec.in/1000  ## change units from uS/cm to mS/dm  ##
db$ec.out <- db$ec.out/1000

### labels for scatterplot matrix diagonal
pair.lab.full <- c(expression(Q[ARKCATCO]), expression(EC[ARKCATCO]), expression(t[ARKCATCO]), expression(Q[ARKLASCO]), expression(EC[ARKLASCO]), expression(t[ARKLASCO]))
pair.lab.se <- c(expression(C["Se,U163"]), expression(C["Se,U201"]), expression(C["Se,U167"]), expression(C["Se,U209"]), expression(C["Se,Diversions"]))
pair.lab.trib <- c(expression(C["Se,CANSWKCO"]), expression(C["Se,TIMSWICO"]), expression(C["Se,HRC194CO"]), expression(C["Se,WWTP"]))

#####  USR INLET  #####
#  Subset data
ttl <- "U163"
tt2 <- "aU163"
y <- db[db$point==ttl,c(-1,-2,-10)]

#  Trial linear regressions
setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y, na.action=na.exclude))
nas <- lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + t.out, data=y, na.action=na.exclude))
cat("\n\nTest 3\n")
summary(lm(cse ~ q.in + ec.in + t.in + t.out, data=y, na.action=na.exclude))
cat("\n\nTest 4\n")
summary(lm(cse ~ q.in + ec.in + t.in, data=y, na.action=na.exclude))
cat("\n\nEnd of Tests\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

#  Final linear regression model
aU163 <- lm.x <- lm(cse ~ q.in + ec.in + t.in, data=y, na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aU163, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aU163, y$cse, fileName)  # Statistics of measured, fitted, and residuals

#  Plot figures
setwd(plotFile)
y.sub <- y[,c(1:4)]  # subset of y for plotting scatterplot matrix
pair.lab <- c(pair.lab.se[1], pair.lab.full[c(1:6)])
pair.lab.sub <- c(pair.lab.se[1], pair.lab.full[c(1:3)])  # subset of labels for scatterplot matrix diagonal
plot.script()
rm(aU163)

#####  USR OUTLET  #####
ttl <- "U201"
tt2 <- "aU201"
y <- db[db$point==ttl,c(-1,-2,-10)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y, na.action=na.exclude))
nas <- lm(cse ~ q.out + ec.out + t.out, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nTest 3\n")
summary(lm(cse ~ q.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aU201 <- lm.x <- lm(cse ~ q.out + t.out, data=y, na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aU201, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aU201, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c(1,5,7)]
pair.lab <- c(pair.lab.se[2], pair.lab.full[c(1:6)])
pair.lab.sub <- c(pair.lab.se[2], pair.lab.full[c(4,6)])
plot.script()
rm(aU201)


#####  U167/RFDMANCO  #####
ttl <- "U167"
tt2 <- "aU167"
y <- db[db$point==ttl,c(-1,-2,-10)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("\n Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y, na.action=na.exclude))
nas <- lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 2\n")
summary(lm(cse ~ t.in + q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 3\n")
summary(lm(cse ~ q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aU167 <- lm.x <- lm(cse ~ q.out + ec.out + t.out, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aU167, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aU167, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c(1,5:7)]
pair.lab <- c(pair.lab.se[3], pair.lab.full[c(1:6)])
pair.lab.sub <- c(pair.lab.se[3], pair.lab.full[c(4:6)])
plot.script()
rm(aU167)

#####  U209/CONDITCO  #####
ttl <- "U209"
tt2 <- "aU209"
y <- db[db$point==ttl,c(-1,-2,-10)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out, data=y, na.action=na.exclude))
cat("\n\n-----------------------------------------------------------\n")
cat("Not enough data points to perform a significant analysis\n")
cat("-----------------------------------------------------------")
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)
#  NO CHOSEN REGRESSION  

#####  USR DIVERSIONS  #####
ttl <- "USR_Diversions"
tt2 <- "aUDIV"
y <- db[db$point!="U163",]
y <- y[y$point!="U201",]
y <- y[y$point!="",]
y <- y[,c(-1,-2)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + di, data=y, na.action=na.exclude))
nas <- lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + di, data=y, na.action=na.exclude)$na.action[]
step(lm(cse ~ q.in + ec.in + q.out + ec.out + t.out + di, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 2\n")
summary(lm(cse ~ ec.in + q.out + t.out + di, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aUDIV <- lm.x <- lm(cse ~ ec.in + q.out + t.out + di, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aUDIV, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aUDIV, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c(1,3,5,7,8)]
pair.lab <- c(pair.lab.se[5], pair.lab.full[c(1:6)], expression(d[i]))
pair.lab.sub <- c(pair.lab.se[5], pair.lab.full[c(2,4,6)], expression(d[i]))
plot.script()
rm(aUDIV, db)

#Tributries
####  CANSWKCO  ####
setwd(dataFile)
db <- read.csv("CANSWKCO.csv")

ttl <- "CANSWKCO"
tt2 <- "aUCAN"

y <- db[,c(-1)]

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
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 3\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 4\n")
summary(lm(cse ~ q.in + ec.in + t.in, data=y[-nas,], na.action=na.exclude))
cat("\n Poor R-squared.  Try a different starting model.\n")
cat("\n\n Test 5\n")
summary(lm(cse ~ (q.in + ec.in + t.in + q.out + ec.out + t.out) * q.x, data=y[-nas,], na.action=na.exclude))
step(lm(cse ~ (q.in + ec.in + t.in + q.out + ec.out + t.out) * q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 6\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\n Test 7\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aUCAN <- lm.x <- lm(cse ~ q.in + ec.in + t.in + q.out + q.x + q.out:q.x, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aUCAN, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aUCAN, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c(1:5,8)]
y.sub <- cbind(y.sub, y$q.out*y$q.x)
colnames(y.sub)[7] <- "q.out:q.x"
pair.lab <- c(pair.lab.trib[1], pair.lab.full, expression(Q[CANSWKO]))
pair.lab.sub <- c(pair.lab.trib[1], pair.lab.full[c(1,2,3,4)], expression(Q[CANSWKCO]),
                  expression(atop(Q[ARKLASCO], Q[CANSWKCO])))
plot.script()
rm(aUCAN)

####  TIMSWIC0  ####
setwd(dataFile)
y <- read.csv("TIMSWICO.csv")

ttl <- "TIMSWICO"
tt2 <- "aUTIM"

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
cat("\nAIC Stepwise Algorithm results insufficient for modelling.\n")
cat("\n\nTest 2\n")
summary(lm(cse ~ q.x*ec.in, data=y[-nas,], na.action = na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ ec.in + q.x, data=y[-nas,], na.action = na.exclude))
cat("\nInclusion of q.x is not warranted, but required to account for\n")
cat("location specific variations.\n")
cat("\n\nEnd Testing.")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aUTIM <- lm.x <- lm(cse ~ ec.in + q.x, data=y[-nas,], na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aUTIM, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aUTIM, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c(1,3,8)]
pair.lab <- c(pair.lab.trib[2], pair.lab.full, expression(Q[TIMSWICO]))
pair.lab.sub <- c(pair.lab.trib[2], pair.lab.full[2], expression(Q[TIMSWICO]))
plot.script()
rm(aUTIM)

####  HRC194C0  ####
setwd(dataFile)
y <- read.csv("HRC194CO.csv")

ttl <- "HRC194CO"
tt2 <- "aUHRC"

y <- y[,c(-1)]

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.in + ec.in + t.in + q.out + ec.out + t.out + q.x, data=y, na.action=na.exclude))
cat("\nModel over-specified.\n")
cat("\n\nTest 2\n")
summary(lm(cse ~ (q.in + ec.in + t.in) * q.x, data=y, na.action=na.exclude))
cat("\nModel over-specified.\n")
cat("\n\nTest 3\n")
summary(lm(cse ~ (q.out + ec.out + t.out) * q.x, data=y, na.action=na.exclude))
cat("\nModel over-specified.\n")
cat("\n\nTest 4\n")
summary(lm(cse ~ q.x, data=y, na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aUHRC <- lm.x <- lm(cse ~ q.x, data=y, na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aUHRC, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
lmStatsFunction(aUHRC, y$cse, fileName)

setwd(plotFile)
y.sub <- y[,c(1,8)]
pair.lab <- c(pair.lab.trib[3], pair.lab.full, expression(Q[HRC194CO]))
pair.lab.sub <- c(pair.lab.trib[3], expression(Q[HRC194CO]))
plot.script()
rm(aUHRC)

####  LaJunta WWTP  ####
setwd(dataFile)
y <- read.csv("LaJunta WWTP.csv")

ttl <- "LAJWWTP"
tt2 <- "aUWTP"

y <- y[,c(-1)]

y <- y[complete.cases(y),]
y$q.x <- y$q.x*1.5472287  # convert MGD to cfs

setwd(resultsFile)
fileName <- paste(ttl, "_Regression.txt", sep="")
zz <- textConnection("foo", open="w")
sink(zz)
cat(paste("Analysis of Selenium Concentrations at",ttl,"\n\n"))
cat("Tested regressions\n\n")
cat("Test 1\n")
summary(lm(cse ~ q.x, data=y, na.action=na.exclude))
cat("\n\nTest 2\n")
summary(lm(cse ~ log(q.x), data=y, na.action=na.exclude))
cat("\n\nTest 3\n")
summary(lm(cse ~ 1/q.x, data=y, na.action=na.exclude))
cat("\n\nTest 3\n")
summary(nls(cse ~ a*q.x^b, start=list(a=1, b=1), data=y, na.action=na.exclude))
cat("\n\nTest 4\nModel form from literature.\n")
summary(nls(cse ~ a*log(q.x, base=exp(1))+b, start=list(a=1, b=1), data=y, na.action=na.exclude))
cat("\n\nEnd of Test\n\n")
sink()
close(zz)
write(foo, fileName, append=FALSE)

aUWTP <- lm.x <- nls(cse ~ a*log(q.x, base=exp(1))+b, start=list(a=1, b=1), data=y, na.action=na.exclude)

fileName <- paste(modelsFile,tt2,".Rdata", sep="")
save(aUWTP, file=fileName)

fileName <- paste(resultsFile,ttl,"_Stats.txt", sep="")
nlsStatsFunction(aUWTP, y$cse, fileName)

setwd(plotFile)
y.sub <- y
pair.lab <- c(pair.lab.trib[4], expression(Q[WWTP]))
pair.lab.sub <- pair.lab
plot.script()

rm(list=ls())
