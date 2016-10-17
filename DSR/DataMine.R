setwd("~/Projects/R_Projects/Calcs/DSR/Data/")
db.cont <- read.csv("Data.csv")
db.se <- read.csv("SeEstData.csv")
db.mine <- db.cont

# Work from here
newCols <- c("se.CAT", "se.HOL", "se.RFD", "se.FLS", "se.TIM", "se.FLY", "se.CAN", "se.CON", "se.WTP", "se.LAS")
db.mine[newCols] <- as.numeric(NA)

pointString <- as.character(db.se$point)
db.se["pointString"] <- pointString

mineLength <- dim(db.mine)[1]
seLength <- dim(db.se)[1]
aPoint <- ""
for (mL in 1 : mineLength) {
  aDateMine <- toString(db.mine$DATE[mL])
  for (sL in 1 : seLength) {
    aDateSe <- toString(db.se$date[sL])
    if (aDateMine == aDateSe) {
      aPoint <- as.character(db.se$pointString[sL])
      aValue <- as.numeric(db.se$cse[sL])
      if (is.na(aPoint)) {
        next
      } else if (aPoint == "CAN") {
        db.mine$se.CAN[mL] <- aValue
      } else if (aPoint == "TIM") {
        db.mine$se.TIM[mL] <- aValue
      } else if (aPoint == "U127") {
        db.mine$se.FLY[mL] <- aValue
      } else if (aPoint == "U141") {
        db.mine$se.FLS[mL] <- aValue
      } else if (aPoint == "U163") {
        db.mine$se.CAT[mL] <- aValue
      } else if (aPoint == "U164") {
        db.mine$se.HOL[mL] <- aValue
      } else if (aPoint == "U167") {
        db.mine$se.RFD[mL] <- aValue
      } else if (aPoint == "U201") {
        db.mine$se.LAS[mL] <- aValue
      } else if (aPoint == "U209") {
        db.mine$se.CON[mL] <- aValue
      } else if (aPoint == "WTP") {
        db.mine$se.WTP[mL] <- aValue
      }
    }
  }
}

write.csv(db.mine, file = "dataMine.csv")
rm(list = setdiff(ls(), "db.mine"))

# Drop rows where there is no Cse value for each of the points
db.las <- db.mine[!is.na(db.mine$se.LAS),]
db.cat <- db.mine[!is.na(db.mine$se.CAT),]

# Based on 'LAS' and 'CAT', drop the 'CON' and 'WTP' columns and re-run the above
db.mine <- subset(db.mine, select = -c(se.CON, se.WTP))
db.las <- db.mine[!is.na(db.mine$se.LAS),]
db.cat <- db.mine[!is.na(db.mine$se.CAT),]
db.hol <- db.mine[!is.na(db.mine$se.HOL),]
db.rfd <- db.mine[!is.na(db.mine$se.RFD),]
db.fls <- db.mine[!is.na(db.mine$se.FLS),]
db.tim <- db.mine[!is.na(db.mine$se.TIM),]
db.fly <- db.mine[!is.na(db.mine$se.FLY),]
db.can <- db.mine[!is.na(db.mine$se.CAN),]

# Compare the dbs.  Combine data to complete a mining data set.  Make the 'LAS' set the primary.
# db.las[,c(1,26:33)]
# db.cat[,c(1,26:33)]
db.las[db.las$DATE == "3/22/2008", c("se.CAT", "se.HOL", "se.RFD", "se.FLS", "se.TIM", "se.FLY", "se.CAN")] <- 
  db.cat[db.cat$DATE == "3/20/2008", c("se.CAT", "se.HOL", "se.RFD", "se.FLS", "se.TIM", "se.FLY", "se.CAN")]
db.las[db.las$DATE == "3/19/2010", c("se.CAT", "se.HOL")] <- 
  db.cat[db.cat$DATE == "3/18/2010", c("se.CAT", "se.HOL")]
db.las[db.las$DATE == "7/20/2010", c("se.CAT", "se.HOL", "se.RFD", "se.FLS", "se.FLY")] <- 
  db.cat[db.cat$DATE == "7/19/2010", c("se.CAT", "se.HOL", "se.RFD", "se.FLS", "se.FLY")]
db.las[db.las$DATE == "8/12/2010", c("se.CAT")] <- 
  db.cat[db.cat$DATE == "8/10/2010", c("se.CAT")]

# db.las[,c(1,26:33)]
# db.hol[,c(1,26:33)]
db.las[db.las$DATE == "8/12/2010", c("se.HOL")] <- 
  db.hol[db.hol$DATE == "8/11/2010", c("se.HOL")]

# db.las[,c(1,26:33)]
# db.rfd[,c(1,26:33)]
db.las[db.las$DATE == "8/12/2010", c("se.RFD")] <- 
  db.rfd[db.rfd$DATE == "8/11/2010", c("se.RFD")]

# db.las[,c(1,26:33)]
# db.fls[,c(1,26:33)]
db.las[db.las$DATE == "3/19/2010", c("se.FLS", "se.TIM", "se.FLY", "se.CAN")] <- 
  db.fls[db.fls$DATE == "3/20/2010", c("se.FLS", "se.TIM", "se.FLY", "se.CAN")]

db.mine <- db.las
write.csv(db.mine, file = "dataMine2.csv")

rm(list = setdiff(ls(), "db.mine"))

setwd("~/Projects/R_Projects/Text/Tables/")
options(width=90)
sink("mineSummaryUS.txt")
summary(db.mine[,2:dim(db.mine)[2]])
sink()

options(width=150)
