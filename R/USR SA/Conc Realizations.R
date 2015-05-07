setwd(inFolder)
seData <- read.csv("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\USR Input\\SeEstData.csv")

lName <- "U163"
locate <- "U163"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "HOL"
locate <- "UDIV"
cMin <- 1.37
di <- 7.8 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "FLS"
locate <- "UDIV"
cMin <- 1.47
di <- 10.2 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "FLY"
locate <- "UDIV"
cMin <- 1.42
di <- 29.3 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "CON"
locate <- "UDIV"
cMin <- 2.26
di <- 52.8 * 5280 * 0.3048 / 1000 
di <- rep(di, dim(calcData)[1])
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "U201"
locate <- "U201"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "RFD"
locate <- "U167"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "TIM"
locate <- "TIM"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "CAN"
locate <- "CAN"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5  
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "HRC"
locate <- "HRC"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5  
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")

lName <- "WTP"
locate <- "WTP"
cMin <- min(seData[seData$locate == locate, "cse"], na.rm=TRUE) * 0.5  
source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\SubScripts\\SA ConcRealizations.R")