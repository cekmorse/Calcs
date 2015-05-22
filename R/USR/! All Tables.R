if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Calcs/R/USR/Tables/Tables Concentration.R")
  print("Done concentration")
  source("~/Projects/Calcs/R/USR/Tables/Tables Geometry results.R")
  print("Done geometry results")
  source("~/Projects/Calcs/R/USR/Tables/Tables Individual Flow Rates.R")
  print("Done individual flow rates")
  source("~/Projects/Calcs/R/USR/Tables/Tables Input variable.R")
  print("Done input variable")
  source("~/Projects/Calcs/R/USR/Tables/Tables Mass and Water Balance.R")
  print("Done mass and water balance")
  source("~/Projects/Calcs/R/USR/Tables/Tables Mass flux and storage.R")
  print("Done mass flux and storage")
} else {
  ## Windows file system

}