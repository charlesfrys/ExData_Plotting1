library(lubridate)

#read te data for only dates between 2007-02-01 and 2007-02-02.
data = read.table(file = "household_power_consumption.txt",sep=";",header=FALSE,skip=66637,nrows=69517-66637,na.strings ="?")

#set the column names
colnames(data)= c("Date","Time","Global_active_power","Global_reactive_power",
                  "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")

#change the date column format to "Date"
data$Date = as.Date(data$Date,"%d/%m/%Y")

#create a vector that combines both the date and time of each observation
datetime = apply(merge(data$Date, data$Time, by=0)[,c(2,3)] , 1, paste, collapse=" ")
datetime = sort(strptime(datetime,"%Y-%m-%d %H:%M:%S"))

#create the graph in png format
png("plot4.png")

par(mfrow=c(2,2))
        #first sub plot
plot(datetime,data$Global_active_power,col="black",ylab="Global Active Power (kiloWatts)",xlab="",main="",type="l")
        #second sub plot
plot(datetime,data$Voltage,col="black",ylab="Voltage",xlab="datetime",main="",type="l")
        #third sub plot
plot(datetime,data$Sub_metering_1,ylab="Energy sub metering",xlab="",main="",type="n")
lines(datetime,data$Sub_metering_1,col="black",type="l")
lines(datetime,data$Sub_metering_2,col="red",type="l")
lines(datetime,data$Sub_metering_3,col="blue",type="l")
legend("topright",legend=c("Sub_metering_1","Sub_metering_1","Sub_metering_1"),col=c("black","red","blue"),lty =c("solid","solid","solid"))
        #fourth sub plot
plot(datetime,data$Global_reactive_power,col="black",ylab="Global_reactive_power",xlab="datetime",main="",type="l")

dev.off()

