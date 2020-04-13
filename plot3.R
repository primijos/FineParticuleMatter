ZIPURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
DATADIR <- "./data"
ZIPFILE <- sprintf("%s/%s",DATADIR,"data.zip")

NEIFILE <- sprintf("%s/summarySCC_PM25.rds",DATADIR)
SCCFILE <- sprintf("%s/Source_Classification_Code.rds",DATADIR)

if (! file.exists(DATADIR)) {
    dir.create(DATADIR)
}

if (! file.exists(ZIPFILE)) {
    download.file(ZIPURL,ZIPFILE,method="curl")
}

if (! file.exists(NEIFILE) || ! file.exists(SCCFILE)) {
    unzip(ZIPFILE,exdir = DATADIR)
}

NEI <- readRDS(NEIFILE)
SCC <- readRDS(SCCFILE)

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) 
# variable, which of these four sources have seen decreases in emissions from 1999–2008 
# for Baltimore City? Which have seen increases in emissions from 1999–2008? Use the 
# ggplot2 plotting system to make a plot answer this question.

Baltimore <- NEI[NEI$fips=="24510",]
tmp <- aggregate(Emissions ~ type + year, Baltimore, sum)
library(ggplot2)
pl <- ggplot(tmp,aes(year,Emissions)) + 
    geom_line() + 
    facet_wrap(~type, scales="free") + 
    xlab("Year") + 
    ylab("Tons") + 
    ggtitle("Baltimore City PM2.5 emission by year/type")
ggsave("plot3.png",pl)