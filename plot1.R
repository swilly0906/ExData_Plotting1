if(!file.exists("household_power_consumption.txt")){
  Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url,destfile = "power_consumption.zip")
  unzip("power_consumption.zip")
}

power_con <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", 
                        colClasses = "character")
sub_power_con <- power_con[power_con$Date %in% c("1/2/2007","2/2/2007"),]
sub_power_con$Date <- as.Date(sub_power_con$Date, "%d/%m/%Y")
png(file = "plot1.png", width = 480, height = 480)
hist(x = as.numeric(sub_power_con$Global_active_power) , freq = TRUE,col = "red",
     xlab = "Global Active Power(kilowatts)",main = "Global Active Power")
dev.off()
