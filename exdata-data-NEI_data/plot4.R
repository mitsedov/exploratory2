## Here I suppose that the files with data are in the working directory
## Load the data into R
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Load the packages
library(plyr)

## Looking for sectors, containing "comb" and "coal" substrings, which
## is one of the relevant strategies for looking coal combustion-related sources
coal_comb <- SCC[(grepl(".*coal.*comb|.*comb.*coal", SCC$EI.Sector, ignore.case = TRUE)), "SCC"]

## Subsetting NEI to get coal-related observations
coal_data <- NEI[NEI$SCC %in% coal_comb,]

## Calculate the emissions for every year
coal_em <- tapply(coal_data$Emissions, coal_data$year, sum)

## Set the plot's margins
par("mar" = c(7,10,4,2))
## Create the main barplot reflecting the changes in coal-related emissions
barplot(coal_em, main = "Coal-related Emissions by Year", ylim = c(0,600000))
## Create labels for axes
mtext(side = 2, text = "Emissions", line = 6)
mtext(side = 1, text = "Year", line = 3)
## Horizontal lines corresponding to each bar, for clearness
lines(c(0, 0.2 * 1 + 0), rep(coal_em["1999"], 2), lty = 2)
lines(c(0, 0.2 * 2 + 1), rep(coal_em["2002"], 2), lty = 2)
lines(c(0, 0.2 * 3 + 2), rep(coal_em["2005"], 2), lty = 2)
lines(c(0, 0.2 * 4 + 3), rep(coal_em["2008"], 2), lty = 2)

## Save the plot
dev.copy(png, file = "plot4.png")
dev.off()