################################################################################################
## Description  : Generates a four panel plot 
## Top Left Panel     :  Global Active Power By Day of the week
## Top Right Panel    :  Voltage by Day of the week
## Bottom Left Panel  :  Energy sub metering by day of the week
## Bottom Right Panel :  Global Reactive Power By Day of the week
## Outputs      : A PNG file of plot into current working directory
## Author       : Devon Ly
###############################################################################################

##>> PHASE 1 : LOAD DATA FILE AND COVERT THE COLUMN FORMATS

    ## Forums recommended not loading the datafile to github. So storing it outside of the repository
    datafile <- "D:/Data Science Course/Exploratory Data Analysis/Project 1/ExData_File/household_power_consumption.txt"
    
    ## Read in data file and force all columns to characters
    hhpcdata <- read.table(datafile,
                           header=TRUE,
                           sep=";",
                           colClasses="character")
    
    ## Reformat columns
    hhpcdata$Time <- strptime( paste( hhpcdata$Date,hhpcdata$Time,sep = " "),     ### concatenate the date and time
                               format="%d/%m/%Y %H:%M:%S" )                       ###  and convert to POsIXlt date time
    hhpcdata$Date <- as.Date(hhpcdata$Date, "%d/%m/%Y")                           ### Convert Date column to date type
    hhpcdata[, 3:9] <- lapply(hhpcdata[, 3:9], as.numeric)                        ### Convert all remaining columns to number
    
    ## Subset data to extract data for date 01/02/2007 and 02/02/2007
    hhpcdata <- subset(hhpcdata,
                       hhpcdata$Date == as.Date('2007-02-01', "%Y-%m-%d") |
                       hhpcdata$Date == as.Date('2007-02-02', "%Y-%m-%d") )

##>> PHASE 2 : GENERATE PLOTS

    ## Set up a multipanel with 2 rows and 2 columns
    par(mfrow = c(2,2))
    
    ## Plot the four panels
    
    ## Create top left panel for Global Active Power
    plot(hhpcdata$Time,
         round( hhpcdata$Global_active_power, 1),                               ### Round Global Active Power to one decimal place
         type = "l",                                                            ### Change the plot to a create a linegraph
         xlab = "",
         ylab = "Global Active Power")
    
    ## Create top right panel for Voltage
    plot(hhpcdata$Time,
         hhpcdata$Voltage,
         type = "l",                                                            ### Change the plot to a create a linegraph
         xlab = "datetime",
         ylab = "Voltage")
    
    ## Create bottom left panel for Energy Sub Metering
    plot( hhpcdata$Time, hhpcdata$Sub_metering_1, type = "l", col="black",      ### Plot sub metering 1 first
          xlab="",
          ylab="Energy sub metering")
    lines(hhpcdata$Time, hhpcdata$Sub_metering_2, type = "l", col ="red")       ### Add sub metering 2
    lines(hhpcdata$Time, hhpcdata$Sub_metering_3, type = "l", col ="blue")      ### Add sub metering 3
    legend("topright",                                                          ### Add legend
           lty = 1,                                                             ### Increase the line width to 3
           col = c("black","red","blue"),
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    ## Create bottom right panel for Global Reactive Power
    plot(hhpcdata$Time,
         hhpcdata$Global_reactive_power,
         type = "l",                                                           ### Change the plot to a create a linegraph
         xlab = "datetime",
         ylab = "Global_reactive_power")

    ## Had to resort to using dev.copy. As saving direct to PNG
    ## resulted in only the last plot being saved instead of panel
    dev.copy(png, file = "plot4.png", width = 480, height = 480 )                                        ### Copy the image from the current device to PNG file    
    dev.off()                                                                 ### Close the PNG device