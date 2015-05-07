###  FUNCTIONS  ###
panel.pearson <- function(x, y, ...){
  horizontal <- (par("usr")[1] + par("usr")[2]) / 2;
  vertical <- (par("usr")[3] + par("usr")[4]) / 2;
  text(horizontal, vertical, format(cor(x,y, use="complete.obs"), digits=2), cex=1)
}