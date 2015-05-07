require(fitdistrplus)
require(moments)
require(MASS)
require(testthat)

inFolder <- "C:\\Thesis\\LARB\\03 Thesis-Calcs\\3 Estimate Concentration"
outFolder <- "C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\USR Output\\Stochastic\\"

testFit <- function(data, sample=1){
  options(warn = -1)
  results <- matrix(0, ncol=2, nrow=7)
  
  n <- round(length(data)*sample)
  data <- sample(data, size=n, replace=F)
  
  testd <- tryCatch(fitdistr(data, "gamma"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "gamma")
    est1 <- fd$estimate[[1]]
    est2 <- fd$estimate[[2]]
    ks <- ks.test(data, "pgamma", est1, est2)
    results[1,]=c("gamma", ks$statistic)
  } else {
    results[1,]=c("gamma", NA)
  }
  
  testd <- tryCatch(fitdistr(data, "gamma"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "poisson")
    est1 <- fd$estimate[[1]]
    ks <- ks.test(data, "ppois", est1)
    results[2,]=c("poisson", ks$statistic)
  } else {
    results[2,]=c("poisson", NA)
  }
  
  testd <- tryCatch(fitdistr(data, "weibull"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "weibull")
    est1 <- fd$estimate[[1]]
    est2 <- fd$estimate[[2]]
    ks <- ks.test(data, "pweibull", est1, est2)
    results[3,]=c("weibull", ks$statistic)
  } else {
    results[3,]=c("weibull", NA)
  }
  
  testd <- tryCatch(fitdistr(data, "normal"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "normal")
    est1 <- fd$estimate[[1]]
    est2 <- fd$estimate[[2]]
    ks <- ks.test(data, "pnorm", est1, est2)
    results[4,]=c("normal", ks$statistic)
  } else {
    results[4,]=c("normal", NA)
  }
  
  testd <- tryCatch(fitdistr(data, "exponential"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "exponential")
    est1 <- fd$estimate[[1]]
    ks <- ks.test(data, "pexp", est1)
    results[5,]=c("exponential", ks$statistic)
  } else {
    results[5,]=c("exponential", NA)
  }
  
  testd <- tryCatch(fitdistr(data, "logistic"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "logistic")
    est1 <- fd$estimate[[1]]
    ks <- ks.test(data, "plogis", est1)
    results[6,]=c("logistic", ks$statistic)
  } else {
    results[6,]=c("logistic", NA)
  }
  
  testd <- tryCatch(fitdistr(data, "lognormal"), error=function(e) FALSE)
  if(is.list(testd) == TRUE){
    fd <- fitdistr(data, "lognormal")
    est1 <- fd$estimate[[1]]
    ks <- ks.test(data, "plnorm", est1)
    results[7,]=c("lognormal", ks$statistic)
  } else {
    results[7,]=c("lognormal", NA)
  }
  
  options(warn=0)
  cname <- c("distribution","ks stat")
  results <- data.frame(results)
  colnames(results) <- cname
  # print(results)
  return(results)
}

setwd(outFolder)
load("m atmChange.Rdata")
x <- atmChange
rm(atmChange)

times <- dim(x)[[1]]
reals <- dim(x)[[2]]

rgama <- 0
rpoi <- 0
rwei <- 0
rexpo <- 0
rlog <- 0
rnor <- 0
rlnor <- 0

tgama <- 0
tpoi <- 0
twei <- 0
texpo <- 0
tlog <- 0
tnor <- 0
tlnor <- 0

type <- NA

for(i in 1:times){
  rdata <- as.vector(as.matrix(x[i,]))
  if(!is.na(min(rdata))){
    rcheck <- testFit(rdata)
    type <- rcheck[which.min(rcheck[,2]),1]
    if(type == "gamma"){
      rgama <- rgama + 1
    } else if(type == "poisson"){
      rpoi <- rpoi + 1
    } else if(type == "weibull"){
      rwei <- rwei + 1
    } else if(type == "normal"){
      rnor <- rnor + 1
    } else if(type == "exponential"){
      rexpo <- rexpo + 1
    } else if(type == "logistic"){
      rlog <- rlog + 1
    } else if(type == "lognormal"){
      rlnor <- rlnor + 1
    }
    print(i); flush.console()
  }
}

for(i in 1:reals){
  tdata <- as.vector(as.matrix(x[,i]))
  tdata <- tdata[!is.na(tdata)]
  tcheck <- testFit(tdata)
  type <- tcheck[which.min(tcheck[,2]),1]
  if(type == "gamma"){
    tgama <- tgama + 1
  } else if(type == "poisson"){
    tpoi <- tpoi + 1
  } else if(type == "weibull"){
    twei <- twei + 1
  } else if(type == "normal"){
    tnor <- tnor + 1
  } else if(type == "exponential"){
    texpo <- texpo + 1
  } else if(type == "logistic"){
    tlog <- tlog + 1
  } else if(type == "lognormal"){
    tlnor <- tlnor + 1
  }
  print(i); flush.console()
}

rfinal <- c(rgama, rpoi, rnor, rwei, rexpo, rlog, rlnor)
tfinal <- c(tgama, tpoi, tnor, twei, texpo, tlog, tlnor)

final <- data.frame(rbind(rfinal, tfinal))
colnames(final) <- c("gamma","pois","norm","weib","exp","logis","lnorm")

print(final)
