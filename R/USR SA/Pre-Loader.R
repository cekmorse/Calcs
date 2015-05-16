###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Calcs/USR/Data/"
  
  plotFile <- "~/Projects/Calcs/USR/Plots/SA/"
  
  results.SA <- "~/Projects/Calcs/USR/Results/SA/"
  
  models.S <- "~/Projects/Calcs/USR/Models/Stochastic/"
  models.D <- "~/Projects/Calcs/USR/Models/Deterministic/"
  models.SA <- "~/Projects/Calcs/USR/Models/SA/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Calcs/R/SubScripts/Pre-Loader-Super.R")