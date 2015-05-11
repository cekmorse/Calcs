##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

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

textTablesFolder <- "~/Projects/Text/Tables/"

findFile <- "storageChange"
saveFile <- "DSRVolume.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 70.0456199   # convert to acre-foot/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "atmChange"
saveFile <- "DSRAtm.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 70.0456199   # convert to acre-foot/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "flowChange"
saveFile <- "DSRFlow.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 56.833447   # convert to cfs/mile
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "unknownWater"
saveFile <- "DSR_UNPS.txt"
# in m^3/(sec*km)
scaleConvert <- 1           # no scaling
unitConvert <- 70.0456199   # convert to acre-foot/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)



findFile <- "massFlux"
saveFile <- "DSRMassFlux.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
unitConvert <- 2.20462262   # convert to lb/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "massStoreChange"
saveFile <- "DSRMassStore.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
unitConvert <- 2.20462262   # convert to lb/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "unknownMass"
saveFile <- "DSRMass_UNPS.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
unitConvert <- 2.20462262   # convert to lb/(day*km)
results <- run1(findFile)
makeTable(results$determ, results$stoch, scaleConvert, unitConvert, textTablesFolder, saveFile)

findFile <- "unknownC"
saveFile <- "DSR_C_UNPS.txt"
# in kg/(day*km) 
scaleConvert <- 1           # no scaling
results <- run1(findFile)
makeSimpleTable(results$determ, results$stoch, scaleConvert, textTablesFolder, saveFile)
