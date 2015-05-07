polylims = function(xdata, ydata, ydata2) {
     rl = rle(is.na(ydata))
     starts = vector()
     ends = vector()
     indx = 1
     for (i in 1:length(rl$lengths)){
          if (rl$values[i]){
               # Value was NA, advance index without saving the numeric values
               indx = indx + rl$lengths[i]
          } else {
               # Value was a real number, extract and save those values
               starts = c(starts,indx)
               ends = c(ends, (indx + rl$lengths[i] - 1))
               indx = indx + rl$lengths[i]
          }	
     }
     polylist = list()
     for (i in 1:length(starts)){
          temp = data.frame(x = c(xdata[starts[i]],xdata[starts[i]:ends[i]],
                                  rev(xdata[starts[i]:ends[i]])),
                            y = c(ydata[starts[i]],ydata2[starts[i]:ends[i]],
                                  rev(ydata[starts[i]:ends[i]])))
          polylist[[i]] = temp	
     }
     polylist
}