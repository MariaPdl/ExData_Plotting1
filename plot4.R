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
png("./plot4.png",width=480,height=480)
par(mfrow=c(2,2))
with(data, {
  plot(Time,`Global_active_power(KW)`,xlab="",ylab="Global Active Power (kilowatts)",type="l")
  plot(Time,`Voltage(V)`,xlab='datetime',ylab="Voltage",type="l")
  
  with(data,plot(Time,`Sub_metering_1(Wh)`,xlab="",ylab="Energy sub metering",type="n"))
  with(data,points(Time,`Sub_metering_1(Wh)`,type="l"))     
  with(data,points(Time,`Sub_metering_2(Wh)`,col="red",type="l"))     
  with(data,points(Time,`Sub_metering_3(Wh)`,col="blue",type="l"))
  legend("topright",pch=c(NA,NA),lty=c(1,1),col=c("black","red","blue"),
         legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  plot(Time,`Global_reactive_power(KW)`,xlab='datetime',ylab="Global_reactive_power",type="l")
  
  
})

dev.off()