#=========================#
#                         #
#    plot3.R code         #
#                         #
#=========================#

#Col Classes for file read
cols <- c("character","character","numeric", "numeric", "numeric","numeric", "numeric", "numeric","numeric")

#Load the data file from default wd as is - size not an issue
fullset <- read.table("household_power_consumption.txt", header=T, colClasses = cols, sep = ";", na.strings = "?")

#Format dates
fullset$Date <- as.Date(fullset$Date , "%d/%m/%Y")

#Subset df for 2 days - 2007-02-01 and 2007-02-02
subdf <- subset(fullset, Date == "2007-02-01"| Date == "2007-02-02")

#Create Datetime
dt <- paste(as.Date(subdf$Date), subdf$Time)
subdf$Datetime <- as.POSIXct(dt)

#Line Graph with colors and legend
with(subdf,{plot(Sub_metering_1~Datetime, type="l",
            ylab="Energy sub metering", xlab="")
            lines(Sub_metering_2~Datetime,col='Red')
            lines(Sub_metering_3~Datetime,col='Blue')
           })

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#PNG output
dev.copy(png, file="plot3.png", width = 480, height = 480)
dev.off()