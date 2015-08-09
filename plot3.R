################################################################################################
## Description  : Generates a plot of date shown as day of Energy Submetering 1,2 & 3
## Outputs      : A PNG file of plot into current working directory
## Author       : Devon Ly
###############################################################################################

##>> PHASE 1 : LOAD DATA FILE AND COVERT THE COLUMN FORMATS

    ### Forums recommended not loading the datafile to github. So storing it outside of the repository
    datafile <- "D:/Data Science Course/Exploratory Data Analysis/Project 1/ExData_File/household_power_consumption.txt"
    
    ### Read in data file and force all columns to characters
    hhpcdata <- read.table(datafile,
                           header=TRUE,
                           sep=";",
                           colClasses="character")
    
    ### Reformat columns
    hhpcdata$Time <- strptime( paste( hhpcdata$Date,hhpcdata$Time,sep = " "),     ### concatenate the date and time
                               format="%d/%m/%Y %H:%M:%S" )                       ###  and convert to POsIXlt date time
    hhpcdata$Date <- as.Date(hhpcdata$Date, "%d/%m/%Y")                           ### Convert Date column to date type
    hhpcdata[, 3:9] <- lapply(hhpcdata[, 3:9], as.numeric)                        ### Convert all remaining columns to number
    
    ### Subset data to extract data for date 01/02/2007 and 02/02/2007
    hhpcdata <- subset(hhpcdata,
                       hhpcdata$Date == as.Date('2007-02-01', "%Y-%m-%d") |
                       hhpcdata$Date == as.Date('2007-02-02', "%Y-%m-%d") )

##>> PHASE 2 : GENERATE PLOT

    ### Round Global Active Power to one decimal place
    hhpcdata$Global_active_power <- round( hhpcdata$Global_active_power, 1)
    
    ### Open a PNG device
    png(filename = "plot3.png",
        width  = 480,
        height = 480)
    
    ## Create the line plot and send to file. Using the time field which had previously combined with date
    plot( hhpcdata$Time, hhpcdata$Sub_metering_1, type = "l", col="black",      ### Plot sub metering 1 first
          xlab="",
          ylab="Energy Sub Metering")
    lines(hhpcdata$Time, hhpcdata$Sub_metering_2, type = "l", col ="red")       ### Add sub metering 2
    lines(hhpcdata$Time, hhpcdata$Sub_metering_3, type = "l", col ="blue")      ### Add sub metering 3
    
    ## Add legend. Using a dash as symbol and increasing its line width to 2 to make it longer
    legend("topright",
           lty = 1,                                                             ### Use line type to create the legend symbol
           col = c("black","red","blue"),                                       ### Apply the same colours are the line graphs
           legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
    
    ## Close the PNG device
    dev.off()