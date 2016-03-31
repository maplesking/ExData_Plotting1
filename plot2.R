# Download the Dataset: Electric power consumption [20Mb] and extract the data file
dataUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(dataUrl, destfile = "./data.zip", method = "auto")

# Read the data into R
elecpower <- read.table("household_power_consumption.txt", header = TRUE, sep = ";")

# Get data on the dates 2007-02-01 and 2007-02-02
# Date: Date in format dd/mm/yyyy
power1 <- subset(elecpower, Date == "1/2/2007")
power2 <- subset(elecpower, Date == "2/2/2007")
power <- rbind(power1, power2)

# Convert the Date/Time variables to Date/Time class (Date is factor and in format "dd/mm/yyyy"; 
# Time is factor and in format "hh:mm:ss")
power$Date <- as.character(power$Date)
power$Time <- as.character(power$Time)
power$Time <- strptime(paste(power$Date, power$Time, sep = " "), "%d/%m/%Y %H:%M:%S")

# Conver the Global_active_power from factor to numeric
power$Global_active_power <- as.character(power$Global_active_power)
power$Global_active_power <- as.numeric(power$Global_active_power)

# Construct the plot2 and save it to the png file: plot2.png
png(filename = "plot2.png", width = 480, height = 480, units = "px")
plot(power$Time, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")
dev.off()