library(data.table)

# setup date formatting
setClass("myDate")
setAs("character", "myDate", function(from) as.Date(from, format="%d/%m/%Y"))
#setClass("myTime")
#setAs("character", "myTime", function(from) strptime(from, format="%H:%M:%S"))

# grab full file, separated by ';' and interpret '?' as NAs
rawDF <- read.table("./data/household_power_consumption.txt", sep = ";", header=TRUE,  na.strings="?", colClasses=c(Date="myDate"))
rawDT <- data.table(rawDF)

# subset the data to this date range: 2007-02-01 to 2007-02-02 - 2 day period
subDT <- subset(rawDT, (Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02")))

hist(subDT$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")

# dump to png
dev.copy(png, file = "plot1.png")
dev.off()


