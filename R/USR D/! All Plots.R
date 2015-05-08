if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  source("~/Projects/Calcs/R/USR D/Plots/ATM.R")
  source("~/Projects/Calcs/R/USR D/Plots/Transport and Storage.R")
  source("~/Projects/Calcs/R/USR D/Plots/Water and Mass Model.R")
} else {
  ## Windows file naming convention
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\Plots\\USR ATM Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\Plots\\USR Transport and Storage Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\Plots\\USR Water and Mass Model Plots.R")
}

