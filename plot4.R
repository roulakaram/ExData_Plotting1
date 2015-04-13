## plot4.R:   

## Read the table into a dataset 'initial'
## note: in this dataset missing values are coded as "?"
## note: "fill=T" parameter deals with ill-formed rows in the file
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", fill=T)


initial$Date <- as.Date(initial$Date, "%d/%m/%Y")

## Subset 'initial' to 'initialFebr0102' 
initialFebr0102<- subset(initial, Date>='2007-02-01' & Date<='2007-02-02')

## Make Time colum as time with as.POSIXct(), including also the date part in the time 
initialFebr0102$Time <- as.POSIXct(paste(initialFebr0102$Date,initialFebr0102$Time), "%Y-%m-%d %H:%M:%S")

## Convert the remaining columns (3:9) into numerical values by as.numeric(as.character()) 
initialFebr0102[,3:9] = apply(initialFebr0102[,3:9], 2, function(x) as.numeric(as.character(x)))

## Plot 4

## Set local time formato to US time zone
Sys.setlocale("LC_TIME","English United States")

par(mfrow = c(2, 2))

## Set the the graphic device backgroud as white
par(bg="white")

############
## Plot 4.1
############
## Plot the graphics (PLOT 2): Colum 'initialFebr0102$Global_active_power' against column 'initialFebr0102$Time'
plot(initialFebr0102$Time, initialFebr0102$Global_active_power, type="l",cex.lab=.8, font.lab=2,cex.axis=.8, font.axis=2, cex.main=1,xlab="", ylab="Global Active Power")

############
## Plot 4.2
############## Plot the graphics: Colum 'initialFebr0102$Voltage' against column 'initialFebr0102$Time'
plot(initialFebr0102$Time, initialFebr0102$Voltage, type="l",cex.lab=.8, font.lab=2, cex.main=1, cex.axis=.8, font.axis=2 ,xlab="datetime", ylab="Voltage")

############
## Plot 4.3
############
## Plot the 1st serie on the graphics: Colum 'initialFebr0102$Sub_metering_1' against column 'initialFebr0102$Time'
plot(initialFebr0102$Time, initialFebr0102$Sub_metering_1, type="l",cex.lab=.8, font.lab=2, cex.main=1, cex.axis=.8, font.axis=2 ,xlab="", ylab="Energy sub metering")

## Add 2nd serie on the graphics: Colum 'initialFebr0102$Sub_metering_2' against column 'initialFebr0102$Time'
lines(initialFebr0102$Time,initialFebr0102$Sub_metering_2, type="l", col="red")

## Add 3rd serie on the graphics: Colum 'initialFebr0102$Sub_metering_3' against column 'initialFebr0102$Time'
lines(initialFebr0102$Time,initialFebr0102$Sub_metering_3, type="l", col="blue")

## Add the legend for the three series  
legend("topright", bty="n", cex=.7, box.lty=0, lty=1,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

############
## Plot 4.4
############
## Plot the graphics: Colum 'initialFebr0102$Global_reactive_power' against column 'initialFebr0102$Time'
plot(initialFebr0102$Time, initialFebr0102$Global_reactive_power, type="l",cex.lab=.8, font.lab=2, cex.main=1, cex.axis=.8, font.axis=2 ,xlab="datetime", ylab="Global_reactive_power")

## Copy the plot to a PNG file, 480x480 is the default of the PNG device
dev.copy(png, file = "plot4.png")  

## Close the PNG device
dev.off() 


