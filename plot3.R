

if (!file.exists("./data/household_power_consumption.txt")) {
  download.file("http://j.mp/TbC79E", "./data/power_data.zip", method = "wget")
  unzip("./data/power_data.zip", overwrite = T, exdir = "./data")
}

household_power_consumption <- read.csv("./data/household_power_consumption.txt", sep=";", na.strings="?", stringsAsFactors=FALSE)

data <- household_power_consumption
data <- data[data$Date=="1/2/2007" | data$Date=="2/2/2007", ]

data$Date_Time <- paste(data$Date, data$Time)
data$Date_Time <- strptime(data$Date_Time, format="%d/%m/%Y %H:%M:%S")

# plot1
png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")
hist(data$Global_active_power, main = "Global Active Power", ylab = "Frequency", 
     xlab = "Global Active Power (kilowatts)", col = "red", breaks = 13, 
     ylim = c(0, 1200), xlim = c(0, 6), xaxp = c(0, 6, 3))
dev.off()

# plot2
png(filename = "plot2.png", width = 480, height = 480, units = "px", bg = "white")
plot(data$Date_Time, data$Global_active_power, type = "l", xlab = "", 
     ylab = "Global Active Power (kilowatts)")
dev.off()

# plot3
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "white")
plot(data$Date_Time, data$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(data$Date_Time, data$Sub_metering_2, col = "red", type = "S")
lines(data$Date_Time, data$Sub_metering_3, col = "blue", type = "S")
legend("topright", lty = c(1, 1), lwd = c(1, 1, 1), col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

# plot4
png(filename = "plot4.png", width = 480, height = 480, units = "px", bg = "white")

par(mfrow = c(2, 2))
plot(data$Date_Time, data$Global_active_power, type="l", ylab = "Global Active Power", 
     xlab = "")

plot(data$Date_Time, data$Voltage, type="l", ylab = "Voltage", xlab = "datetime")

plot(data$Date_Time, data$Sub_metering_1, type = "l", xlab = "", 
     ylab = "Energy sub metering")
lines(data$Date_Time, data$Sub_metering_2, col = "red", type = "S")
lines(data$Date_Time, data$Sub_metering_3, col = "blue", type = "S")
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(data$Date_Time, data$Global_reactive_power, type="l", ylab = "Global_reactive_power", 
     xlab = "datetime", ylim = c(0, 0.5))

dev.off()
