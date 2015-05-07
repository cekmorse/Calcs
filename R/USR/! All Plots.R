if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Plots/Plots ATM.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Plots/Plots Conc.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Plots/Plots River Geometry.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Plots/Plots Transport and Storage.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Plots/Plots Variable Realization.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Plots/Plots Water and Mass Model.R")
} else {
  ## Windows file system
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Atm Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Conc Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR River Geometry Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Transport and Storage Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Variable Realization Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Water and Mass Model Plots.R")
}