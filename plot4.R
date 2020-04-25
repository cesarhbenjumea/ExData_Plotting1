

# ---------------- Get dataset from url ----------------------------------------------------------
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
temp <- tempfile()
download.file(url,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"), stringsAsFactors = FALSE, sep = ";", header = TRUE)
unlink(temp)

# Clean workspace
rm(list=c("temp","url"))

wd <- getwd()

# -------------- Cleaning and Formatting Data ---------------------------------------------------

# Only use data from the dates 2007-02-01 and 2007-02-02.
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")
date1 <- as.Date("01/02/2007", format = "%d/%m/%Y")
date2 <- as.Date("02/02/2007", format = "%d/%m/%Y")

my_data <- data[(data$Date == date1)|(data$Date == date2),]

# Clean workspace
rm(list = c("data"))

# ---------------- Plot 4 ------------------------------------------------------------------------
png(file = paste0(wd, "/plot4.png"), width=480, height=480)
par(mfrow=c(2,2))

#plot1
plot(as.numeric(my_data$Global_active_power), type = "l", axes=F, 
     xlab = "", ylab = "Global Active Power (kilowatts)",
     cex.lab=0.8)
axis(1, at=c(1,1440, 2880), lab=c("Thu","Fri","Sat"), cex.axis=0.8)
axis(2, at=c(0,2,4,6), lab=c("0","2","4","6"), cex.axis=0.8)
box()
#plot2
plot(as.numeric(my_data$Voltage), type = "l", axes=F,
     xlab = "datetime", col="black", ylab = "Voltaje", cex.lab=0.8)
axis(1, at=c(1,1440, 2880), lab=c("Thu","Fri","Sat"), cex.axis=0.8)
axis(2, at=seq(from=234, to=246, by =2), lab=c("234","","238","","242","","246"), cex.axis=0.8)
box()
#plot3
plot(as.numeric(my_data$Sub_metering_1), type = "l", axes=F,
     xlab = "", col="black", ylab = "Energy sub metering", cex.lab=0.8)
lines(as.numeric(my_data$Sub_metering_2), type = "l", 
      xlab = "", col="red")
lines(as.numeric(my_data$Sub_metering_3), type = "l", 
      xlab = "", col="blue")
legend("topright",  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c("black", "red", "blue"), box.lwd = 0, box.col = "white")
axis(1, at=c(1,1440, 2880), lab=c("Thu","Fri","Sat"), cex.axis=0.8)
axis(2, at=c(0,10,20,30), lab=c("0","10","20","30"), cex.axis=0.8)
box()
#plot4
plot(as.numeric(my_data$Global_reactive_power), type = "l", axes=F,
     xlab = "datetime", col="black", ylab = "Global_reactive_power", cex.lab=0.8)
axis(1, at=c(1,1440, 2880), lab=c("Thu","Fri","Sat"), cex.axis=0.8)
axis(2, at=seq(from=0.1, to=0.5, by =0.1), lab=c("0.1", "0.2", "0.3", "0.4", "0.5"), cex.axis=0.8)
box()

dev.off()


