# Makes the data analysis report
# Saves result 
# Load libraries needed across all .Rmd files ----
localLibs <- c("rmarkdown",
               "bookdown",
               "data.table",
               "here", # where are we?
               "lubridate", # fixing dates & times
               "utils" # for reading .gz files with data.table
)

library(dkUtils)
dkUtils::loadLibraries(localLibs)              # Load script specific packages

# Project Settings ----
myParams <- list()
myParams$projLoc <- here::here()

# set these here so they are global across any report run (or rmd version)
# https://www.who.int/news-room/fact-sheets/detail/ambient-(outdoor)-air-quality-and-health
# Guideline levels for each pollutant (µg/m3 ):
# PM2.5 	1 year 	10
#         24 h (99th percentile) 	25
# PM10 	1 year 	20
#       24 h (99th percentile) 	50
# Ozone, O3 	8 h, daily maximum 	100
# Nitrogen dioxide, NO2 	1 yr 	40
#                   1 h 	200
# Sulfur dioxide, SO2 	24 h 	20
#                 10 min 	500


myParams$annualPm2.5Threshold_WHO <- 10 # mean
myParams$dailyPm2.5Threshold_WHO <- 25 

myParams$annualPm10Threshold_WHO <- 20
myParams$dailyPm10Threshold_WHO <- 50 

myParams$dailyO3Threshold_WHO <- 100

myParams$annualNo2Threshold_WHO <- 40
myParams$hourlyNo2Threshold_WHO <- 200 

myParams$dailySo2Threshold_WHO <- 20
myParams$tenMSo2Threshold_WHO <- 500

myParams$sccDataPath <- path.expand("~/Data/SCC/airQual/direct/")
myParams$aurnDataPath <- path.expand("~/Data/SCC/airQual/aurn/")

# Load data ----
# data files
files <- list.files(paste0(myParams$sccDataPath, "processed/"), pattern = "*.gz", full.names = TRUE)
# > load SSC as a list ----
l <- lapply(files, data.table::fread)
origDataDT <- rbindlist(l, fill = TRUE) # rbind them

origDataDT$MeasurementDateGMT <- NULL # not needed
origDataDT[, dateTimeUTC := lubridate::as_datetime(dateTimeUTC)] # may not laod as such
l <- NULL # not needed

lDT <- data.table::melt(origDataDT,
                        id.vars=c("site","dateTimeUTC"),
                        measure.vars = c("co","no2","nox","oz","pm10","pm2_5","so2"),
                        value.name = "value" # varies 
)

lDT[, obsDate := lubridate::date(dateTimeUTC)]
lDT[, source := "southampton.my-air.uk"]
# map to AURN definitions
lDT[, pollutant := as.character(variable)]
lDT[, pollutant := ifelse(pollutant == "oz", "o3", pollutant)]
lDT[, pollutant := ifelse(pollutant == "pm2_5", "pm2.5", pollutant)]

# > load AURN data ----
# Ambient Temperature
# Barometric pressure
# Carbon monoxide
# Daily measured PM10 (uncorrected)
# Daily measured PM2.5 (uncorrected)
# Modelled Temperature
# Modelled Wind Direction
# Modelled Wind Speed
# Nitric oxide = no?
# Nitrogen dioxide = no2?
# Nitrogen oxides as nitrogen dioxide = nox?
# Non-volatile PM10 (Hourly measured)
# Non-volatile PM2.5 (Hourly measured)
# Ozone
# PM10 Ambient pressure measured
# PM10 Ambient Temperature
# PM2.5 Ambient Preasure
# PM2.5 Ambient Temperature
# PM10 particulate matter (Daily measured)
# PM10 particulate matter (Hourly measured)
# PM1 particulate matter (Hourly measured)
# PM2.5 particulate matter (Daily measured)
# PM2.5 particulate matter (Hourly measured)
# Rainfall
# Relative Humidity
# Sulphur dioxide
# Total Particulates
# Volatile PM10 (Hourly measured)
# Volatile PM2.5 (Hourly measured)
# Wind Direction
# Wind Speed
aurnDT <- data.table::fread(paste0(myParams$aurnDataPath, 
                            "processed/AURN_SSC_sites_hourlyAirQual_processed.csv.gz")
                            )
aurnDT[, dateTimeUTC := lubridate::as_datetime(date)]
aurnDT[, obsDate := lubridate::date(dateTimeUTC)]
aurnDT[, source := "AURN"]

# rbind the matching columns
sotonAirDT <- rbind(aurnDT[, .(dateTimeUTC, pollutant, source, site, value)],
                    lDT[, .(dateTimeUTC, pollutant, source, site, value)])

# test
with(sotonAirDT, table(pollutant, source))

# Functions ----
doReport <- function(rmd){
  rmdFile <- paste0(myParams$projLoc, "/rmd/", rmd, ".Rmd")
  rmarkdown::render(input = rmdFile,
                    params = list(title = myParams$title,
                                  subtitle = myParams$subtitle,
                                  authors = myParams$authors),
                    output_file = paste0(myParams$projLoc,"/docs/", # for easy github pages management
                                         myParams$rmd,"_" , myParams$subtitle, ".html")
  )
}



# > settings ----

#> yaml ----
myParams$title <- "Air Quality in Southampton (UK)"
myParams$subtitle <- "Exploring the SSC and AURN data"
myParams$authors <- "Ben Anderson (b.anderson@soton.ac.uk `@dataknut`)"
myParams$rmd <- "sccAirQualExplore" # use raw SCC data not AURN

# filter the data here
#origDataDT <- origDataDT[dateTimeUTC > lubridate::as_datetime("2020-01-01")]

# > run report ----
#doReport(myParams$rmd) # uncomment to run automatically
