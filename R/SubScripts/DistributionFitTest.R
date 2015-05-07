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
      gf_shape = "pois"
      fd_p <- fitdistr(data, "poisson")
      est_lambda = fd_p$estimate[[1]]
      
      ks = ks.test(data, "ppois", lambda=est_lambda)
      # add to results
      results[i,] = c(gf_shape, est_lambda, 0, ks$statistic, ks$p.value)
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
      gf_shape = "norm"
      fd_n <- fitdistr(data, "normal")
      est_mean = fd_n$estimate[[1]]
      est_sd = fd_n$estimate[[2]]
      
      ks = ks.test(data, "pnorm", mean=est_mean, sd=est_sd)
      # add to results
      results[i,] = c(gf_shape, est_mean, est_sd, ks$statistic, ks$p.value)
    }
    
    else if(distrib[[i]] == "exponential"){
      gf_shape = "exp"
      fd_e <- fitdistr(data, "exponential")
      est_rate = fd_e$estimate[[1]]
      ks = ks.test(data, "pexp", rate=est_rate)
      # add to results
      results[i,] = c(gf_shape, est_rate, 0, ks$statistic, ks$p.value)
    }
    
    else if(distrib[[i]] == "logistic"){
      gf_shape = "logis"
      fd_l <- fitdistr(data, "logistic")
      est_location = fd_l$estimate[[1]]
      est_scale = fd_l$estimate[[2]]
      ks = ks.test(data, "plogis", location=est_location, scale=est_scale)
      # add to results
      results[i,] = c(gf_shape, est_location, est_scale, ks$statistic, ks$p.value) 
    }
    
    else if(distrib[[i]] == "lognormal"){
      gf_shape = "lnorm"
      fd_l <- fitdistr(data, "lognormal")
      est_meanlog = fd_l$estimate[[1]]
      est_sdlog = fd_l$estimate[[2]]
      ks = ks.test(data, "plnorm", meanlog=est_meanlog, sdlog=est_sdlog)
      # add to results
      results[i,] = c(gf_shape, est_meanlog, est_sdlog, ks$statistic, ks$p.value) 
    }
    
  }
#   results = rbind(c("distribution", "param1", "param2", "ks stat", "ks pvalue"), results)
  cname = c("distribution", "param1", "param2", "ks stat", "ks pvalue")
  results = data.frame(results)
  colnames(results) = cname 
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