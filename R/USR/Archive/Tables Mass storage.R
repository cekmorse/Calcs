##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/USR/Pre-Loader.R")

setwd(modelsFile)

yline <- NA
y <- data.frame(matrix(NA,nrow=5, ncol=6))
for(i in 1:5){
  if(i == 1){
    setwd(models.D)
    load("f Segment A.Rdata"); dx <- as.vector(as.matrix(f.A))
    setwd(modelsFile)
    load("f Segment A.Rdata"); sx <- as.vector(as.matrix(f.A))
    rm(f.A)
  }
  if(i == 2){
    setwd(models.D)
    load("f Segment B.Rdata"); dx <- as.vector(as.matrix(f.B))
    setwd(modelsFile)
    load("f Segment B.Rdata"); sx <- as.vector(as.matrix(f.B))
    rm(f.B)
  }
  if(i == 3){
    setwd(models.D)
    load("f Segment C.Rdata"); dx <- as.vector(as.matrix(f.C))
    setwd(modelsFile)
    load("f Segment C.Rdata"); sx <- as.vector(as.matrix(f.C))
    rm(f.C)
  }
  if(i == 4){
    setwd(models.D)
    load("f Segment D.Rdata"); dx <- as.vector(as.matrix(f.D))
    setwd(modelsFile)
    load("f Segment D.Rdata"); sx <- as.vector(as.matrix(f.D))
    rm(f.D)
  }
  if(i == 5){
    setwd(models.D)
    load("f Segment E.Rdata"); dx <- as.vector(as.matrix(f.E))
    setwd(modelsFile)
    load("f Segment E.Rdata"); sx <- as.vector(as.matrix(f.E))
    rm(f.E)
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
locates <- c("$Delta M_A$&","$Delta M_B$&","$Delta M_C$&","$Delta M_D$&","$Delta M_E$&")
diffOfMean <- signif((y[,5] - y[,2])/y[,2]*100,3)
y <- data.frame(cbind(y, diffOfMean), row.names=locates)
colnames(y) <- c("d025","dmn","d975","s025","smn","s975","DiffofMean")

setwd(resultsFile)
write.csv(y, file="STATS Mass Storage Table.csv")

rm(list=ls())
