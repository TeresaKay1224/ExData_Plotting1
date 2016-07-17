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

#Convert sub_metering values to be numeric
smallpower$Sub_metering_1 <- as.numeric(as.character(smallpower$Sub_metering_1))
smallpower$Sub_metering_2 <- as.numeric(as.character(smallpower$Sub_metering_2))
smallpower$Sub_metering_3 <- as.numeric(as.character(smallpower$Sub_metering_3))

#make plot
plot(smallpower$DateTime, smallpower$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="")
lines(smallpower$DateTime, smallpower$Sub_metering_1, type="l")
lines(smallpower$DateTime, smallpower$Sub_metering_2, type="l", col="red")
lines(smallpower$DateTime, smallpower$Sub_metering_3, type="l", col="blue")

#Make the legend
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty=1, cex=0.75)

#Save as .png file
dev.copy(png, "plot3.png", width=480, height=480, units="px")
dev.off()