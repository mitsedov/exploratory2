## Here I suppose that the files with data are in the working directory
## Load the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Calculate total emissions by year
total_yr_em <- tapply(NEI$Emissions, NEI$year, sum)

## Set the plot's margins
par("mar" = c(7,10,4,2))
## Create main bar plot, reflecting year-to year changes
barplot(total_yr_em, main = "Total Emissions by Year", axes = FALSE)
## Create labels for axes
mtext(side = 2, text = "Emissions", line = 6)
mtext(side = 1, text = "Year", line = 3)
## Create ticks for y-axis
axis(side = 2, at = c(0, total_yr_em), las = 1)
## Horizontal lines corresponding to each bar, for clearness
lines(c(0, 0.2 * 1 + 0), rep(total_yr_em["1999"], 2), lty = 2)
lines(c(0, 0.2 * 2 + 1), rep(total_yr_em["2002"], 2), lty = 2)
lines(c(0, 0.2 * 3 + 2), rep(total_yr_em["2005"], 2), lty = 2)
lines(c(0, 0.2 * 4 + 3), rep(total_yr_em["2008"], 2), lty = 2)

## Save the plot 
dev.copy(png, file = "plot1.png")
dev.off()