if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Tables/Tables Concentration.R")
  print("done conc")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Tables/Tables Geometry results.R")
  print("done geometry")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Tables/Tables Individual Flow Rates.R")
  print("done flow")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Tables/Tables Input variable.R")
  print("done input")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Tables/Tables Mass and Water Balance.R")
  print("done mass and water")
  source("~/Projects/Thesis/Thesis-Calcs/R/USR/Tables/Tables Mass flux and storage.R")
  print("done flux and storage")
} else {
  ## Windows file system

}