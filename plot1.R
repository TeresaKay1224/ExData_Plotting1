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

#Convert Global_active_power to be numeric
smallpower$Global_active_power <- as.numeric(as.character(smallpower$Global_active_power))

#make plot
hist(smallpower$Global_active_power, main="Global Active Power", col="red", ylab="Frequency", xlab="Global Active Power (kilowatts)", breaks=15)

#Save as .png file
dev.copy(png, "plot1.png", width=480, height=480, units="px")
dev.off()
