power <- read.csv("household_power_consumption.txt", header=TRUE, sep=";")

power$Time <- strptime(power$Time, format="%H:%M")
power$Time <- format(power$Time, "%H:%M:%S")

power$Date <- as.Date(power$Date, format="%Y-%m-%d")

power$Global_active_power <- sapply(power$Global_active_power, as.numeric)

power2007 <- subset(power, Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02") )

options(scipen=5)

hist(power2007$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", yaxt="n", xaxt="n", main="Global Active Power", breaks=20)

axis(1, at = c(0,1000,2000,3000), labels=c("0","2","4","6"))
axis(2, at = seq(0, 1200, by = 200))

dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()