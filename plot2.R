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

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
# (fips == "24510") from 1999 to 2008? Use the base plotting system to make a plot
# answering this question.
Baltimore <- NEI[NEI$fips=="24510",]
total <- tapply(Baltimore$Emissions,Baltimore$year,sum)
par(mfrow=c(1,1))
png("plot2.png")
plot(names(total),total, ty="l", xlab="Year", ylab="Tons",main="Baltimore City PM2.5 Total emission per year")
dev.off()