##### General Setup #####
source("~/Projects/Calcs/R/DSR/Pre-Loader.R")

run <- function() {
  source("~/Projects/Calcs/R/SubScripts/ConcModelCalcs.R")
}

setwd(dataFile)
seData <- read.csv("SeEstData.csv")
setwd(modelsFile)

locate <- "D101C"
variables <- c("cse", "q.in", "ec.in", "t.in")
model <- "cse ~ ec.in + ec.in:q.in + ec.in:t.in"
run()

locate <- "D106C"
variables <- c("cse", "ec.out", "t.out")
model <- "cse ~ t.out + ec.out:t.out"
run()

locate <- "DDIV"
variables <- c("cse", "q.in", "ec.in", "q.out", "ec.out", "t.out", "di")
model <- "cse ~ q.in + ec.in + q.out + ec.out + t.out + di"
run()

locate <- "BIG"
variables <- c("cse", "q.in", "q.out", "q.x")
model <- "cse ~ q.in + q.out + q.x + q.in:q.x + q.out:q.x"
run()

locate <- "WIL"
variables <- c("cse", "q.in", "ec.in", "t.in", "q.out", "ec.out", "q.x")
model <- "cse ~ ec.in + t.in + ec.out + q.in:q.x + ec.in:t.in + ec.in:ec.out + ec.in:q.x + t.in:ec.out + q.out:q.x"
run()

rm(list=ls())