## Here I suppose that the files with data are in the working directory
## Load the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the packages
library(plyr)

## Look for data corresponding to "Onroad" category, which is probably a good proxy
## for data on motor vehicles
vehicles <- SCC[SCC$Data.Category == "Onroad","SCC"]
## This choice of data is supported by the fact the using other relevant strategy:
## vehicles <- SCC[(grepl(".*highway.*vehicles.*", SCC$SCC.Level.Two, ignore.case = TRUE)),"SCC"]
## provides exactly the same result

## Subset only the data related to motor vehicle emissions
veh_data_balt <- NEI[(NEI$SCC %in% vehicles & NEI$fips == "24510"),]

## Calculate yearly emissions by notor vehicles in Baltimore
veh_balt_em <- tapply(veh_data_balt$Emissions, veh_data_balt$year, sum)

## Set the plot's margins
par("mar" = c(7,10,4,2))
## Create the main plot reflecting the changes in motor vehicles emissions
barplot(veh_balt_em, main = "Motor Vehicles Emissions by Year,\n Baltimore", ylim = c(0,400))
## Create labels for axes
mtext(side = 2, text = "Emissions", line = 6)
mtext(side = 1, text = "Year", line = 3)
## Horizontal lines corresponding to each bar, for clearness
lines(c(0, 0.2 * 1 + 0), rep(veh_balt_em["1999"], 2), lty = 2)
lines(c(0, 0.2 * 2 + 1), rep(veh_balt_em["2002"], 2), lty = 2)
lines(c(0, 0.2 * 3 + 2), rep(veh_balt_em["2005"], 2), lty = 2)
lines(c(0, 0.2 * 4 + 3), rep(veh_balt_em["2008"], 2), lty = 2)

## Save the plot
dev.copy(png, file = "plot5.png")
dev.off()