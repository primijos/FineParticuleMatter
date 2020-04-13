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

Baltimore <- NEI[NEI$fips=="24510",]

vehicles_labels <- grepl("vehicle", SCC$EI.Sector, ignore.case=T)
vehicles_labels <- SCC[vehicles_labels,]
vehicles_labels <- vehicles_labels$SCC

tmp <- Baltimore[Baltimore$SCC %in% vehicles_labels,]

total <- tapply(tmp$Emissions,tmp$year,sum)
par(mfrow=c(1,1))
png("plot5.png")
plot(names(total),total, ty="l", xlab="Year", ylab="Tons",main="Baltimore City PM2.5 Total emission per year\n(motor vehicles-related)")
dev.off()
