power <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

power$Time <- strptime(power$Time, format="%H:%M")
power$Time <- format(power$Time, "%H:%M:%S")

power$Date <- as.Date(power$Date, format="%Y-%m-%d")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

power2007 <- subset(power, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

power2007$DateTime <- as.POSIXct(paste(power2007$Date, power2007$Time), format="%Y-%m-%d %H:%M:%S")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

options(scipen=5)

plot(power2007$DateTime, power2007$Global_active_power, pch="", ylab="Global Active Power (kilowatts)", xlab="", yaxt="n")

axis(2, at = c(0,1000,2000,3000), labels=c("0","2","4","6"))

lines(power2007$DateTime, power2007$Global_active_power, type="l")

dev.copy(png, "plot2.png", width=480, height=480, units="px")
dev.off()