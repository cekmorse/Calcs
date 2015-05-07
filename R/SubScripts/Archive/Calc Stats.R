stats <- data.frame(uci=apply(yy, 1, quantile, probs=c(0.975), na.rm=TRUE),
                    p85=apply(yy, 1, quantile, probs=c(0.85), na.rm=TRUE),
                    mean=rowMeans(yy, na.rm=TRUE),
                    p15=apply(yy, 1, quantile, probs=c(0.15), na.rm=TRUE),
                    lci=apply(yy, 1, quantile, probs=c(0.025), na.rm=TRUE),
                    stdd=apply(yy, 1, sd, na.rm=TRUE),
                    skew=apply(yy, 1, skewness, na.rm=TRUE),
                    kurt=apply(yy, 1, kurtosis, na.rm=TRUE)
)
statsmn <- signif(colMeans(stats, na.rm=TRUE),3)
xx <- data.frame(ti=DATE, uci=stats$uci, mean=stats$mean, lci=stats$lci)
xx <- xx[which(xx$ti >= min(tframe$ti) & xx$ti <= max(tframe$ti)),]
xx <- merge(tframe, xx, by="ti", all=TRUE)
polys <- polylims(xx$ti, xx$uci, xx$lci)