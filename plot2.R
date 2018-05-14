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
png("plot2.png")
plot(datetime,data$Global_active_power,col="black",ylab="Global Active Power (kiloWatts)",xlab="",main="",type="l")
dev.off()

