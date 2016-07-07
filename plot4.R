power <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

power$Time <- strptime(power$Time, format="%H:%M")
power$Time <- format(power$Time, "%H:%M:%S")

power$Date <- as.Date(power$Date, format="%Y-%m-%d")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

power2007 <- subset(power, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

power2007$DateTime <- as.POSIXct(paste(power2007$Date, power2007$Time), format="%Y-%m-%d %H:%M:%S")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

options(scipen=5)
par(mfrow=c(2,2))

//plot 1
plot(power2007$DateTime, power2007$Global_active_power, pch="", ylab="Global Active Power", xlab="", yaxt="n")
axis(2, at = c(0,1000,2000,3000), labels=c("0","2","4","6"))
lines(power2007$DateTime, power2007$Global_active_power, type="l")

//plot 2
plot(power2007$DateTime, power2007$Voltage, pch="", ylab="Voltage", xlab="datetime", yaxt="n")
lines(power2007$DateTime, power2007$Voltage, type="l")
axis(side=2, at = c(800,1000,1200,1400,1600,1800,2000), labels=c("234","236","238","240","242","244","246"))

//plot 3
plot(power2007$DateTime, power2007$Sub_metering_1, pch="", ylab="Energy sub metering", xlab="", yaxt="n")
lines(power2007$DateTime, power2007$Sub_metering_1, type="l")
lines(power2007$DateTime, power2007$Sub_metering_2, col="red", type="l")
lines(power2007$DateTime, power2007$Sub_metering_3, col="blue", type="l")
axis(2, at = seq(0, 30, by = 10))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1,1), col=c("black", "red", "blue"), cex=.5)

//plot 4
plot(power2007$DateTime, power2007$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", yaxt="n" ,pch="")
lines(power2007$DateTime, power2007$Global_reactive_power)
axis(side=2, at = c(0,40,80,120,160,200), labels=c("0.0", "0.1", "0.2", "0.3", "0.4", "0.5"))

dev.copy(png, "plot4.png", width=480, height=480, units="px")
dev.off()