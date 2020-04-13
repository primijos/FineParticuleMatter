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

# # Across the United States, how have emissions from coal combustion-related sources 
# changed from 1999–2008?

coal_labels <- grepl("coal", SCC$EI.Sector, ignore.case=T)
coal_labels <- SCC[coal_labels,]
coal_labels <- coal_labels$SCC

tmp <- NEI[NEI$SCC %in% coal_labels,]

total <- tapply(tmp$Emissions,tmp$year,sum)
par(mfrow=c(1,1))
png("plot4.png")
plot(names(total),total, ty="l", xlab="Year", ylab="Tons",main="PM2.5 Total emission per year (Coal-related)")
dev.off()