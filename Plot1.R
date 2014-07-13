
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


#draw plot1
plot.new()
with(data, hist(data$Global_active_power,col = "red",main = "Global Active Power",
        xlab = "Global Active Power (kilowatts)", ylab = "Frequency"))


# save plot to working directory/data
dev.copy(png,"./data/plot1.png")
dev.off()


