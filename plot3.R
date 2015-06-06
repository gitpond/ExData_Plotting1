#create a string for the grep so I can load a subset of the data because it is big
myfilter <- "egrep '^[12]/2/2007' ../household_power_consumption.txt"
colnames <- c("Date","Time","Global_active_power",
              "Global_reactive_power","Voltage","Global_intensity",
              "Sub_metering_1","Sub_metering_2","Sub_metering_3")   

#load the data using the filter created above.
powerdata <- read.csv(pipe(myfilter), header = TRUE, sep = ";", 
                      as.is = TRUE, col.names = colnames, na.strings = "?")

#create a Newdate column that contains the date and time as a posix date datatype
powerdata$Newdate <- strptime(paste(powerdata$Date, powerdata$Time), "%d/%m/%Y %T")
#str(powerdata)

# open the png device that I will write to
png(filename = "plot3.png", width = 480, height = 480, bg = "transparent")
# line plot with three sections
with(powerdata, plot(Newdate, Sub_metering_1, 
      type="n", ylab = "Energy sub metering", xlab = ""))
with(powerdata, lines(Newdate, Sub_metering_1, type="l"))
with(powerdata, lines(Newdate, Sub_metering_2, type="l",col="Red"))
with(powerdata, lines(Newdate, Sub_metering_3, type="l",col="Blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#close the png
dev.off()
