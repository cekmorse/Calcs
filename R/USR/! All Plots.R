if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Calcs/R/USR/Plots/Plots ATM.R")
  print("Done ATM")
  source("~/Projects/Calcs/R/USR/Plots/Plots Conc.R")
  print("Done Concentration")
  source("~/Projects/Calcs/R/USR/Plots/Plots River Geometry.R")
  print("Done River Geometry")
  source("~/Projects/Calcs/R/USR/Plots/Plots Transport and Storage.R")
  print("Done Transport and Storage")
  source("~/Projects/Calcs/R/USR/Plots/Plots Variable Realization.R")
  print("Done Variable Realizations")
  source("~/Projects/Calcs/R/USR/Plots/Plots Water and Mass Model.R")
  print("Done All")
} else {
  ## Windows file system
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Atm Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Conc Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR River Geometry Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Transport and Storage Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Variable Realization Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR\\Plots\\USR Water and Mass Model Plots.R")
}