run1 <- function(){
    source("~/Projects/Calcs/R/SubScripts/SA River Geometry.R")
}

distConv <- 5280 * 0.3048  ## Convert miles to meters

####################### SEGMENT F
segment <- "F"                       #EDIT
depthToday <- cd2$dF1
segmentLength <- 23.4 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()

####################### SEGMENT G
segment <- "G"                       #EDIT
depthToday <- cd2$dG1
segmentLength <- 15.5 * distConv #EDIT   A=7.8mi, B=2.4mi, C=19.1mi, D=23.5mi, E=8.9mi, F=23.4mi, G=15.5mi
times <- length(depthToday)
run1()