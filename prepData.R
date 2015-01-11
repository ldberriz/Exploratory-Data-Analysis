## Functions to download and clean the data

dnldfile <- function(fileURL, fname) {  ## Function to download the zip file if not already there
  if(!file.exists(fname)) {
    download.file(fileURL, destfile=fname) #, method="curl"
  }
  fname
}

prepareData <- function() {
  cacheFile <- "plot_data.csv"  ## Create a data file to hold the clean data
  if(file.exists(cacheFile)) {  ## If the file exists read it into dta
    dta <- read.csv(cacheFile)
    dta$DateTime <- strptime(dta$DateTime, "%Y-%m-%d %H:%M:%S")  ## Rearrange the time
  }
  else {
    fname <- dnldfile("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                      "household_power_consumption.zip")
    con <- unz(fname, "household_power_consumption.txt")     ## Unzip the file 
    dta <- read.table(
      text = grep("^[1,2]/2/2007", readLines(con), value = TRUE), ## Read just the necessary dates 
      col.names = c(                                              ## Name the columns as appropriate
        "Date", 
        "Time", 
        "Global_active_power", 
        "Global_reactive_power", 
        "Voltage", 
        "Global_intensity", 
        "Sub_metering_1",
        "Sub_metering_2", 
        "Sub_metering_3"), 
      sep = ";", 
      header = TRUE, 
      na.strings = "?")
    dta$DateTime <- strptime(paste(dta$Date, dta$Time), "%d/%m/%Y %H:%M:%S")
    write.csv(dta, cacheFile)
    close(con) 
  }
  dta
}
  
  