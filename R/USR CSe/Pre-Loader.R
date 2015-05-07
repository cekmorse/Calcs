###  PROGRAM REQUIREMENTS  ###
list.of.packages <- c("moments", "KernSmooth", "nlstools", "fitdistrplus")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[,"Package"])]
if(length(new.packages)) install.packages(new.packages)
options(warn=-1)
lapply(list.of.packages, require, character.only=T)
options(warn=0)
rm(list.of.packages, new.packages)

###  SET WORKING DIRECTORY  ###
if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  dataFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Data/"
  plotFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Plots/CSe/"
  resultsFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Results/CSe/"
  modelsFile <- "~/Projects/Thesis/Thesis-Calcs/USR/Models/CSe/"
} else {
  ## Windows file naming convention
  ## add these when converting to Windows OS
}

###  LOAD FUNCTIONS  ###
source("~/Projects/Thesis/Thesis-Calcs/R/USR CSe/SeFunctions.R")