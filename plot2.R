if(!file.exists("household_power_consumption.txt")){
  Url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(Url,destfile = "power_consumption.zip")
  unzip("power_consumption.zip")
}

power_con <- read.table("household_power_consumption.txt",header = TRUE, sep = ";", 
                        colClasses = "character")
sub_power_con <- power_con[power_con$Date %in% c("1/2/2007","2/2/2007"),] 
sub_power_con$datetime <- with(sub_power_con,paste(Date,Time))
Sys.setlocale("LC_TIME", "English")
sub_power_con$datetime <- strptime(sub_power_con$datetime,"%d/%m/%Y %H:%M:%S")
png(file = "plot2.png", width = 480, height = 480 )
with(sub_power_con,plot(x = datetime, y = Global_active_power, type = "n", xlab = "",
                        ylab = "Global_active_power (kilowatts)")) 
with(sub_power_con,lines(x = datetime, y = Global_active_power))
dev.off()
