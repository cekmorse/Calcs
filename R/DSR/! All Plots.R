if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Calcs/R/DSR/Plots/Plots ATM.R")
  print("done ATM")
  source("~/Projects/Calcs/R/DSR/Plots/Plots Conc.R")
  print("done Concentrations")
  source("~/Projects/Calcs/R/DSR/Plots/Plots River Geometry.R")
  print("done River Geometry")
  source("~/Projects/Calcs/R/DSR/Plots/Plots Transport and Storage.R")
  print("done Transport and Storage")
  source("~/Projects/Calcs/R/DSR/Plots/Plots Variable Realizations.R")
  print("done Variable Realization")
  source("~/Projects/Calcs/R/DSR/Plots/Plots Water and Mass Model.R")
  print("done All")
} else {
  ## Windows file system

}