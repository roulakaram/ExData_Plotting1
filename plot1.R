## plot1.R:   

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

## Reset the plotting device layout to default: (1,1)
par(mfrow = c(1, 1))

## Set the backgroud as white for the graphic device
par(bg="white")
 
## Plot the histogram  as Frequency of colum 'initialFebr0102$Global_active_power' 
hist(initialFebr0102$Global_active_power, cex.lab=.8, font.lab=2, cex.main=1, cex.axis=.8, font.axis=2, ylim=c(0,1200), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

## Copy the plot to a PNG file, 480x480 is the default of the PNG device
dev.copy(png, file = "plot1.png")  

## Close the PNG device
dev.off()  

##############################

