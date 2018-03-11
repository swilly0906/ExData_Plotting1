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
par(mfrow = c(2,2))
par(mar = c(4,4,2,2))
png(file = "plot4.png")
#topleft
with(sub_power_con,plot(x = datetime, y = Global_active_power, type = "n", xlab = "",
                        ylab = "Global_active_power (kilowatts)"))
with(sub_power_con,lines(x = datetime, y = Global_active_power))
#topright
with(sub_power_con,plot(x = datetime, y = Voltage,type = "n",xlab = "datetime"))
with(sub_power_con,lines(x = datetime, y = Voltage))
#bottomleft
with(sub_power_con, plot(x = datetime, y = Sub_metering_1,type = "n",
                         ylab = "Energy sub metering", xlab = ""))
plot_color <- c("black","red","blue")
plot_names <- names(sub_power_con)[7:9]
with(sub_power_con, lines(x = datetime, y = Sub_metering_1, col = plot_color[1]))
with(sub_power_con, lines(x = datetime, y = Sub_metering_2, col = plot_color[2]))
with(sub_power_con, lines(x = datetime, y = Sub_metering_3, col = plot_color[3]))
legend("topright",legend = plot_names, col = plot_color,lty = 1,cex = 0.3)
#bottomright
with(sub_power_con,plot(x = datetime, y = Global_reactive_power,type = "n",xlab = "datetime"))
with(sub_power_con,lines(x = datetime, y = Global_reactive_power))
dev.off()