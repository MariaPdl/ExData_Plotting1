file <- "./household_power_consumption.txt"

#Read only the required data
data <- read.table(file,header=FALSE,sep=";",skip=grep("31/1/2007;23:59",readLines(file)),nrows=2880)

#Name the columns
names(data) <- c("Date","Time","Global_active_power(KW)","Global_reactive_power(KW)",
                 "Voltage(V)","Global_intensity(A)","Sub_metering_1(Wh)","Sub_metering_2(Wh)",
                 "Sub_metering_3(Wh)")

#Convert Date and Time
data$Date <- as.Date(data$Date,format="%d/%m/%Y")
data$Time <- as.POSIXct(paste(data$Date,data$Time))

#Create plot 

png("./plot1.png",width=480,height=480)
hist(data$`Global_active_power(KW)`,xlab="Global Active Power (kilowatts)",col="red",
     main="Global Active Power")
dev.off()