setwd(inFolder)
seData <- read.csv("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\DSR Input\\SeEstData.csv")

lName <- "D101C"
locate <- "D101C"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "D106C"
locate <- "D106C"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "BUF"
locate <- "DDIV"
cMin <- 2.5
di <- 23.4 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "BIG"
locate <- "BIG"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "WIL"
locate <- "WIL"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")