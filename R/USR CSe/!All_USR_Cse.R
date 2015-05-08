## This file is to run all of the USR CSe models ##
if(.Platform$OS.type == "unix")
{
  ## Mac and Linux file system
  source("~/Projects/Calcs/R/USR CSe/Ark Se USR.R")
  source("~/Projects/Calcs/R/USR CSe/CANSWKCO.r")
  source("~/Projects/Calcs/R/USR CSe/Diversions.r")
  source("~/Projects/Calcs/R/USR CSe/HR194CO.r")
  source("~/Projects/Calcs/R/USR CSe/LAJWWTP.r")
  source("~/Projects/Calcs/R/USR CSe/TIMSWICO.r")
  source("~/Projects/Calcs/R/USR CSe/U163.r")
  source("~/Projects/Calcs/R/USR CSe/U167.r")
  source("~/Projects/Calcs/R/USR CSe/U201.r")
} else {
  ## Windows file system
  
}

