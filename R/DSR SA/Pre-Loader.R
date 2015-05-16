###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Calcs/DSR/Data/"
  
  plotFile <- "~/Projects/Calcs/DSR/Plots/SA/"
  
  results.SA <- "~/Projects/Calcs/DSR/Results/SA/"
  
  models.S <- "~/Projects/Calcs/DSR/Models/Stochastic/"
  models.D <- "~/Projects/Calcs/DSR/Models/Deterministic/"
  models.SA <- "~/Projects/Calcs/DSR/Models/SA/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Calcs/R/SubScripts/Pre-Loader-Super.R")