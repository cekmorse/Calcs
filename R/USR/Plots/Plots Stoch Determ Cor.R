source("~/Projects/Calcs/R/USR/Pre-Loader.R")

run <- function(dataName, plotName){
  # testing
#   dataName <- "m unknownMass.Rdata"
#   plotName <- "S-D Comparison-UnknownMass.pdf"
  
  setwd(modelsFile)
  x <- load(file = dataName)
  stoch <- get(x)
  
  stochMean <- rowMeans(stoch, na.rm = TRUE)
  
  setwd(models.D)
  x <- load(file = dataName)
  deter <- get(x)
    
  ds <- data.frame(cbind(stochMean, stochMean^2, deter))
  colnames(ds) <- c("s","s2","d")
  dslm <- lm(d ~ s2 + s, data=ds, na.action=na.omit)
#   summary(dslm)
  
  setwd(plotFile)
  ctext <- bquote(cor==.(signif(cor(stochMean, deter, "complete.obs"),3)))
  etext <- bquote(D==.(signif(dslm$coef[[2]],3))%.%S^2 + .(signif(dslm$coef[[3]],3))%.%S + .(signif(dslm$coef[[1]],3)))
  pdf(file=plotName, width=6, height=6, family="Times")  
  par(mar=c(5.1,4.1,1.5,1.1))
  plot(stochMean, deter, pch=20, xlab="Stochastic", ylab="Deterministic")
  abline(a=0, b=1)
  curve(dslm$coefficients[[2]]*x^2 + dslm$coefficients[[3]]*x + dslm$coefficients[[1]], add=TRUE, lty=2)
  mtext(ctext, 3, line=0, adj=0)
  mtext(etext, 3, line=0, adj=1)
  dev.off()
}

run("depthA1.Rdata", "S-D Comparison-G Depth A.pdf")
run("depthB1.Rdata", "S-D Comparison-G Depth B.pdf")
run("depthC1.Rdata", "S-D Comparison-G Depth C.pdf")
run("depthD1.Rdata", "S-D Comparison-G Depth D.pdf")
run("depthE1.Rdata", "S-D Comparison-G Depth E.pdf")

run("widthA1.Rdata", "S-D Comparison-G Width A.pdf")
run("widthB1.Rdata", "S-D Comparison-G Width B.pdf")
run("widthC1.Rdata", "S-D Comparison-G Width C.pdf")
run("widthD1.Rdata", "S-D Comparison-G Width D.pdf")
run("widthE1.Rdata", "S-D Comparison-G Width E.pdf")

run("areaA.Rdata", "S-D Comparison-G Area A.pdf")
run("areaB.Rdata", "S-D Comparison-G Area B.pdf")
run("areaC.Rdata", "S-D Comparison-G Area C.pdf")
run("areaD.Rdata", "S-D Comparison-G Area D.pdf")
run("areaE.Rdata", "S-D Comparison-G Area E.pdf")

run("volA.Rdata", "S-D Comparison-G Volume A.pdf")
run("volB.Rdata", "S-D Comparison-G Volume B.pdf")
run("volC.Rdata", "S-D Comparison-G Volume C.pdf")
run("volD.Rdata", "S-D Comparison-G Volume D.pdf")
run("volE.Rdata", "S-D Comparison-G Volume E.pdf")

run("qin.Rdata", "S-D Comparison-Q in.pdf")
run("ecin.Rdata", "S-D Comparison-EC in.pdf")
run("tin.Rdata", "S-D Comparison-T in.pdf")

run("qout.Rdata", "S-D Comparison-Q out.pdf")
run("ecout.Rdata", "S-D Comparison-EC out.pdf")
run("tout.Rdata", "S-D Comparison-T out.pdf")

run("qCAN.Rdata", "S-D Comparison-Q CAN.pdf")
run("qCON.Rdata", "S-D Comparison-Q CON.pdf")
run("qFLS.Rdata", "S-D Comparison-Q FLS.pdf")
run("qFLY.Rdata", "S-D Comparison-Q FLY.pdf")
run("qHOL.Rdata", "S-D Comparison-Q HOL.pdf")
run("qHRC.Rdata", "S-D Comparison-Q HRC.pdf")
run("qRFD.Rdata", "S-D Comparison-Q RFD.pdf")
run("qRFR.Rdata", "S-D Comparison-Q RFR.pdf")
run("qTIM.Rdata", "S-D Comparison-Q TIM.pdf")
run("qWTP.Rdata", "S-D Comparison-Q WTP.pdf")

