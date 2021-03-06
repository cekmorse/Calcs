##### General Setup #####
source("~/Projects/Thesis/Thesis-Calcs/R/DSR/Pre-Loader.R")

run1 <- function(){
  source("~/Projects/Thesis/Thesis-Calcs/R/SubScripts/D Transport and Storage Plots.R")
}

setwd(models.D)
load("date.Rdata")

locate <- "BIG"
load("f BIG.Rdata")
x <- f.BIG
rm(f.BIG)
ylabel <- expression("Mass Flux"~~(kg %.% day^-1 %.% km^-1))
run1()

locate <- "BUF"
load("f BUF.Rdata")
x <- f.BUF
rm(f.BUF)
run1()

locate <- "D101C"
load("f D101C.Rdata")
x <- f.101
rm(f.101)
run1()

locate <- "D106C"
load("f D106C.Rdata")
x <- f.106
rm(f.106)
run1()

locate <- "FRO"
load("f FRO.Rdata")
x <- f.FRO
rm(f.FRO)
run1()

locate <- "WIL"
load("f WIL.Rdata")
x <- f.WIL
rm(f.WIL)
run1()

locate <- "Segment F"
load("f Segment F.Rdata")
x <- f.F
rm(f.F)
ylabel <- expression("Mass Storage Change"~~(kg %.% day^-1 %.% km^-1))
run1()

locate <- "Segment G"
load("f Segment G.Rdata")
x <- f.G
rm(f.G)
run1()

rm(list=ls())
