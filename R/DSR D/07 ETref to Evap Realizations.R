##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

setwd(modelsFile)
load("date.Rdata")

setwd(models.D)
load("calcData.Rdata")

attach(calcData)

# convert from short reference crop to tall via FAO 56 converted to quadratic form
a <- 1
b <- (0.04 * (u2 - 2) - 0.004 * (RHmin - 45)) * (0.5 / 3) ^ 0.3
c <- -1.05  # This is the short reference crop Kw

# Kw for the tall reference crop equation
Kw <- (-b + sqrt(b^2 - 4 * a * c))/(2*a)

# Evaporation -----
Evap <- Kw * et

detach(calcData)

save(Kw, file="A Kw.Rdata")
save(Evap, file="A evap.Rdata")

rm(list=ls())
