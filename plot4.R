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
Voltage<-as.numeric(levels(useful$Voltage))[useful$Voltage]
m1<-as.numeric(levels(useful$Sub_metering_1))[useful$Sub_metering_1]
m2<-as.numeric(levels(useful$Sub_metering_2))[useful$Sub_metering_2]
m3<-as.numeric(levels(useful$Sub_metering_3))[useful$Sub_metering_3]
GRP<-as.numeric(levels(useful$Global_reactive_power))[useful$Global_reactive_power]
#5 plot
par(mfrow=c(2,2))
plot(time,GAP,ylab = "Global active power",xlab="",type="l")
plot(time,Voltage,xlab = "datetime","l")
plot(time,m1,type="n",ylab = "Energy sub metering",xlab = "")
lines(time,m1,col="black")
lines(time,m2,col="red")
lines(time,m3,col="blue")
legend("topright",legend = c("sub_metering_1","sub_metering_2","sub_metering_3"),lwd=1,col =c("black","red","blue"),bty = "n",pt.cex = 1.2)
plot(time,GRP,xlab = "datetime",ylab = "Global_reactive_power",type="l",)
dev.copy(png,"plot4.png")
dev.off()