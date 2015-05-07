#################################################
# Automatic distribution fitting and selection
#
# Copyright 2014 worldofpiggy.com
#################################################
library(MASS)
#Usage: 
#data, numeric vector of observations of unknown distribution
#fit, a list of distributions to fit data
#sample, rate of subsampling (0.5 means that a sample 50% of data will be considered) 
fitData <- function(data, fit="gamma", sample=0.5){
  distrib = list()
  numfit <- length(fit)
  results = matrix(0, ncol=5, nrow=numfit)
  
  for(i in 1:numfit){
    if((fit[i] == "gamma") | 
         (fit[i] == "poisson") | 
         (fit[i] == "weibull") | 
         (fit[i] == "exponential") |
         (fit[i] == "logistic") |
         (fit[i] == "normal") | 
         (fit[i] == "geometric") |
         (fit[i] == "lognormal")
    ) 
      distrib[[i]] = fit[i]
    else stop("Provide a valid distribution to fit data" )
  }
  
  # take a sample of dataset
  n = round(length(data)*sample)
  data = sample(data, size=n, replace=F)
  
  for(i in 1:numfit) {
    if(distrib[[i]] == "gamma") {
      gf_shape = "gamma"
      fd_g <- fitdistr(data, "gamma")
      est_shape = fd_g$estimate[[1]]
      est_rate = fd_g$estimate[[2]]
      
      ks = ks.test(data, "pgamma", shape=est_shape, rate=est_rate)
      
      # add to results
      results[i,] = c(gf_shape, est_shape, est_rate, ks$statistic, ks$p.value)
    }
    
    else if(distrib[[i]] == "poisson"){
      gf_shape = "poisson"
      fd_p <- fitdistr(data, "poisson")
      est_lambda = fd_p$estimate[[1]]
      
      ks = ks.test(data, "ppois", lambda=est_lambda)
      # add to results
      results[i,] = c(gf_shape, est_lambda, "NA", ks$statistic, ks$p.value)
    }
    
    else if(distrib[[i]] == "weibull"){
      gf_shape = "weibull"
      fd_w <- fitdistr(data,densfun=dweibull,start=list(scale=1,shape=2))
      est_shape = fd_w$estimate[[1]]
      est_scale = fd_w$estimate[[2]]
      
      ks = ks.test(data, "pweibull", shape=est_shape, scale=est_scale)
      # add to results
      results[i,] = c(gf_shape, est_shape, est_scale, ks$statistic, ks$p.value) 
    }
    
    else if(distrib[[i]] == "normal"){
      gf_shape = "normal"
      fd_n <- fitdistr(data, "normal")
      est_mean = fd_n$estimate[[1]]
      est_sd = fd_n$estimate[[2]]
      
      ks = ks.test(data, "pnorm", mean=est_mean, sd=est_sd)
      # add to results
      results[i,] = c(gf_shape, est_mean, est_sd, ks$statistic, ks$p.value)
    }
    
    else if(distrib[[i]] == "exponential"){
      gf_shape = "exponential"
      fd_e <- fitdistr(data, "exponential")
      est_rate = fd_e$estimate[[1]]
      ks = ks.test(data, "pexp", rate=est_rate)
      # add to results
      results[i,] = c(gf_shape, est_rate, "NA", ks$statistic, ks$p.value)
    }
    
    else if(distrib[[i]] == "logistic"){
      gf_shape = "logistic"
      fd_l <- fitdistr(data, "logistic")
      est_location = fd_l$estimate[[1]]
      est_scale = fd_l$estimate[[2]]
      ks = ks.test(data, "plogis", location=est_location, scale=est_scale)
      # add to results
      results[i,] = c(gf_shape, est_location, est_scale, ks$statistic, ks$p.value) 
    }
    
    else if(distrib[[i]] == "lognormal"){
      gf_shape = "lognormal"
      fd_l <- fitdistr(data, "lognormal")
      est_meanlog = fd_l$estimate[[1]]
      est_sdlog = fd_l$estimate[[2]]
      ks = ks.test(data, "plnorm", meanlog=est_meanlog, sdlog=est_sdlog)
      # add to results
      results[i,] = c(gf_shape, est_meanlog, est_sdlog, ks$statistic, ks$p.value) 
    }
    
  }
  results = rbind(c("distribution", "param1", "param2", "ks stat", "ks pvalue"), results)
  #print(results)
  return(results)
}

dtrunc <- function(x, spec, a = -Inf, b = Inf, ...)
{
  tt <- rep(0, length(x))
  g <- get(paste("d", spec, sep = ""), mode = "function")
  G <- get(paste("p", spec, sep = ""), mode = "function")
  tt[x>=a & x<=b] <- g(x[x>=a&x<=b], ...)/(G(b, ...) - G(a, ...))
  return(tt)
}

qtrunc <- function(p, spec, a = -Inf, b = Inf, ...)
{
  tt <- p
  G <- get(paste("p", spec, sep = ""), mode = "function")
  Gin <- get(paste("q", spec, sep = ""), mode = "function")
  tt <- Gin(G(a, ...) + p*(G(b, ...) - G(a, ...)), ...)
  return(tt)
}

