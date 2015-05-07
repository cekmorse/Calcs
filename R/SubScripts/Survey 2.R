geo.lm <- nls(tw ~ a*h^b, start=list(a=100, b=.1))
sumnl <- summary(geo.lm)
a <- sumnl$coef[[1]]
b <- sumnl$coef[[2]]
r <- sumnl$resid
# rse <- sumnl$sigma
rse <- RMSE(geo.lm)
save(geo.lm, file=paste("geolm sec ",i,".Rdata",sep=""))     