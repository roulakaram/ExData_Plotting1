## plot3.R:   

## Read the table into a dataset 'initial'
## note: in this dataset missing values are coded as "?"
## note: "fill=T" parameter deals with ill-formed rows in the file
initial <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", fill=T)

## Convertion of the class of the Date colum using as.Date() 
initial$Date <- as.Date(initial$Date, "%d/%m/%Y")

## Subset the 'initial' dataframe into 'initialFebr0102' 
initialFebr0102<- subset(initial, Date>='2007-02-01' & Date<='2007-02-02')

## Make Time colum as time with as.POSIXct(), including also the date part in the time 
initialFebr0102$Time <- as.POSIXct(paste(initialFebr0102$Date,initialFebr0102$Time), "%Y-%m-%d %H:%M:%S")

## Convertion of the remaining columns (3:9) into numerical values by using the combination: as.numeric(as.character()) 
initialFebr0102[,3:9] = apply(initialFebr0102[,3:9], 2, function(x) as.numeric(as.character(x)))


## Set local time to US timezone 
Sys.setlocale("LC_TIME","English United States")

## Reset the plotting device layout to default: (1,1)
par(mfrow = c(1, 1))

## Set the backgroud as white for the graphic device
par(bg="white")

## Plot the 1st serie on the graphics: Colum 'initialFebr0102$Sub_metering_1' against column 'initialFebr0102$Time'
plot(initialFebr0102$Time, initialFebr0102$Sub_metering_1, type="l",cex.lab=.8, font.lab=2, cex.main=1, cex.axis=.8, font.axis=2 ,xlab="", ylab="Energy sub metering")

## Add 2nd serie on the graphics: Colum 'initialFebr0102$Sub_metering_2' against column 'initialFebr0102$Time'
lines(initialFebr0102$Time,initialFebr0102$Sub_metering_2, type="l", col="red")

## Add 3rd serie on the graphics: Colum 'initialFebr0102$Sub_metering_3' against column 'initialFebr0102$Time'
lines(initialFebr0102$Time,initialFebr0102$Sub_metering_3, type="l", col="blue")

## Add the legend for the three series  
###legend("topright",cex=0.8, lty=1,legend=c(expression(bold("Sub_metering_1")), expression(bold("Sub_metering_2")), "Sub_metering_3"), col=c("black", "red", "blue"))
legend("topright",cex=.8, lty=1,legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"))

## Copy the plot to a PNG file, 480x480 is the default of the PNG device
dev.copy(png, file = "plot3.png")  

## Close the PNG device
dev.off() 

