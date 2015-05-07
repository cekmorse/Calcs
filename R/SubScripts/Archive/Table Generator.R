du <- bquote(.(signif(quantile(da, probs=0.025, na.rm=TRUE)[[1]] * C1, 4))) 
dm <- bquote(.(signif(mean(da, na.rm=TRUE) * C1, 4)))
dl <- bquote(.(signif(quantile(da, probs=0.975, na.rm=TRUE)[[1]] * C1, 4)))

du2 <- bquote(.(signif(du * C2, 4)))
dm2 <- bquote(.(signif(dm * C2, 4)))
dl2 <- bquote(.(signif(dl * C2, 4)))

pu <- apply(ds, 1, quantile, probs = 0.975, na.rm=TRUE)
mn <- rowMeans(ds, na.rm=TRUE)
pl <- apply(ds, 1, quantile, probs = 0.025, na.rm=TRUE)

d <- bquote(.(signif(quantile(pu, probs=0.025, na.rm=TRUE)[[1]] * C1, 4))) 
e <- bquote(.(signif(mean(pu, na.rm=TRUE) * C1, 4)))
f <- bquote(.(signif(quantile(pu, probs=0.975, na.rm=TRUE)[[1]] * C1, 4)))

d2 <- bquote(.(signif(d * C2, 4)))
e2 <- bquote(.(signif(e * C2, 4)))
f2 <- bquote(.(signif(f * C2, 4)))

g <- bquote(.(signif(quantile(mn, probs=0.025, na.rm=TRUE)[[1]] * C1, 4))) 
h <- bquote(.(signif(mean(mn, na.rm=TRUE) * C1, 4)))
i <- bquote(.(signif(quantile(mn, probs=0.975, na.rm=TRUE)[[1]] * C1, 4)))

g2 <- bquote(.(signif(g * C2, 4)))
h2 <- bquote(.(signif(h * C2, 4)))
i2 <- bquote(.(signif(i * C2, 4)))

j <- bquote(.(signif(quantile(pl, probs=0.025, na.rm=TRUE)[[1]] * C1, 4))) 
k <- bquote(.(signif(mean(pl, na.rm=TRUE) * C1, 4)))
l <- bquote(.(signif(quantile(pl, probs=0.975, na.rm=TRUE)[[1]] * C1, 4)))

j2 <- bquote(.(signif(j * C2, 4)))
k2 <- bquote(.(signif(k * C2, 4)))
l2 <- bquote(.(signif(l * C2, 4)))

ds.cor <- bquote(.(signif(cor(da, mn, use="complete.obs", method="pearson"), 4)))

setwd(textTablesFolder)
zz <- textConnection("foo", open="w")
sink(zz)
cat("\\begin{tabular}{C{1.2in} C{1.5in} C{1.5in} C{1.5in}} \n",
    "\\toprule \n",
    "\\multicolumn{4}{l}{\\textbf{Deterministic Model Time Series}} \\\\ \n",
    "& 2.5th & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
    "& Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){2-4} \n",
    "& ", du," (",du2, ") & ", dm," (", dm2, ") &", dl, " (", dl2, ") \\\\ \n",
    "\\toprule \n",
    "\\multicolumn{4}{l}{\\textbf{Stochastic Model Summary Statistics Time Series}} \\\\ \n",
    "& 2.5th      & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
    "& Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){2-4} \n",
    "97.5th Percentile & ", d," (", d2,") & " , e," (", e2,") & " ,f," (", f2,") \\\\", "\n",
    "Mean & ", g," (", g2,") & " , h," (", h2,") & " ,i," (", i2,") \\\\", "\n",
    "2.5th Percentile & ", j," (", j2,") & " , k," (", k2,") & " ,l," (", l2,") \\\\ \n",
    "\\bottomrule \n",
    "\\multicolumn{4}{l}{Pearson Correlation = ", ds.cor ," } \n",
    "\\end{tabular} \\\\", sep="")
sink()
close(zz)
write(foo, fname, append=FALSE)