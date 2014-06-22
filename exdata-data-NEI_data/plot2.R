## Here I suppose that the files with data are in the working directory
## Load the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset only data related to Baltimore
data_Baltimore <- NEI[NEI$fips == "24510",]

## Calculate the emissions by year in Baltimore
year_Balt_emissions <- tapply(data_Baltimore$Emissions, data_Baltimore$year, sum)

## Set the plot's margins
par("mar" = c(7,10,4,2))
## Create main bar plot, reflecting year-to year changes of emissions in Baltimore
barplot(year_Balt_emissions, main = "Total Emissions by Year,\nBaltmore", axes = FALSE)
## Create labels for axes
mtext(side = 2, text = "Emissions, Baltimore", line = 6)
mtext(side = 1, text = "Year", line = 3)
## Create ticks for y-axis
axis(side = 2, at = c(0, year_Balt_emissions), las = 1)
## Horizontal lines corresponding to each bar, for clearness
lines(c(0, 0.2 * 1 + 0), rep(year_Balt_emissions["1999"], 2), lty = 2)
lines(c(0, 0.2 * 2 + 1), rep(year_Balt_emissions["2002"], 2), lty = 2)
lines(c(0, 0.2 * 3 + 2), rep(year_Balt_emissions["2005"], 2), lty = 2)
lines(c(0, 0.2 * 4 + 3), rep(year_Balt_emissions["2008"], 2), lty = 2)

## Save the plot 
dev.copy(png, file = "plot2.png")
dev.off()