if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/01 Variable Realizations.R")  
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/05 River Geometry.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/06 Conc Realizations-Data Setup.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/07 ETref to Evap Realizations.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/08 Conc Realizations.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/09 Transport and Storage.R")
  source("~/Projects/Thesis/Thesis-Calcs/R/DSR D/10 Water and Mass Models.R")
} else {
  ## Windows file naming convention
  ## Check these before using!!!!
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\01 DSR Variable Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\05 DSR River Geometry.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\06 DSR Conc Realizations-Data Setup.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\07 DSR ETref to Evap Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\08 DSR Conc Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\09 DSR Transport and Storage.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts DSR D\\10 DSR Water and Mass Models.R")
}