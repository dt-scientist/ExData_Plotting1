
#read data
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),sep=";",header = TRUE,colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")
unlink(temp)


#if you can't obtain blocks of memory 
#i.e R cannot find a contiguous bit of RAM that is that large enough for the data object
#save file in working directory/data/ and run the following:
#data <- read.table("./data/household_power_consumption.txt",sep=";",header = TRUE,colClasses = c(rep("character", 2), rep("numeric", 7)), na.strings = "?")


#take subset
data<- data[data$Date %in% c("1/2/2007", "2/2/2007"), ]

#convert the Date and Time variables to DateTime 
#add new variable with the name  Datetime
data$Datetime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")


########  draw plot4

# divide plot area into an m-by-n grid
par(mfcol = c(2, 2))

# top left plot
plot(data$Datetime, data$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

# bottom left plot
plot(x = data$Datetime, y =data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(x = data$Datetime,y = data$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "red")
points(x = data$Datetime, y =data$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", 
       col = "blue")
legend("topright", lty = 1,legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"))

# top right plot
plot(x = data$Datetime, y = data$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage")

# bottom right
plot(x = data$Datetime, y = data$Global_reactive_power, 
     type = "l", xlab = "datetime", ylab = "Global Reactive Power",ylim = c(0, 0.5))


# save plot to working directory/data
dev.copy(png,"./data/plot4.png",width=608,height=529)
dev.off()


