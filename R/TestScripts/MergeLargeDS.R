library(data.table)
require(plyr)
times <- 1500
reals <- 5000
test <- data.frame(matrix(rnorm(times*reals, mean=0, sd=1), ncol=5000), row.names=c(1:times))
test <- cbind("ZZ" = c(1:times), test)
test[1:10,1:10]


## Create two data.tables with which to demonstrate a data.table merge
# dt <- data.table(test, key=names(test), row.names=c(1:times))
# dt2 <- copy(dt)

dt <- test
dt2 <- dt

dfsToJoin <- list(dt, dt2)
dt3 <- join_all(dfsToJoin, by="ZZ")
dt3[1:10,1:10]


## Add to each one a unique non-keyed column
dt$X <- seq_len(nrow(dt))
dt2$Y <- rev(seq_len(nrow(dt)))

## Merge them based on the keyed columns (in both cases, all but the last) to ...
## (1) create a new data.table
dt3 <- dt[dt2]
## (2) or (poss. minimizing memory usage), just add column Y from dt2 to dt
dt[dt2,Y:=Y]
detach(package:data.table)
search()
