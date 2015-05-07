###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Thesis/Thesis-Calcs/DSR/Data/"
  
  plotFile <- "~/Projects/Thesis/Thesis-Calcs/DSR/Plots/Stochastic/"
  plot.D <- "~/Projects/Thesis/Thesis-Calcs/DSR/Plots/Deterministic/"
  
  resultsFile <- "~/Projects/Thesis/Thesis-Calcs/DSR/Results/Stochastic/"
  results.AS <- "~/Projects/Thesis/Thesis-Calcs/DSR/Results/Stochastic-AS/"
  results.A <- "~/Projects/Thesis/Thesis-Calcs/DSR/Results/Stochastic-A/"
  results.S <- "~/Projects/Thesis/Thesis-Calcs/DSR/Results/Stochastic-S/"
  results.D <- "~/Projects/Thesis/Thesis-Calcs/DSR/Results/Deterministic/"
  
  modelsFile <- "~/Projects/Thesis/Thesis-Calcs/DSR/Models/Stochastic/"
  models.AS <- "~/Projects/Thesis/Thesis-Calcs/DSR/Models/Stochastic-AS/"
  models.A <- "~/Projects/Thesis/Thesis-Calcs/DSR/Models/Stochastic-A/"
  models.S <- "~/Projects/Thesis/Thesis-Calcs/DSR/Models/Stochastic-S/"
  models.D <- "~/Projects/Thesis/Thesis-Calcs/DSR/Models/Deterministic/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/Pre-Loader-Super.R")



