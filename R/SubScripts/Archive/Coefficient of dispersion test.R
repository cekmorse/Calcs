require(reshape2)
require(lawstat)

load("Balance Mass all.Rdata")
y <- NA 
for(i in 1:length(mbal)){
     z <- unlist(c(mbal[i,]))
     y[i] <- cd(z)$stat[[1]]
}
mean(y)