source("prepData.R")

doPlot1 <- function() {
  dta <- prepareData()
  png(filename = "plot1.png",width = 480,height = 480)
  hist(dta$Global_active_power, 
       col = "red", 
       main = "Global Active Power",
       xlab = "Global Active Power (kilowatts)")
  dev.off()
}

doPlot1()
