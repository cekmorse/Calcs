stats <- data.frame(uci=apply(yy, 2, quantile, probs=c(0.975), na.rm=TRUE),
                    p85=apply(yy, 2, quantile, probs=c(0.85), na.rm=TRUE),
                    mean=colMeans(yy, na.rm=TRUE),
                    p15=apply(yy, 2, quantile, probs=c(0.15), na.rm=TRUE),
                    lci=apply(yy, 2, quantile, probs=c(0.025), na.rm=TRUE),
                    stdd=apply(yy, 2, sd, na.rm=TRUE),
                    skew=apply(yy, 2, skewness, na.rm=TRUE),
                    kurt=apply(yy, 2, kurtosis, na.rm=TRUE)
)
statsmn <- signif(stats,3)
xx <- data.frame(ti=DATE, mean=yy); colnames(xx) <- c("ti","mean")
xx <- xx[which(xx$ti >= min(tframe$ti) & xx$ti <= max(tframe$ti)),]
xx <- merge(tframe, xx, by="ti", all=TRUE)