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

with(subDT, plot(DateTime, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(subDT, points(DateTime, Sub_metering_2, type="l", col="red"))
with(subDT, points(DateTime, Sub_metering_3, type="l", col="blue"))

# legend
legend("topright", lty=c(1,1,1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       cex=0.7, pt.cex = 1)

# dump to png
dev.copy(png, file = "plot3.png")
dev.off()