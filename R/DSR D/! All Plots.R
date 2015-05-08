if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  source("~/Projects/Calcs/R/DSR D/Plots/ATM.R")
  source("~/Projects/Calcs/R/DSR D/Plots/Transport and Storage.R")
  source("~/Projects/Calcs/R/DSR D/Plots/Water and Mass Model.R")
} else {
  ## Windows file naming convention
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\Plots\\DSR ATM Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\Plots\\DSR Transport and Storage Plots.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\Plots\\DSR Water and Mass Model Plots.R")
}
