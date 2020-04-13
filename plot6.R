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

# How have emissions from motor vehicle sources changed from 1999–2008 in
# Baltimore City?

BalLA <- NEI[NEI$fips=="24510" | NEI$fips=="06037",]
tmp <- aggregate(Emissions ~ fips + year, BalLA, sum)
tmp$where <- tmp$fips
tmp$where[tmp$fips=="24510"] <- "Baltimore City"
tmp$where[tmp$fips=="06037"] <- "Los Angeles county"

library(ggplot2)
pl <- ggplot(tmp,aes(year,Emissions)) + 
    geom_line() + 
    facet_grid(rows=vars(where), scales="free") + 
    xlab("Year") + 
    ylab("Tons") + 
    ggtitle("PM2.5 emission by year/type (motor vehicles related)")
ggsave("plot6.png",pl)
