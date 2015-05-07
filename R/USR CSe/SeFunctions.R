# panel.pearson <- function(x, y, ...)
# {
#   horizontal <- (par("usr")[1] + par("usr")[2]) / 2
#   vertical <- (par("usr")[3] + par("usr")[4]) / 2
#   text(horizontal, vertical, format(cor(x,y, use="complete.obs"), digits=2), cex=1)
# }

panel.cor <- function(x, y, digits=2, prefix="", cex.cor, ...)
{
  usr <- par("usr"); on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  rp <- cor(x, y, method="pearson", use="pairwise.complete.obs")
  rs <- cor(x, y, method="spearman", use="pairwise.complete.obs")
  rp <- format(rp, digits=digits)
  rs <- format(rs, digits=digits)
  txt <- substitute(list(R[p] == rp, R[s] == rs), list(rp=rp, rs=rs))
  txta <- substitute(R[p] == rp, list(rp=rp))
  txtb <- substitute(R[s] == rs, list(rs=rs))
  if(missing(cex.cor)) cex.cor <- 0.8/strwidth(txt)
  text(0.5, 0.6, txta, cex = .9)
  text(0.5, 0.4, txtb, cex = .9)
}
panel.points <- function(x, y) {
  points(x, y, pch=20)
}

plot.script <- function()
{
  if (region == "USR") {
    source("~/Projects/Thesis/Thesis-Calcs/R/USR CSe/USRCSeSubScript.R")
  }
  if (region == "DSR") {
    source("~/Projects/Thesis/Thesis-Calcs/R/DSR CSe/DSRCSeSubScript.R")
  }
}

lmStatsFunction <- function(model, existing, writeFile)
{
  nas <- model$na.action[]
  if(is.null(nas)){a <- existing} else {a <- existing[-nas]}
  b <- model$fitted
  c <- model$resid
  stats <- signif(rbind(Measures=data.frame(Min=min(a, na.rm=T),
                            P_2.5=quantile(a, 0.025, na.rm=T),
                            Mean=mean(a, na.rm=T),
                            P_97.5=quantile(a, 0.975, na.rm=T),
                            Max=max(a, na.rm=T),
                            SD=sd(a, na.rm=T),
                            Skew=skewness(a, na.rm=T),
                            Kurt=kurtosis(a, na.rm=T)),
               Fitted=data.frame(Min=min(b, na.rm=T),
                                 P_2.5=quantile(b, 0.025, na.rm=T),
                                 Mean=mean(b, na.rm=T),
                                 P_97.5=quantile(b, 0.975, na.rm=T),
                                 Max=max(b, na.rm=T),
                                 SD=sd(b, na.rm=T),
                                 Skew=skewness(b, na.rm=T),
                                 Kurt=kurtosis(b, na.rm=T)),
               Residuals=data.frame(Min=min(c, na.rm=T),
                            P_2.5=quantile(c, 0.025, na.rm=T),
                            Mean=mean(c, na.rm=T),
                            P_97.5=quantile(c, 0.975, na.rm=T),
                            Max=max(c, na.rm=T),
                            SD=sd(c, na.rm=T),
                            Skew=skewness(c, na.rm=T),
                            Kurt=kurtosis(c, na.rm=T))),4)
  
  zz <- textConnection("foo", open="w")
  sink(zz)
  cat("\n\nChosen Regression Summary of Analysis\n")
  print(summary(model))
  cat("\n\nStatistics of Measured, Fitted, and Residual values\n\n")
  print(stats)
  sink()
  close(zz)
  write(foo, writeFile, append=FALSE)
}

nlsStatsFunction <- function(model, existing, writeFile)
{
  nas <- summary(lm.x)$na.action
  if(is.null(nas)){a <- existing} else {a <- existing[-existing]}
  b <- nlsResiduals(lm.x)$resi1[,1]
  c <- nlsResiduals(lm.x)$resi1[,2]
  stats <- signif(rbind(Measures=data.frame(Min=min(a, na.rm=T),
                                            P_2.5=quantile(a, 0.025, na.rm=T),
                                            Mean=mean(a, na.rm=T),
                                            P_97.5=quantile(a, 0.975, na.rm=T),
                                            Max=max(a, na.rm=T),
                                            SD=sd(a, na.rm=T),
                                            Skew=skewness(a, na.rm=T),
                                            Kurt=kurtosis(a, na.rm=T)),
                        Fitted=data.frame(Min=min(b, na.rm=T),
                                          P_2.5=quantile(b, 0.025, na.rm=T),
                                          Mean=mean(b, na.rm=T),
                                          P_97.5=quantile(b, 0.975, na.rm=T),
                                          Max=max(b, na.rm=T),
                                          SD=sd(b, na.rm=T),
                                          Skew=skewness(b, na.rm=T),
                                          Kurt=kurtosis(b, na.rm=T)),
                        Residuals=data.frame(Min=min(c, na.rm=T),
                                             P_2.5=quantile(c, 0.025, na.rm=T),
                                             Mean=mean(c, na.rm=T),
                                             P_97.5=quantile(c, 0.975, na.rm=T),
                                             Max=max(c, na.rm=T),
                                             SD=sd(c, na.rm=T),
                                             Skew=skewness(c, na.rm=T),
                                             Kurt=kurtosis(c, na.rm=T))),4)
  
  zz <- textConnection("foo", open="w")
  sink(zz)
  cat("\n\nChosen Regression Summary of Analysis\n")
  print(summary(model))
  cat("\n\nStatistics of Measured, Fitted, and Residual values\n\n")
  print(stats)
  sink()
  close(zz)
  write(foo, writeFile, append=FALSE)
}