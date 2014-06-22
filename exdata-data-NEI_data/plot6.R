## Here I suppose that the files with data are in the working directory
## Load the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the packages
library(plyr)
library(ggplot2)

## Look for data corresponding to "Onroad" category, which is probably a good proxy
## for data on motor vehicles
vehicles <- SCC[SCC$Data.Category == "Onroad","SCC"]
## Look for data corresponding to "Onroad" category, which is probably a good proxy
## for data on motor vehicles

## Subset only the data related to motor vehicle emissions in Baltimore or LA
veh_data <- NEI[(NEI$SCC %in% vehicles & (NEI$fips == "24510" | NEI$fips == "06037")),]

## Calculate vehicle emissions by location and year
veh_year <- ddply(veh_data, c("fips", "year"), function(df) c(Emissions = sum(df$Emissions)))

## Change factor labels to more obvious ones
veh_year$fips <- factor(veh_year$fips, levels = c("24510","06037"), labels = c("Baltimore", "LA"))

## Create two barplots (emissions vs year) with facets by location
g <- ggplot(veh_year, aes(year, Emissions))
pic <- g + geom_bar(stat = "identity") + facet_grid(.~fips) 
+ scale_x_continuous(breaks=c(1999,2002,2005,2008)) + geom_line(colour = "red", stat = "identity") 
+ geom_point(stat="identity",colour = "red", shape = 20) 
+ labs(title = "Emission Dynamics from Vehicles,\n by Location")

## Save the plot
ggsave(filename = "plot6.png", plot = pic)

##Check that the absolute changes in emissions were greater than in LA
r_la <- range(veh_year[veh_year$fips=="LA","Emissions"])
r_ba <- range(veh_year[veh_year$fips=="Baltimore","Emissions"])
change_la <- max(r_lb) - min(r_lb)
change_ba <- max(r_ba) - min(r_ba)
change_la > change_ba