source("~/Projects/Calcs/R/USR SA/Pre-Loader.R")

do1River <- function(){
  source("~/Projects/Calcs/R/USR SA/05 River Geometry.R")
}
do2Conc <- function(){
  source("~/Projects/Calcs/R/USR SA/06 Conc Realizations.R")
}
do3Evap <- function(){
  source("~/Projects/Calcs/R/USR SA/07 ETref to Evap Realizations.R")
}
do4Trans <- function(){
  source("~/Projects/Calcs/R/USR SA/09 Transport and Storage.R")
}
do5Models <- function(){
  source("~/Projects/Calcs/R/USR SA/10 Water and Mass Models.R")
}

setwd(models.D)
load("calcData.Rdata")
setwd(models.SA)

ii <- 1

for(ii in 1:85){
  cd2 <- calcData
  if(ii == 1 ){name <- "qin"; mod <- "+10%"; cd2$q.in <- calcData$q.in * 1.1}
  if(ii == 2 ){name <- "qin"; mod <- "-10%"; cd2$q.in <- calcData$q.in * 0.9}
  if(ii == 3 ){name <- "ecin"; mod <- "+10%"; cd2$ec.in <- calcData$ec.in * 1.1}
  if(ii == 4 ){name <- "ecin"; mod <- "-10%"; cd2$ec.in <- calcData$ec.in * 0.9}
  if(ii == 5 ){name <- "tin"; mod <- "+5C"; cd2$t.in <- calcData$t.in + 0.5}
  if(ii == 6 ){name <- "tin"; mod <- "-5C"; cd2$t.in <- calcData$t.in - 0.5}
  if(ii == 7 ){name <- "qout"; mod <- "+10%"; cd2$q.out <- calcData$q.out * 1.15}
  if(ii == 8 ){name <- "qout"; mod <- "-10%"; cd2$q.out <- calcData$q.out * 0.85}
  if(ii == 9 ){name <- "ecout"; mod <- "+10%"; cd2$ec.out <- calcData$ec.out * 1.1}
  if(ii == 10){name <- "ecout"; mod <- "-10%"; cd2$ec.out <- calcData$ec.out * 0.9}
  if(ii == 11){name <- "tout"; mod <- "+5C"; cd2$t.out <- calcData$t.out + 0.5}
  if(ii == 12){name <- "tout"; mod <- "-5C"; cd2$t.out <- calcData$t.out - 0.5}
  if(ii == 13){name <- "qHOL"; mod <- "+20%"; cd2$q.HOL <- calcData$q.HOL * 1.2}
  if(ii == 14){name <- "qHOL"; mod <- "-20%"; cd2$q.HOL <- calcData$q.HOL * 0.8}
  if(ii == 15){name <- "qRFD"; mod <- "+20%"; cd2$q.RFD <- calcData$q.RFD * 1.2}
  if(ii == 16){name <- "qRFD"; mod <- "-20%"; cd2$q.RFD <- calcData$q.RFD * 0.8}
  if(ii == 17){name <- "qFLS"; mod <- "+20%"; cd2$q.FLS <- calcData$q.FLS * 1.2}
  if(ii == 18){name <- "qFLS"; mod <- "-20%"; cd2$q.FLS <- calcData$q.FLS * 0.8}
  if(ii == 19){name <- "qRFR"; mod <- "+20%"; cd2$q.RFR <- calcData$q.RFR * 1.2}
  if(ii == 20){name <- "qRFR"; mod <- "-20%"; cd2$q.RFR <- calcData$q.RFR * 0.8}
  if(ii == 21){name <- "qTIM"; mod <- "+15%"; cd2$q.TIM <- calcData$q.TIM * 1.15}
  if(ii == 22){name <- "qTIM"; mod <- "-15%"; cd2$q.TIM <- calcData$q.TIM * 0.85}
  if(ii == 23){name <- "qFLY"; mod <- "+20%"; cd2$q.FLY <- calcData$q.FLY * 1.2}
  if(ii == 24){name <- "qFLY"; mod <- "-20%"; cd2$q.FLY <- calcData$q.FLY * 0.8}
  if(ii == 25){name <- "qCAN"; mod <- "+15%"; cd2$q.CAN <- calcData$q.CAN * 1.15}
  if(ii == 26){name <- "qCAN"; mod <- "-15%"; cd2$q.CAN <- calcData$q.CAN * 0.85}
  if(ii == 27){name <- "qCON"; mod <- "+20%"; cd2$q.CON <- calcData$q.CON * 1.2}
  if(ii == 28){name <- "qCON"; mod <- "-20%"; cd2$q.CON <- calcData$q.CON * 0.8}
  if(ii == 29){name <- "qHRC"; mod <- "+20%"; cd2$q.HRC <- calcData$q.HRC * 1.2}
  if(ii == 30){name <- "qHRC"; mod <- "-20%"; cd2$q.HRC <- calcData$q.HRC * 0.8}
  if(ii == 31){name <- "qWTP"; mod <- "+15%"; cd2$q.WTP <- calcData$q.WTP * 1.15}
  if(ii == 32){name <- "qWTP"; mod <- "-15%"; cd2$q.WTP <- calcData$q.WTP * 0.85}
  if(ii == 33){name <- "p"; mod <- "+25%"; cd2$p <- calcData$p * 1.25}
  if(ii == 34){name <- "p"; mod <- "-25%"; cd2$p <- calcData$p * 0.75}
  if(ii == 35){name <- "et"; mod <- "+0.98mm"; cd2$et <- calcData$et + 0.00098}
  if(ii == 36){name <- "et"; mod <- "-0.98mm"; cd2$et <- calcData$et - 0.00098}
  if(ii == 37){name <- "u2"; mod <- "+0.5mps"; cd2$u2 <- calcData$u2 + 0.5}
  if(ii == 38){name <- "u2"; mod <- "-0.5mps"; cd2$u2 <- calcData$u2 - 0.5}
  if(ii == 39){name <- "RHmin"; mod <- "+2%"; cd2$RHmin <- calcData$RHmin * 1.02}
  if(ii == 40){name <- "RHmin"; mod <- "-2%"; cd2$RHmin <- calcData$RHmin * 0.98}
  if(ii == 41){name <- "B1"; mod <- "+10%"; cd2$geomB1 <- calcData$geomB1 * 1.1}
  if(ii == 42){name <- "B1"; mod <- "-10%"; cd2$geomB1 <- calcData$geomB1 * 0.9}
  if(ii == 43){name <- "B2"; mod <- "+10%"; cd2$geomB2 <- calcData$geomB2 * 1.1}
  if(ii == 44){name <- "B2"; mod <- "-10%"; cd2$geomB2 <- calcData$geomB2 * 0.9}
  if(ii == 45){name <- "depthA"; mod <- "+0.01ft"; cd2$dA1 <- calcData$dA1 + 0.01}
  if(ii == 46){name <- "depthA"; mod <- "-0.01ft"; cd2$dA1 <- calcData$dA1 - 0.01}
  if(ii == 47){name <- "depthB"; mod <- "+0.01ft"; cd2$dB1 <- calcData$dB1 + 0.01}
  if(ii == 48){name <- "depthB"; mod <- "-0.01ft"; cd2$dB1 <- calcData$dB1 - 0.01}
  if(ii == 49){name <- "depthC"; mod <- "+0.01ft"; cd2$dC1 <- calcData$dC1 + 0.01}
  if(ii == 50){name <- "depthC"; mod <- "-0.01ft"; cd2$dC1 <- calcData$dC1 - 0.01}
  if(ii == 51){name <- "depthD"; mod <- "+0.01ft"; cd2$dD1 <- calcData$dD1 + 0.01}
  if(ii == 52){name <- "depthD"; mod <- "-0.01ft"; cd2$dD1 <- calcData$dD1 - 0.01}
  if(ii == 53){name <- "depthE"; mod <- "+0.01ft"; cd2$dE1 <- calcData$dE1 + 0.01}
  if(ii == 54){name <- "depthE"; mod <- "-0.01ft"; cd2$dE1 <- calcData$dE1 - 0.01}
  if(ii == 55){name <- "depthA"; mod <- "+0.05ft"; cd2$dA1 <- calcData$dA1 + 0.05}
  if(ii == 56){name <- "depthA"; mod <- "-0.05ft"; cd2$dA1 <- calcData$dA1 - 0.05}
  if(ii == 57){name <- "depthB"; mod <- "+0.05ft"; cd2$dB1 <- calcData$dB1 + 0.05}
  if(ii == 58){name <- "depthB"; mod <- "-0.05ft"; cd2$dB1 <- calcData$dB1 - 0.05}
  if(ii == 59){name <- "depthC"; mod <- "+0.05ft"; cd2$dC1 <- calcData$dC1 + 0.05}
  if(ii == 60){name <- "depthC"; mod <- "-0.05ft"; cd2$dC1 <- calcData$dC1 - 0.05}
  if(ii == 61){name <- "depthD"; mod <- "+0.05ft"; cd2$dD1 <- calcData$dD1 + 0.05}
  if(ii == 62){name <- "depthD"; mod <- "-0.05ft"; cd2$dD1 <- calcData$dD1 - 0.05}
  if(ii == 63){name <- "depthE"; mod <- "+0.05ft"; cd2$dE1 <- calcData$dE1 + 0.05}
  if(ii == 64){name <- "depthE"; mod <- "-0.05ft"; cd2$dE1 <- calcData$dE1 - 0.05}
  if(ii == 65){name <- "depthA"; mod <- "+0.1ft"; cd2$dA1 <- calcData$dA1 + 0.1}
  if(ii == 66){name <- "depthA"; mod <- "-0.1ft"; cd2$dA1 <- calcData$dA1 - 0.1}
  if(ii == 67){name <- "depthB"; mod <- "+0.1ft"; cd2$dB1 <- calcData$dB1 + 0.1}
  if(ii == 68){name <- "depthB"; mod <- "-0.1ft"; cd2$dB1 <- calcData$dB1 - 0.1}
  if(ii == 69){name <- "depthC"; mod <- "+0.1ft"; cd2$dC1 <- calcData$dC1 + 0.1}
  if(ii == 70){name <- "depthC"; mod <- "-0.1ft"; cd2$dC1 <- calcData$dC1 - 0.1}
  if(ii == 71){name <- "depthD"; mod <- "+0.1ft"; cd2$dD1 <- calcData$dD1 + 0.1}
  if(ii == 72){name <- "depthD"; mod <- "-0.1ft"; cd2$dD1 <- calcData$dD1 - 0.1}
  if(ii == 73){name <- "depthE"; mod <- "+0.1ft"; cd2$dE1 <- calcData$dE1 + 0.1}
  if(ii == 74){name <- "depthE"; mod <- "-0.1ft"; cd2$dE1 <- calcData$dE1 - 0.1}
  if(ii == 75){name <- "depthA"; mod <- "+0.25ft"; cd2$dA1 <- calcData$dA1 + 0.25}
  if(ii == 76){name <- "depthA"; mod <- "-0.25ft"; cd2$dA1 <- calcData$dA1 - 0.25}
  if(ii == 77){name <- "depthB"; mod <- "+0.25ft"; cd2$dB1 <- calcData$dB1 + 0.25}
  if(ii == 78){name <- "depthB"; mod <- "-0.25ft"; cd2$dB1 <- calcData$dB1 - 0.25}
  if(ii == 79){name <- "depthC"; mod <- "+0.25ft"; cd2$dC1 <- calcData$dC1 + 0.25}
  if(ii == 80){name <- "depthC"; mod <- "-0.25ft"; cd2$dC1 <- calcData$dC1 - 0.25}
  if(ii == 81){name <- "depthD"; mod <- "+0.25ft"; cd2$dD1 <- calcData$dD1 + 0.25}
  if(ii == 82){name <- "depthD"; mod <- "-0.25ft"; cd2$dD1 <- calcData$dD1 - 0.25}
  if(ii == 83){name <- "depthE"; mod <- "+0.25ft"; cd2$dE1 <- calcData$dE1 + 0.25}
  if(ii == 84){name <- "depthE"; mod <- "-0.25ft"; cd2$dE1 <- calcData$dE1 - 0.25}
  if(ii == 85){name <- "base"; mod <- "none"}
  
  do1River()
  do2Conc()
  do3Evap()
  do4Trans()
  do5Models()
  
  if(ii == 1){
    water <- data.frame(vName=name, Mod=mod, unknownWaterStatsStats[2], row.names=ii)
  }  else {
    water <- rbind(water, data.frame(vName=name, Mod=mod, unknownWaterStatsStats[2], row.names=ii))
  }
    
  if(ii == 1){
    mass <- data.frame(vName=name, Mod=mod, unknownMassStatsStats[2], row.names=ii)
  }  else {
    mass <- rbind(mass, data.frame(vName=name, Mod=mod, unknownMassStatsStats[2], row.names=ii))
  }
  print(ii); flush.console()
}

water <- cbind(water, dMean = (water$Mean - water$Mean[length(water$Mean)] )/ water$Mean[length(water$Mean)] * 100)
mass <- cbind(mass, dMean = (mass$Mean - mass$Mean[length(mass$Mean)] )/ mass$Mean[length(mass$Mean)] * 100)

water[,3:4] <- signif(water[,3:4], 3)
mass[,3:4] <- signif(mass[,3:4], 3)

setwd(results.SA)
write.csv(water, file="water change.csv")
write.csv(mass, file="mass change.csv")

rm(list=ls())
