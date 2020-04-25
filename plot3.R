

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

# ---------------- Plot 3 ------------------------------------------------------------------------

png(file = paste0(wd, "/plot3.png"), width=480, height=480)
plot(as.numeric(my_data$Sub_metering_1), type = "l", axes=F,
     xlab = "", col="black", ylab = "Energy sub metering", cex.lab=0.8)
lines(as.numeric(my_data$Sub_metering_2), type = "l", 
      xlab = "", col="red")
lines(as.numeric(my_data$Sub_metering_3), type = "l", 
      xlab = "", col="blue")
legend("topright",  c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lty = c(1,1,1), col = c("black", "red", "blue"))
axis(1, at=c(1,1440, 2880), lab=c("Thu","Fri","Sat"), cex.axis=0.8)
axis(2, at=c(0,10,20,30), lab=c("0","10","20","30"), cex.axis=0.8)
box()
dev.off()

