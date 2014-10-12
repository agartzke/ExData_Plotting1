library(data.table)

# setup date formatting
setClass("myDate")
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y"))

# grab full file, separated by ';' and interpret '?' as NAs
rawDF <- read.table("./data/household_power_consumption.txt", sep = ";", header=TRUE,  na.strings="?", colClasses=c(Date="myDate"))
rawDT <- data.table(rawDF)

# subset the data to this date range: 2007-02-01 to 2007-02-02 - 2 day period
subDT <- subset(rawDT, (Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")))
subDT[, DateTime:= as.POSIXct(paste(subDT$Date, subDT$Time), format="%Y-%m-%d %H:%M:%S")]

with(subDT, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

# dump to png
dev.copy(png, file = "plot2.png")
dev.off()