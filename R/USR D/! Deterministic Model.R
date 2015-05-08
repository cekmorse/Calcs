if(.Platform$OS.type == "unix")
{
  ## Mac/Linux file naming convention
  source("~/Projects/Calcs/R/USR D/01 Variable Realizations.R")
  source("~/Projects/Calcs/R/USR D/05 River Geometry.R")
  source("~/Projects/Calcs/R/USR D/06 Conc Realizations-Data Setup.R")
  source("~/Projects/Calcs/R/USR D/07 ETref to Evap Realizations.R")
  source("~/Projects/Calcs/R/USR D/08 Conc Realizations.R")
  source("~/Projects/Calcs/R/USR D/09 Transport and Storage.R")
  source("~/Projects/Calcs/R/USR D/10 Water and Mass Models.R")
} else {
  ## Windows file naming convention
  ## Check these before using!!!!
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR Variable Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR River Geometry.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR Conc Realizations-Data Setup.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR ETref to Evap Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR Conc Realizations.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR Transport and Storage.R")
  source("C:\\Thesis\\LARB\\03 Thesis-Calcs\\4 Output Se Flux\\Scripts USR D\\USR Water and Mass Models.R")
}
