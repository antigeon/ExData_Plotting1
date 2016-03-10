#1Download data
filename<-"week1pro.zip"
if (!file.exists("household_power_consumption.txt")){
    fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    download.file(fileURL, filename)
}  
if (!file.exists("household_power_consumption.txt")) {
    unzip(filename) 
}
#2 read the file and subset useful data
data<-read.table("household_power_consumption.txt",sep = ";")
name<-c("Date", "Time","Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity","Sub_metering_1", "Sub_metering_2","Sub_metering_3")
colnames(data)<-name
useful<-subset(data,Date %in% c("1/2/2007","2/2/2007"))
#3 transform data into suitable date type.
GAP<-as.numeric(levels(useful$Global_active_power))[useful$Global_active_power]
library(lubridate)
Date<-dmy(useful$Date)
time<-strptime(paste(Date,useful$Time),"%Y-%m-%d %H:%M:%S")
#4 plot
plot(time,GAP,ylab = "Global active power (kilowatts)",xlab="",type="l")
#5 save the image
dev.copy(png,file="plot2.png")
dev.off()