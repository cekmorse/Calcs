###  PROGRAM REQUIREMENTS  ###
list.of.packages <- c("moments", "KernSmooth", "nlstools", "fitdistrplus", "reshape2", "msm", "MASS", "qpcR", "dplyr")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
options(warn=-1)
lapply(list.of.packages, require, character.only=T)
options(warn=0)
rm(list.of.packages, new.packages)

options(digits = 15)

source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/DistributionFitTest.R")

## this function allows for converting NaN values in a matrix/data.frame to whatever the user wants.  Call using is.nan(x)
is.nan.data.frame <- function(x)
  do.call(cbind, lapply(x, is.nan))

polylims = function(xdata, ydata, ydata2) {
  rl = rle(is.na(ydata))
  starts = vector()
  ends = vector()
  indx = 1
  for (i in 1:length(rl$lengths)){
    if (rl$values[i]){
      # Value was NA, advance index without saving the numeric values
      indx = indx + rl$lengths[i]
    } else {
      # Value was a real number, extract and save those values
      starts = c(starts,indx)
      ends = c(ends, (indx + rl$lengths[i] - 1))
      indx = indx + rl$lengths[i]
    }  
  }
  polylist = list()
  for (i in 1:length(starts)){
    temp = data.frame(x = c(xdata[starts[i]],xdata[starts[i]:ends[i]],
                            rev(xdata[starts[i]:ends[i]])),
                      y = c(ydata[starts[i]],ydata2[starts[i]:ends[i]],
                            rev(ydata[starts[i]:ends[i]])))
    polylist[[i]] = temp  
  }
  polylist
}

panel.pearson <- function(x, y, ...){
  horizontal <- (par("usr")[1] + par("usr")[2]) / 2;
  vertical <- (par("usr")[3] + par("usr")[4]) / 2;
  text(horizontal, vertical, format(cor(x,y, use="complete.obs"), digits=2), cex=1)
}

changeStats <- function(dates, x){
  return <- data.frame(date=dates,
                       P.025=apply(x, 1, quantile, probs=0.025, na.rm=TRUE),
                       Mean=rowMeans(x, na.rm=TRUE),
                       P.975=apply(x, 1, quantile, probs=0.975, na.rm=TRUE),
                       SD=apply(x, 1, sd, na.rm=TRUE),
                       Skew=apply(x, 1, skewness, na.rm=TRUE),
                       Kurt=apply(x, 1, kurtosis, na.rm=TRUE))
}

changeStatsStats <- function(x){
  return <- signif(data.frame(xP0.025=apply(x, 2, quantile, probs=0.025, na.rm=TRUE),
                              xMean=colMeans(x, na.rm=TRUE),
                              xP0.975=apply(x, 2, quantile, probs=0.975, na.rm=TRUE),
                              xSD=apply(x, 2, sd, na.rm=TRUE),
                              xSkew=apply(x, 2, skewness, na.rm=TRUE),
                              xKurt=apply(x, 2, kurtosis, na.rm=TRUE)),4)
}

difStats <- function(x){
  return <- signif(data.frame(P.025=quantile(x, probs=0.025, na.rm=TRUE),
                              Mean=mean(rowMeans(x, na.rm=TRUE), na.rm=TRUE),
                              P.975=quantile(x, probs=0.975, na.rm=TRUE)),3)
}

