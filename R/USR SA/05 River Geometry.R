run1 <- function(){
  source("~/Projects/Calcs/R/SubScripts/SA River Geometry.R")
}

distConv <- 5280 * 0.3048  ## Convert miles to meters

####################### SEGMENT A
segment <- "A"
depthToday <- cd2$dA1
segmentLength <- 7.8 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()

####################### SEGMENT C
segment <- "C"
depthToday <- cd2$dC1
segmentLength <- 19.1 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()

####################### SEGMENT D
segment <- "D"
depthToday <- cd2$dD1
segmentLength <- 23.5 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()

####################### SEGMENT E
segment <- "E"
depthToday <- cd2$dE1
segmentLength <- 8.9 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()

####################### SEGMENT B
segment <- "B"                       #EDIT
depthToday <- cd2$dB1
segmentLength <- 2.4 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()