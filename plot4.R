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

# Conver the Global_reactive_power from factor to numeric
power$Global_reactive_power <- as.character(power$Global_reactive_power)
power$Global_reactive_power <- as.numeric(power$Global_reactive_power)

# Conver the Voltage from factor to numeric
power$Voltage <- as.character(power$Voltage)
power$Voltage <- as.numeric(power$Voltage)

# Conver Sub_metering_1 and Sub_metering_2 from factor to numeric
power$Sub_metering_1 <- as.character(power$Sub_metering_1)
power$Sub_metering_1 <- as.numeric(power$Sub_metering_1)
power$Sub_metering_2 <- as.character(power$Sub_metering_2)
power$Sub_metering_2 <- as.numeric(power$Sub_metering_2)

# Construct the plot4 and save it to the png file: plot4.png
png(filename = "plot4.png", width = 480, height = 480, units = "px")
par(mfrow = c(2, 2))
with(power, {
    plot(power$Time, power$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
    
    plot(power$Time, power$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
    
    plot(power$Time, power$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
    lines(power$Time, power$Sub_metering_1, type = "l", col = "gray")
    lines(power$Time, power$Sub_metering_2, type = "l", col = "red")
    lines(power$Time, power$Sub_metering_3, type = "l", col = "blue")
    legend("topright", pch = "___", col = c("gray", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    plot(power$Time, power$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
  
})

dev.off()