makeSimpleTable <- function(dd, ds, scaleConvert, saveFolder, saveFile){
  du <- bquote(.(signif(quantile(dd, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  dm <- bquote(.(signif(mean(dd, na.rm=TRUE) * scaleConvert, 3)))
  dl <- bquote(.(signif(quantile(dd, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  pu <- apply(ds, 1, quantile, probs = 0.975, na.rm=TRUE)
  mn <- rowMeans(ds, na.rm=TRUE)
  pl <- apply(ds, 1, quantile, probs = 0.025, na.rm=TRUE)
  
  d <- bquote(.(signif(quantile(pu, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  e <- bquote(.(signif(mean(pu, na.rm=TRUE) * scaleConvert, 3)))
  f <- bquote(.(signif(quantile(pu, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  g <- bquote(.(signif(quantile(mn, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  h <- bquote(.(signif(mean(mn, na.rm=TRUE) * scaleConvert, 3)))
  i <- bquote(.(signif(quantile(mn, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  j <- bquote(.(signif(quantile(pl, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  k <- bquote(.(signif(mean(pl, na.rm=TRUE) * scaleConvert, 3)))
  l <- bquote(.(signif(quantile(pl, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  ds.cor <- bquote(.(signif(cor(dd, mn, use="complete.obs", method="pearson"), 4)))
  
  setwd(saveFolder)
  zz <- textConnection("foo", open="w")
  sink(zz)
  cat("\\begin{tabular}{C{1.2in} C{1.5in} C{1.5in} C{1.5in}} \n",
      "\\toprule \n",
      "\\multicolumn{4}{l}{\\textbf{Deterministic Model Time Series}} \\\\ \n",
      "\\\\ \n",
      "& 2.5th & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
      "& Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){2-4} \n",
      "& ", du," & ", dm," &", dl, " \\\\ \n",
      "\\\\ \n",
      "\\toprule \n",
      "\\multicolumn{4}{l}{\\textbf{Stochastic Model Summary Statistics Time Series}} \\\\ \n",
      "\\\\ \n",
      "Time & 2.5th      & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
      "Series & Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){1-4} \n",
      "97.5th Percentile & ", d," & ", e," & " ,f," \\\\", "\n",
      "Mean & ", g," & " , h," & " ,i," \\\\", "\n",
      "2.5th Percentile & ", j," & " , k," & " ,l," \\\\ \n",
      "\\multicolumn{4}{l}{Pearson Correlation = ", ds.cor ," } \\\\ \n",
      "\\bottomrule \n",
      "\\end{tabular} \\\\", sep="")
  sink()
  close(zz)
  write(foo, saveFile, append=FALSE)
}

makeTable <- function(dd, ds, scaleConvert, unitConvert, saveFolder, saveFile){
  du <- bquote(.(signif(quantile(dd, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  dm <- bquote(.(signif(mean(dd, na.rm=TRUE) * scaleConvert, 3)))
  dl <- bquote(.(signif(quantile(dd, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  du2 <- bquote(.(signif(du * unitConvert, 3)))
  dm2 <- bquote(.(signif(dm * unitConvert, 3)))
  dl2 <- bquote(.(signif(dl * unitConvert, 3)))
  
  pu <- apply(ds, 1, quantile, probs = 0.975, na.rm=TRUE)
  mn <- rowMeans(ds, na.rm=TRUE)
  pl <- apply(ds, 1, quantile, probs = 0.025, na.rm=TRUE)
  
  d <- bquote(.(signif(quantile(pu, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  e <- bquote(.(signif(mean(pu, na.rm=TRUE) * scaleConvert, 3)))
  f <- bquote(.(signif(quantile(pu, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  d2 <- bquote(.(signif(d * unitConvert, 3)))
  e2 <- bquote(.(signif(e * unitConvert, 3)))
  f2 <- bquote(.(signif(f * unitConvert, 3)))
  
  g <- bquote(.(signif(quantile(mn, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  h <- bquote(.(signif(mean(mn, na.rm=TRUE) * scaleConvert, 3)))
  i <- bquote(.(signif(quantile(mn, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  g2 <- bquote(.(signif(g * unitConvert, 3)))
  h2 <- bquote(.(signif(h * unitConvert, 3)))
  i2 <- bquote(.(signif(i * unitConvert, 3)))
  
  j <- bquote(.(signif(quantile(pl, probs=0.025, na.rm=TRUE)[[1]] * scaleConvert, 3))) 
  k <- bquote(.(signif(mean(pl, na.rm=TRUE) * scaleConvert, 3)))
  l <- bquote(.(signif(quantile(pl, probs=0.975, na.rm=TRUE)[[1]] * scaleConvert, 3)))
  
  j2 <- bquote(.(signif(j * unitConvert, 3)))
  k2 <- bquote(.(signif(k * unitConvert, 3)))
  l2 <- bquote(.(signif(l * unitConvert, 3)))
  
  ds.cor <- bquote(.(signif(cor(dd, mn, use="complete.obs", method="pearson"), 4)))
  
  setwd(saveFolder)
  zz <- textConnection("foo", open="w")
  sink(zz)
  cat("\\begin{tabular}{C{1.2in} C{1.5in} C{1.5in} C{1.5in}} \n",
      "\\toprule \n",
      "\\multicolumn{4}{l}{\\textbf{Deterministic Model Time Series}} \\\\ \n",
      "\\\\ \n",
      "& 2.5th & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
      "& Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){2-4} \n",
      "& ", du," (",du2, ") & ", dm," (", dm2, ") &", dl, " (", dl2, ") \\\\ \n",
      "\\\\ \n",
      "\\toprule \n",
      "\\multicolumn{4}{l}{\\textbf{Stochastic Model Summary Statistics Time Series}} \\\\ \n",
      "\\\\ \n",
      "Time & 2.5th      & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
      "Series & Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){1-4} \n",
      "97.5th Percentile & ", d," (", d2,") & " , e," (", e2,") & " ,f," (", f2,") \\\\", "\n",
      "Mean & ", g," (", g2,") & " , h," (", h2,") & " ,i," (", i2,") \\\\", "\n",
      "2.5th Percentile & ", j," (", j2,") & " , k," (", k2,") & " ,l," (", l2,") \\\\ \n",
      "\\multicolumn{4}{l}{Pearson Correlation = ", ds.cor ," } \\\\ \n",
      "\\bottomrule \n",
      "\\end{tabular} \\\\", sep="")
  sink()
  close(zz)
  write(foo, saveFile, append=FALSE)
}

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