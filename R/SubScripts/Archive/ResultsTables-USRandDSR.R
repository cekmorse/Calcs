# setwd(textTablesFolder)
# zz <- textConnection("foo", open="w")
# sink(zz)
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
# sink()
# close(zz)
# write(foo, fname, append=FALSE)