rtrunc <- function(n, spec, a = -Inf, b = Inf, ...)
{
  x <- u <- runif(n, min = 0, max = 1)
  x <- qtrunc(u, spec, a = a, b = b,...)
  return(x)
}

load("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\USR Output\\Stochastic\\AB.Rdata")
# load("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\DSR Output\\Stochastic\\AB.Rdata")

data <- AB$a
res = fitData(data, fit=c("logistic", "normal", "exponential", "poisson", "weibull", "lognormal"), sample=1)
#res #view the data set to choose the best fit

pdf("C:\\Thesis\\Thesis\\Figures\\Results_USR\\USR B1 Dist.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=c(0,250), ylim=c(0,0.025), main="", xlab=expression(USR~beta[1]~Values))
rug(data)
rng <- seq(0,250,0.1)
lines(density(data, bw="SJ"), lwd=2, lty=2)
lines(rng, dlogis(rng, as.numeric(res[2,2]), as.numeric(res[2,3])), col="red", lwd=2)
lines(rng, dnorm(rng, as.numeric(res[3,2]), as.numeric(res[3,3])), col="blue", lwd=2)
lines(rng, dexp(rng, as.numeric(res[4,2])), col="Chartreuse4", lwd=2)
lines(rng, dweibull(rng, as.numeric(res[6,2]), as.numeric(res[6,3])), col="darkorange2", lwd=2)
lines(rng, dlnorm(rng, as.numeric(res[7,2]), as.numeric(res[7,3])), col="cyan3", lwd=2)
legend("topright", legend=c("data density", "logistic","normal","exponential", "weibull","log-normal"), 
       col=c("black","red","blue","chartreuse4","darkorange2","cyan3"), 
       lty=c(2,1,1,1,1,1), lwd=c(2,2,2,2,2,2))
dev.off()

AFit <- c(as.numeric(res[2,2]), as.numeric(res[2,3]))
fittest <- dtrunc(rng, "logis", a=0, location=AFit[[1]], scale=AFit[[2]])
Arandom <- rtrunc(5000, "logis", a=0, location=AFit[[1]], scale=AFit[[2]])

pdf("C:\\Thesis\\Thesis\\Figures\\Results_USR\\USR B1 Dist Check.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=c(0,250), ylim=c(0,0.025), main="", xlab=expression(USR~beta[1]~Values))
rug(data)
lines(density(data, bw="SJ"), lwd=2, lty=2)
lines(rng,fittest, lwd=2, col="red")
lines(density(Arandom, bw="SJ"), lwd=2, lty=2, col="red")
legend("topright", legend=c("data density", "truncated logistic","random truncated logistic"), 
       col=c("black","red","red"), 
       lty=c(2,1,2), lwd=c(2,2,2))
dev.off()

data <- AB$b
res = fitData(data, fit=c("logistic", "normal", "exponential", "poisson", "weibull", "lognormal"), sample=1)
#res #view the data set to choose the best fit

pdf("C:\\Thesis\\Thesis\\Figures\\Results_USR\\USR B2 Dist.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=c(0,1.5), ylim=c(0,3), main="", xlab=expression(USR~beta[2]~Values))
rug(data)
rng <- seq(0,1.5,0.1)
lines(density(data, bw="SJ"), lwd=2, lty=2)
lines(rng, dlogis(rng, as.numeric(res[2,2]), as.numeric(res[2,3])), col="red", lwd=2)
lines(rng, dnorm(rng, as.numeric(res[3,2]), as.numeric(res[3,3])), col="blue", lwd=2)
lines(rng, dexp(rng, as.numeric(res[4,2])), col="Chartreuse4", lwd=2)
lines(rng, dweibull(rng, as.numeric(res[6,2]), as.numeric(res[6,3])), col="darkorange2", lwd=2)
lines(rng, dlnorm(rng, as.numeric(res[7,2]), as.numeric(res[7,3])), col="cyan3", lwd=2)
legend("topright", legend=c("data density", "logistic","normal","exponential", "weibull","log-normal"), 
       col=c("black","red","blue","chartreuse4","darkorange2","cyan3"), 
       lty=c(2,1,1,1,1,1), lwd=c(2,2,2,2,2,2))
dev.off()

BFit <- c(as.numeric(res[7,2]), as.numeric(res[7,3]))
fittest <- dlnorm(rng, meanlog=BFit[[1]], sdlog=BFit[[2]])
Brandom <- rlnorm(5000, meanlog=BFit[[1]], sdlog=BFit[[2]])

pdf("C:\\Thesis\\Thesis\\Figures\\Results_USR\\USR B2 Dist Check.pdf", width=6, height=6, family="Times")
par(mar=c(5.1,4.1,1.1,1.1))
hist(data, freq=FALSE, xlim=c(0,1.5), ylim=c(0,3), main="", xlab=expression(USR~beta[2]~Values))
rug(data)
lines(density(data, bw="SJ"), lwd=2, lty=2)
lines(rng,fittest, lwd=2, col="cyan3")
lines(density(Brandom, bw="SJ"), lwd=2, lty=2, col="cyan3")
legend("topright", legend=c("data density", "log-normal","random log-normal"), 
       col=c("black","cyan3","cyan3"), 
       lty=c(2,1,2), lwd=c(2,2,2))
dev.off()
