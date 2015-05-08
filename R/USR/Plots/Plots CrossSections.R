##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

setwd(dataFile)
# Trim depths to 0.5 <= H <= 5'
ds <- read.csv("TW_USR.csv")
ds <- ds[which(ds$H <= 5*0.3048 & ds$H >= 0.5*0.3048 ),]

setwd(modelsFile)
load("AB.Rdata")

setwd(plotFile)
for(i in 1:(max(ds$Section)-1)){
  sub <- ds[ds$Section == i,]
  if (length(sub[,1]) != 0 )
  {
    
    b1 <- AB[rownames(AB) == i,1]
    b2 <- AB[rownames(AB) == i,2]
    rs <- AB[rownames(AB) == i,3]
    eq <- bquote(beta[1]==.(signif(b1,4))~~~~~beta[2]==.(signif(b2,4))~~~~~RMSE==.(signif(rs,4)))
    est <- b1*sub$H^b2
    pdf(file=paste("Survey Tw vs H-Section ",i,".pdf", sep=""), width=6, height=6, family="Times")
    par(mar=c(5.1,4.1,2.1,1.1))
    plot(sub$Tw, sub$H, pch=20, xlab ="Top Width (Tw) (m)", ylab="Flow Depth (y) (m)")
    lines(sub$Tw, sub$H)
    points(est, sub$H, pch=20, col="red")
    lines(est, sub$H, col="red")
    mtext(eq, 3, line=0, adj=0)
    legend("topleft", 
           legend=c("Observed", "Predicted"), 
           col=c("black","red"),
           pch=c(20,20),
           lty=c(1,1))
    dev.off()
  }
}
rm(list=ls())
