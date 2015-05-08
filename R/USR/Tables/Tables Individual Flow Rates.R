##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(findFile) {
  setwd(models.D)
  x <- load(paste(findFile, ".Rdata", sep=""))
  determ <- get(x)
  setwd(modelsFile)
  x <- load(paste(findFile, ".Rdata", sep=""))
  stoch <- get(x) ; rm(list=x)
  returnList <- list("determ"=determ, "stoch"=stoch)
  return(returnList)
}

textTablesFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 35.3146667   # convert to cfs

findFile <- "qin"
saveFile <- "USR_qIN.txt"
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qout"
saveFile <- "USR_qOUT.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qCAN"
saveFile <- "USR_qCAN.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qCON"
saveFile <- "USR_qCON.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qFLS"
saveFile <- "USR_qFLS.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qFLY"
saveFile <- "USR_qFLY.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qHOL"
saveFile <- "USR_qHOL.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qHRC"
saveFile <- "USR_qHRC.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qRFD"
saveFile <- "USR_qRFD.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qRFR"
saveFile <- "USR_qRFR.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qTIM"
saveFile <- "USR_qTIM.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "qWTP"
saveFile <- "USR_qWTP.txt"
# in m^3/(sec*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)


rm(list=ls())