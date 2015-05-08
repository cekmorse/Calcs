###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Calcs/USR/Data/"
  
  plotFile <- "~/Projects/Calcs/USR/Plots/Stochastic/"
  plot.D <- "~/Projects/Calcs/USR/Plots/Deterministic/"
  
  resultsFile <- "~/Projects/Calcs/USR/Results/Stochastic/"
  results.AS <- "~/Projects/Calcs/USR/Results/Stochastic-AS/"
  results.A <- "~/Projects/Calcs/USR/Results/Stochastic-A/"
  results.S <- "~/Projects/Calcs/USR/Results/Stochastic-S/"
  results.D <- "~/Projects/Calcs/USR/Results/Deterministic/"
  
  modelsFile <- "~/Projects/Calcs/USR/Models/Stochastic/"
  models.AS <- "~/Projects/Calcs/USR/Models/Stochastic-AS/"
  models.A <- "~/Projects/Calcs/USR/Models/Stochastic-A/"
  models.S <- "~/Projects/Calcs/USR/Models/Stochastic-S/"
  models.D <- "~/Projects/Calcs/USR/Models/Deterministic/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Calcs/R/SubScripts/Pre-Loader-Super.R")