power <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

power$Time <- strptime(power$Time, format="%H:%M")
power$Time <- format(power$Time, "%H:%M:%S")

power$Date <- as.Date(power$Date, format="%Y-%m-%d")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

power2007 <- subset(power, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

power2007$DateTime <- as.POSIXct(paste(power2007$Date, power2007$Time), format="%Y-%m-%d %H:%M:%S")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

options(scipen=5)


plot(power2007$DateTime, power2007$Sub_metering_1, pch="", ylab="Energy sub metering", xlab="", yaxt="n")
lines(power2007$DateTime, power2007$Sub_metering_1, type="l")
lines(power2007$DateTime, power2007$Sub_metering_2, col="red", type="l")
lines(power2007$DateTime, power2007$Sub_metering_3, col="blue", type="l")

axis(2, at = seq(0, 30, by = 10))

legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1,1), col=c("black", "red", "blue"))

dev.copy(png, "plot3.png", width=480, height=480, units="px")
dev.off()