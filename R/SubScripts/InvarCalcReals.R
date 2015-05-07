if (type == "a")
  { means[means <= 0] <- 0
    meansMin <- min(means, na.rm=TRUE)/2 - 0.0001
    meansMax <- max(means, na.rm=TRUE)*1.5
    sdevs <- means * percent / zscore
}
if (type == "b") {
  sdevs <- rep(NA, times)
  sdevs[which(!is.na(means))] <- difference / zscore
}

meansMatrix <- data.frame(matrix(0, nrow=times, ncol=reals))
means[is.na(means)] <- -999
sdevs[is.na(sdevs)] <- -1
check <- sdevs
check[check == 0] <- 0
check[check > 0] <- 1

meansMatrix <- data.frame(apply(meansMatrix, 2, rtnorm, mean=means, sd=sdevs, lower=meansMin, upper=meansMax))

meansMatrix[is.nan(meansMatrix)] <- NA
meansMatrix <- meansMatrix * check
