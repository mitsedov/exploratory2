## Here I suppose that the files with data are in the working directory
## Load the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the packages
library(plyr)
library(ggplot2)

## Subset only data related to Baltimore
data_Baltimore <- NEI[NEI$fips == "24510",]

## Divide the dataon emissions by type and year 
balt_type_year <- ddply(data_Baltimore, c("type", "year"), function(df) c(Emissions = sum(df$Emissions)))

## Plot the yearly dynamics of emissions, creating facets by type and setting the correct ticks
g <- ggplot(balt_type_year, aes(year, Emissions))
pic <- g + geom_bar(stat = "identity") 
		 + facet_grid(type ~ .) 
		 + scale_x_continuous(breaks=c(1999,2002,2005,2008)) 
		 + geom_line(colour = "red", stat = "identity")
		 + geom_point(stat="identity",colour = "red", shape = 20)
		 + labs(title = "Emission Dynamics by Type")

## Save the plot
ggsave(filename = "plot3.png", plot = pic)