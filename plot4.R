#Read in the data and format Date and Time columns
power <- read.csv('household_power_consumption.txt', sep=';', header = TRUE)
power$Date <- as.Date(power$Date, format='%d/%m/%Y')
power$Time <- strptime(power$Time, format='%H:%M:%S')
power$Time <- format(smallpower$Time, format='%H:%M:%S')
power$DateTime <- as.POSIXct(paste(power$Date, power$Time), format='%Y-%m-%d %H:%M:%S')

#subset the data to only include rows with dates on 2007-02-01 and 2007-02-02
feb1 <- as.Date("2007-02-01", format="%Y-%m-%d")
feb2 <- as.Date("2007-02-02", format="%Y-%m-%d")
smallpower <- power[power$Date >= feb1 & power$Date <= feb2,]

#Convert columns to be numeric
smallpower$Global_active_power <- as.numeric(as.character(smallpower$Global_active_power))
smallpower$Sub_metering_1 <- as.numeric(as.character(smallpower$Sub_metering_1))
smallpower$Sub_metering_2 <- as.numeric(as.character(smallpower$Sub_metering_2))
smallpower$Sub_metering_3 <- as.numeric(as.character(smallpower$Sub_metering_3))
smallpower$Voltage <- as.numeric(as.character(smallpower$Voltage))
smallpower$Global_reactive_power <- as.numeric(as.character(smallpower$Global_reactive_power))

#Make the page hold 4 plots
par(mfrow=c(2,2))

#Make plot 1
plot(smallpower$DateTime, smallpower$Global_active_power, type="n", ylab="Global Active Power (kilowatts)", xlab="")
lines(smallpower$DateTime, smallpower$Global_active_power, type="l")

#Make plot 2
plot(smallpower$DateTime, smallpower$Voltage, xlab="datetime", ylab="Voltage", type="n")
lines(smallpower$DateTime, smallpower$Voltage)

#Make plot 3
plot(smallpower$DateTime, smallpower$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(smallpower$DateTime, smallpower$Sub_metering_1, type="l")
lines(smallpower$DateTime, smallpower$Sub_metering_2, type="l", col="red")
lines(smallpower$DateTime, smallpower$Sub_metering_3, type="l", col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.5)


#Make plot 4
plot(smallpower$DateTime, smallpower$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="n")
lines(smallpower$DateTime, smallpower$Global_reactive_power)

#Save as .png file
dev.copy(png, "plot4.png", width=480, height=480, units="px")
dev.off()
