##### General Setup #####
source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run1 <- function(findFile) {
  setwd(models.D)
  x <- load(paste("m ", findFile, ".Rdata", sep=""))
  determ <- get(x)
  setwd(modelsFile)
  x <- load(paste("m ", findFile, ".Rdata", sep=""))
  stoch <- get(x) ; rm(list=x)
  returnList <- list("determ"=determ, "stoch"=stoch)
  return(returnList)
}

textTablesFolder <- "~/Projects/Thesis/Thesis-Text/Tables/"

findFile <- "storageChange"
saveFile <- "USRVolume.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 70.0456199   # convert to acre-foot/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "atmChange"
saveFile <- "USRAtm.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 70.0456199   # convert to acre-foot/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "flowChange"
saveFile <- "USRFlow.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 56.833447   # convert to cfs/mile
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "unknownWater"
saveFile <- "USR_UNPS.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 70.0456199   # convert to acre-foot/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)



findFile <- "massFlux"
saveFile <- "USRMassFlux.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
unitConvert <- 2.20462262   # convert to lb/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "massStoreChange"
saveFile <- "USRMassStore.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
unitConvert <- 2.20462262   # convert to lb/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "unknownMass"
saveFile <- "USRMass_UNPS.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
unitConvert <- 2.20462262   # convert to lb/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)
