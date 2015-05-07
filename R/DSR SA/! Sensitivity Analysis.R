inFolder <- "C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\DSR Output\\Deterministic"
outFolder <- "C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\DSR Output\\SA"
stochFolder <- "C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\DSR Output\\Stochastic"

setwd(inFolder)
load("calcData.Rdata")
setwd(outFolder)

ii <- 1

for(ii in 1:49){
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
  if(ii == 13){name <- "qBIG"; mod <- "+20%"; cd2$q.BIG <- calcData$q.BIG * 1.2}
  if(ii == 14){name <- "qBIG"; mod <- "-20%"; cd2$q.BIG <- calcData$q.BIG * 0.8}
  if(ii == 15){name <- "qWIL"; mod <- "+20%"; cd2$q.WIL <- calcData$q.WIL * 1.2}
  if(ii == 16){name <- "qWIL"; mod <- "-20%"; cd2$q.WIL <- calcData$q.WIL * 0.8}
  if(ii == 17){name <- "qBUF"; mod <- "+20%"; cd2$q.BUF <- calcData$q.BUF * 1.2}
  if(ii == 18){name <- "qBUF"; mod <- "-20%"; cd2$q.BUF <- calcData$q.BUF * 0.8}
  if(ii == 19){name <- "qFRO"; mod <- "+20%"; cd2$q.FRO <- calcData$q.FRO * 1.2}
  if(ii == 20){name <- "qFRO"; mod <- "-20%"; cd2$q.FRO <- calcData$q.FRO * 0.8}
  if(ii == 21){name <- "p"; mod <- "+25%"; cd2$p <- calcData$p * 1.25}
  if(ii == 22){name <- "p"; mod <- "-25%"; cd2$p <- calcData$p * 0.75}
  if(ii == 23){name <- "et"; mod <- "+0.98mm"; cd2$et <- calcData$et + 0.00098}
  if(ii == 24){name <- "et"; mod <- "-0.98mm"; cd2$et <- calcData$et - 0.00098}
  if(ii == 25){name <- "u2"; mod <- "+0.5mps"; cd2$u2 <- calcData$u2 + 0.5}
  if(ii == 26){name <- "u2"; mod <- "-0.5mps"; cd2$u2 <- calcData$u2 - 0.5}
  if(ii == 27){name <- "RHmin"; mod <- "+2%"; cd2$RHmin <- calcData$RHmin * 1.02}
  if(ii == 28){name <- "RHmin"; mod <- "-2%"; cd2$RHmin <- calcData$RHmin * 0.98}
  if(ii == 29){name <- "B1"; mod <- "+10%"; cd2$geomB1 <- calcData$geomB1 * 1.1}
  if(ii == 30){name <- "B1"; mod <- "-10%"; cd2$geomB1 <- calcData$geomB1 * 0.9}
  if(ii == 31){name <- "B2"; mod <- "+10%"; cd2$geomB2 <- calcData$geomB2 * 1.1}
  if(ii == 32){name <- "B2"; mod <- "-10%"; cd2$geomB2 <- calcData$geomB2 * 0.9}
  if(ii == 33){name <- "depthF"; mod <- "+0.01ft"; cd2$dF1 <- calcData$dF1 + 0.01}
  if(ii == 34){name <- "depthF"; mod <- "-0.01ft"; cd2$dF1 <- calcData$dF1 - 0.01}
  if(ii == 35){name <- "depthG"; mod <- "+0.01ft"; cd2$dG1 <- calcData$dG1 + 0.01}
  if(ii == 36){name <- "depthG"; mod <- "-0.01ft"; cd2$dG1 <- calcData$dG1 - 0.01}
  if(ii == 37){name <- "depthF"; mod <- "+0.05ft"; cd2$dF1 <- calcData$dF1 + 0.05}
  if(ii == 38){name <- "depthF"; mod <- "-0.05ft"; cd2$dF1 <- calcData$dF1 - 0.05}
  if(ii == 39){name <- "depthG"; mod <- "+0.05ft"; cd2$dG1 <- calcData$dG1 + 0.05}
  if(ii == 40){name <- "depthG"; mod <- "-0.05ft"; cd2$dG1 <- calcData$dG1 - 0.05}
  if(ii == 41){name <- "depthF"; mod <- "+0.1ft"; cd2$dF1 <- calcData$dF1 + 0.1}
  if(ii == 42){name <- "depthF"; mod <- "-0.1ft"; cd2$dF1 <- calcData$dF1 - 0.1}
  if(ii == 43){name <- "depthG"; mod <- "+0.1ft"; cd2$dG1 <- calcData$dG1 + 0.1}
  if(ii == 44){name <- "depthG"; mod <- "-0.1ft"; cd2$dG1 <- calcData$dG1 - 0.1}
  if(ii == 45){name <- "depthF"; mod <- "+0.25ft"; cd2$dF1 <- calcData$dF1 + 0.25}
  if(ii == 46){name <- "depthF"; mod <- "-0.25ft"; cd2$dF1 <- calcData$dF1 - 0.25}
  if(ii == 47){name <- "depthG"; mod <- "+0.25ft"; cd2$dG1 <- calcData$dG1 + 0.25}
  if(ii == 48){name <- "depthG"; mod <- "-0.25ft"; cd2$dG1 <- calcData$dG1 - 0.25}
  if(ii == 49){name <- "base"; mod <- "none"}
  
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR SA\\DSR River Geometry.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR SA\\DSR Conc Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR SA\\DSR Transport and Storage.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR SA\\DSR ETref to Evap Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR SA\\DSR Water and Mass Models.R")
  
  if(ii == 1){
    water <- data.frame(vName=name, Mod=mod, unknownWaterStatsStats[1:3], row.names=ii)
  }  else {
    water <- rbind(water, data.frame(vName=name, Mod=mod, unknownWaterStatsStats[1:3], row.names=ii))
  }
  
  if(ii == 1){
    mass <- data.frame(vName=name, Mod=mod, unknownMassStatsStats[1:3], row.names=ii)
  }  else {
    mass <- rbind(mass, data.frame(vName=name, Mod=mod, unknownMassStatsStats[1:3], row.names=ii))
  }
  
  print(ii); flush.console()
}

water <- cbind(water, dMean = (water$Mean - water$Mean[length(water$Mean)] )/ water$Mean[length(water$Mean)] * 100)
mass <- cbind(mass, dMean = (mass$Mean - mass$Mean[length(mass$Mean)] )/ mass$Mean[length(mass$Mean)] * 100)

water[,3:6] <- signif(water[,3:6], 4)
mass[,3:6] <- signif(mass[,3:6], 4)

write.csv(water, file="water change.csv")
write.csv(mass, file="mass change.csv")

rm(list=ls())
