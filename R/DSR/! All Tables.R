if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Calcs/R/DSR/Tables/Tables Concentration.R")
  print("done conc")
  source("~/Projects/Calcs/R/DSR/Tables/Tables Geometry results.R")
  print("done geom")  
  source("~/Projects/Calcs/R/DSR/Tables/Tables Individual Flow Rates.R")
  print("done flow")
  source("~/Projects/Calcs/R/DSR/Tables/Tables Input variable.R")
  print("done input")
  source("~/Projects/Calcs/R/DSR/Tables/Tables Mass and Water Balance.R")
  print("done mass and water")
  source("~/Projects/Calcs/R/DSR/Tables/Tables Mass flux and storage.R")
  print("done flux")
} else {

}