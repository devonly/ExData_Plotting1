################################################################################################
## Description  : Generates a plot of date shown as day of the week against"Global Active Power"
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
    png(filename = "plot2.png",
        width  = 480,
        height = 480)
    
    ## Create the plot and send to file. Using the time field which had previously combined with date
    plot(hhpcdata$Time,
         hhpcdata$Global_active_power,
         type = "l",                                                              ### Change the plot to a create a linegraph
         xlab = "",
         ylab = "Global Active Power (kilowatts)")
    
    ## Close the PNG device
    dev.off()