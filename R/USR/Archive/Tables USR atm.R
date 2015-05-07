##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

yline <- NA
y <- data.frame(matrix(NA,nrow=4, ncol=6))
for(i in 1:4){
  if(i == 1){
    setwd(models.D)
    load("et.Rdata"); dx <- as.vector(as.matrix(et)); dx <- dx/1000
    setwd(modelsFile)
    load("et.Rdata"); sx <- as.vector(as.matrix(et)); sx <- sx/1000
    rm(et)
  }
  if(i == 2){
    setwd(models.D)
    load("A Kw.Rdata"); dx <- as.vector(as.matrix(Kw)); dx <- dx/1000
    setwd(modelsFile)
    load("A Kw.Rdata"); sx <- as.vector(as.matrix(Kw)); sx <- sx/1000
    rm(Kw)
  }
  if(i == 3){
    setwd(models.D)
    load("A evap.Rdata"); dx <- as.vector(as.matrix(Evap)); dx <- dx/1000
    setwd(modelsFile)
    load("A evap.Rdata"); sx <- as.vector(as.matrix(Evap)); sx <- sx/1000
    rm(Evap)
  }
  if(i == 4){
    setwd(models.D)
    load("p.Rdata"); dx <- as.vector(as.matrix(p)); dx <- dx/1000
    setwd(modelsFile)
    load("p.Rdata"); sx <- as.vector(as.matrix(p)); sx <- sx/1000
    rm(p)
  }

  dy <- signif(cbind(quantile(dx,0.025,na.rm=TRUE),
                          mean(dx, na.rm=TRUE),
                          quantile(dx,0.975,na.rm=TRUE), row.names=NULL),4)
  sy <- signif(cbind(quantile(sx,0.025,na.rm=TRUE),
                     mean(sx, na.rm=TRUE),
                     quantile(sx,0.975,na.rm=TRUE), row.names=NULL),4)
  yline <- cbind(dy,sy)
  y[i,] <- yline
}
locates <- c("$ET_{Ref}$&","$K_{w}$&","Evap. $(E)$&","Precip. $(P)$&")

diffOfMean <- signif((y[,5] - y[,2])/y[,2]*100,3)
y <- data.frame(cbind(y, diffOfMean), row.names=locates)
colnames(y) <- c("d025","dmn","d975","s025","smn","s975","DiffofMean")

setwd(resultsFile)
write.csv(y, file="STATS Atm Table.csv")
rm(list=ls())
