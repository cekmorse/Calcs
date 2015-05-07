###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Data/"
  
  plotFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Plots/Stochastic/"
  plot.D <- "~/Projects/Thesis/Thesis-Calcs/USR/Plots/Deterministic/"
  
  resultsFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Results/Stochastic/"
  results.AS <- "~/Projects/Thesis/Thesis-Calcs/USR/Results/Stochastic-AS/"
  results.A <- "~/Projects/Thesis/Thesis-Calcs/USR/Results/Stochastic-A/"
  results.S <- "~/Projects/Thesis/Thesis-Calcs/USR/Results/Stochastic-S/"
  results.D <- "~/Projects/Thesis/Thesis-Calcs/USR/Results/Deterministic/"
  
  modelsFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Models/Stochastic/"
  models.AS <- "~/Projects/Thesis/Thesis-Calcs/USR/Models/Stochastic-AS/"
  models.A <- "~/Projects/Thesis/Thesis-Calcs/USR/Models/Stochastic-A/"
  models.S <- "~/Projects/Thesis/Thesis-Calcs/USR/Models/Stochastic-S/"
  models.D <- "~/Projects/Thesis/Thesis-Calcs/USR/Models/Deterministic/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/Pre-Loader-Super.R")