source("prepData.R")

doPlot2 <- function() {
  dta <- prepareData()
  png(filename = "plot2.png", width = 480, height = 480, units = "px")
  plot(dta$DateTime, 
       dta$Global_active_power, 
       type="l", 
       xlab="", 
       ylab="Global Active Power (kilowatts)")
  dev.off()
}

doPlot2()