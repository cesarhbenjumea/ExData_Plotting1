

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

# ---------------- Plot 2 ------------------------------------------------------------------------
png(file = paste0(wd, "/plot2.png"), width=480, height=480)
plot(as.numeric(my_data$Global_active_power), type = "l", axes=F, 
     xlab = "", ylab = "Global Active Power (kilowatts)",
     cex.lab=0.8)
axis(1, at=c(1,1440, 2880), lab=c("Thu","Fri","Sat"), cex.axis=0.8)
axis(2, at=c(0,2,4,6), lab=c("0","2","4","6"), cex.axis=0.8)
box()
dev.off()

