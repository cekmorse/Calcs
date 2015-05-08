###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Calcs/DSR/Data/"
  
  plotFile <- "~/Projects/Calcs/DSR/Plots/Stochastic/"
  plot.D <- "~/Projects/Calcs/DSR/Plots/Deterministic/"
  
  resultsFile <- "~/Projects/Calcs/DSR/Results/Stochastic/"
  results.AS <- "~/Projects/Calcs/DSR/Results/Stochastic-AS/"
  results.A <- "~/Projects/Calcs/DSR/Results/Stochastic-A/"
  results.S <- "~/Projects/Calcs/DSR/Results/Stochastic-S/"
  results.D <- "~/Projects/Calcs/DSR/Results/Deterministic/"
  
  modelsFile <- "~/Projects/Calcs/DSR/Models/Stochastic/"
  models.AS <- "~/Projects/Calcs/DSR/Models/Stochastic-AS/"
  models.A <- "~/Projects/Calcs/DSR/Models/Stochastic-A/"
  models.S <- "~/Projects/Calcs/DSR/Models/Stochastic-S/"
  models.D <- "~/Projects/Calcs/DSR/Models/Deterministic/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Calcs/R/SubScripts/Pre-Loader-Super.R")