run("et.Rdata", "S-D Comparison-ET.pdf")
run("p.Rdata", "S-D Comparison-P.pdf")
run("RHmin.Rdata", "S-D Comparison-RH min.pdf")
run("u2.Rdata", "S-D Comparison-U2.pdf")

run("A Evap.Rdata", "S-D Comparison-Evap.pdf")
run("A Kw.Rdata", "S-D Comparison-Evap coef.pdf")

run("c U163.Rdata", "S-D Comparison-C in.pdf")
run("c CAN.Rdata", "S-D Comparison-C CAN.pdf")
run("c CON.Rdata", "S-D Comparison-C CON.pdf")
run("c FLS.Rdata", "S-D Comparison-C FLS.pdf")
run("c FLY.Rdata", "S-D Comparison-C FLY.pdf")
run("c HOL.Rdata", "S-D Comparison-C HOL.pdf")
run("c HRC.Rdata", "S-D Comparison-C HRC.pdf")
run("c RFD.Rdata", "S-D Comparison-C RFD.pdf")
# run("c RFR.Rdata", "S-D Comparison-C RFR.pdf")  uses same concentration as RFD
run("c TIM.Rdata", "S-D Comparison-C TIM.pdf")
run("c WTP.Rdata", "S-D Comparison-C WTP.pdf")
run("c U201.Rdata", "S-D Comparison-C out.pdf")

run("c Segment A.Rdata", "S-D Comparison-C Segment A.pdf")
run("c Segment B.Rdata", "S-D Comparison-C Segment B.pdf")
run("c Segment C.Rdata", "S-D Comparison-C Segment C.pdf")
run("c Segment D.Rdata", "S-D Comparison-C Segment D.pdf")
run("c Segment E.Rdata", "S-D Comparison-C Segment E.pdf")

run("f U163.Rdata", "S-D Comparison-F in.pdf")
run("f CAN.Rdata", "S-D Comparison-F CAN.pdf")
run("f CON.Rdata", "S-D Comparison-F CON.pdf")
run("f FLS.Rdata", "S-D Comparison-F FLS.pdf")
run("f FLY.Rdata", "S-D Comparison-F FLY.pdf")
run("f HOL.Rdata", "S-D Comparison-F HOL.pdf")
run("f HRC.Rdata", "S-D Comparison-F HRC.pdf")
run("f RFD.Rdata", "S-D Comparison-F RFD.pdf")
run("f RFR.Rdata", "S-D Comparison-F RFR.pdf")
run("f TIM.Rdata", "S-D Comparison-F TIM.pdf")
run("f WTP.Rdata", "S-D Comparison-F WTP.pdf")
run("f U201.Rdata", "S-D Comparison-F out.pdf")

run("f Segment A.Rdata", "S-D Comparison-F Segment A.pdf")
run("f Segment B.Rdata", "S-D Comparison-F Segment B.pdf")
run("f Segment C.Rdata", "S-D Comparison-F Segment C.pdf")
run("f Segment D.Rdata", "S-D Comparison-F Segment D.pdf")
run("f Segment E.Rdata", "S-D Comparison-F Segment E.pdf")

run("m atmChange.Rdata", "S-D Comparison-M Water Atm.pdf")
run("m flowChange.Rdata", "S-D Comparison-M Water Flow.pdf")
run("m storageChange.Rdata", "S-D Comparison-M Water Storage.pdf")
run("m unknownWater.Rdata", "S-D Comparison-M Water Unknown.pdf")

run("m massFlux.Rdata", "S-D Comparison-M Mass Flow.pdf")
run("m massStoreChange.Rdata", "S-D Comparison-M Mass Storage.pdf")
run("m unknownMass.Rdata", "S-D Comparison-M Mass Unknown.pdf")

run("m unknownMass.Rdata", "S-D Comparison-M Unknown C.pdf")

rm(list=ls())
