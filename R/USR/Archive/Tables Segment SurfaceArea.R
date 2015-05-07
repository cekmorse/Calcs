source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")
textTablesFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

m2toHectare <- 0.0001
hectareToAcre <- 2.47105
m2toft2 <- 10.7639

# run1 <- function(){
# 
# du <- bquote(.(signif(quantile(da, probs=0.025, na.rm=TRUE)[[1]] * 0.0001, 4))) 
# dm <- bquote(.(signif(mean(da, na.rm=TRUE) * 0.0001, 4)))
# dl <- bquote(.(signif(quantile(da, probs=0.975, na.rm=TRUE)[[1]] * 0.0001, 4)))
# 
# du2 <- bquote(.(signif(du * hectareToAcre, 4)))
# dm2 <- bquote(.(signif(dm * hectareToAcre, 4)))
# dl2 <- bquote(.(signif(dl * hectareToAcre, 4)))
# 
# pu <- apply(ds, 1, quantile, probs = 0.975, na.rm=TRUE)
# mn <- rowMeans(ds, na.rm=TRUE)
# pl <- apply(ds, 1, quantile, probs = 0.025, na.rm=TRUE)
# 
# d <- bquote(.(signif(quantile(pu, probs=0.025, na.rm=TRUE)[[1]] * 0.0001, 4))) 
# e <- bquote(.(signif(mean(pu, na.rm=TRUE) * 0.0001, 4)))
# f <- bquote(.(signif(quantile(pu, probs=0.975, na.rm=TRUE)[[1]] * 0.0001, 4)))
# 
# d2 <- bquote(.(signif(d * hectareToAcre, 4)))
# e2 <- bquote(.(signif(e * hectareToAcre, 4)))
# f2 <- bquote(.(signif(f * hectareToAcre, 4)))
# 
# g <- bquote(.(signif(quantile(mn, probs=0.025, na.rm=TRUE)[[1]] * 0.0001, 4))) 
# h <- bquote(.(signif(mean(mn, na.rm=TRUE) * 0.0001, 4)))
# i <- bquote(.(signif(quantile(mn, probs=0.975, na.rm=TRUE)[[1]] * 0.0001, 4)))
# 
# g2 <- bquote(.(signif(g * hectareToAcre, 4)))
# h2 <- bquote(.(signif(h * hectareToAcre, 4)))
# i2 <- bquote(.(signif(i * hectareToAcre, 4)))
# 
# j <- bquote(.(signif(quantile(pl, probs=0.025, na.rm=TRUE)[[1]] * 0.0001, 4))) 
# k <- bquote(.(signif(mean(pl, na.rm=TRUE) * 0.0001, 4)))
# l <- bquote(.(signif(quantile(pl, probs=0.975, na.rm=TRUE)[[1]] * 0.0001, 4)))
# 
# j2 <- bquote(.(signif(j * hectareToAcre, 4)))
# k2 <- bquote(.(signif(k * hectareToAcre, 4)))
# l2 <- bquote(.(signif(l * hectareToAcre, 4)))
# 
# ds.cor <- bquote(.(signif(cor(da, mn, use="complete.obs", method="pearson"), 4)))
# 
# setwd(textTablesFolder)
# zz <- textConnection("foo", open="w")
# sink(zz)
# cat("\\begin{tabular}{C{1.25in} C{1.4in} C{1.4in} C{1.4in}} \n",
#     "\\toprule \n",
#     "\\multicolumn{4}{l}{\\textbf{Deterministic Model Time Series}} \\\\ \n",
#     "& 2.5th & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
#     "& Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){2-4} \n",
#     "& ", du," (",du2, ") & ", dm," (", dm2, ") &", dl, " (", dl2, ") \\\\ \n",
#     "\\toprule \n",
#     "\\multicolumn{4}{l}{\\textbf{Stochastic Model Summary Statistics Time Series}} \\\\ \n",
#     "& 2.5th      & \\multirow{2}{*}{Mean} & 97.5th \\\\ \n",
#     "& Percentile & & Percentile \\\\ \\cmidrule(r{.5em}l){2-4} \n",
#     "97.5th Percentile & ", d," (", d2,") & " , e," (", e2,") & " ,f," (", f2,") \\\\", "\n",
#     "Mean & ", g," (", g2,") & " , h," (", h2,") & " ,i," (", i2,") \\\\", "\n",
#     "2.5th Percentile & ", j," (", j2,") & " , k," (", k2,") & " ,l," (", l2,") \\\\ \n",
#     "\\bottomrule \n",
#     "\\multicolumn{4}{l}{Pearson Correlation = ", ds.cor ," } \n",
#     "\\end{tabular} \\\\", sep="")
# sink()
# close(zz)
# write(foo, fname, append=FALSE)
# }

fname <- "tableAreaA.txt"
setwd(models.D)
load("areaA.Rdata")
da <- surfaceArea
setwd(modelsFile)
load("areaA.Rdata")
ds <- surfaceArea
makeTable(da, ds, 1, m2toft2, textTablesFolder, fname)
# run1()

fname <- "tableAreaB.txt"
setwd(models.D)
load("areaB.Rdata")
da <- surfaceArea
setwd(modelsFile)
load("areaB.Rdata")
ds <- surfaceArea
run1()

fname <- "tableAreaC.txt"
setwd(models.D)
load("areaC.Rdata")
da <- surfaceArea
setwd(modelsFile)
load("areaC.Rdata")
ds <- surfaceArea
run1()

fname <- "tableAreaD.txt"
setwd(models.D)
load("areaD.Rdata")
da <- surfaceArea
setwd(modelsFile)
load("areaD.Rdata")
ds <- surfaceArea
run1()

fname <- "tableAreaE.txt"
setwd(models.D)
load("areaE.Rdata")
da <- surfaceArea
setwd(modelsFile)
load("areaE.Rdata")
ds <- surfaceArea
run1()

rm(list=ls())