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