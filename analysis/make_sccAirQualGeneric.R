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
projLoc <- here::here()

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


annualPm2.5Threshold_WHO <- 10 # mean
dailyPm2.5Threshold_WHO <- 25 

annualPm10Threshold_WHO <- 20
dailyPm10Threshold_WHO <- 50 

dailyO3Threshold_WHO <- 100

annualNo2Threshold_WHO <- 40
hourlyNo2Threshold_WHO <- 200 

dailySo2Threshold_WHO <- 20
tenMSo2Threshold_WHO <- 500

dataPath <- path.expand("~/Data/SCC/airQual/")

# data files
files <- list.files(paste0(dataPath, "direct/processed/"), pattern = "*.gz", full.names = TRUE)
# load as a list
l <- lapply(files, data.table::fread)
origDataDT <- rbindlist(l, fill = TRUE) # rbind them

origDataDT$MeasurementDateGMT <- NULL # not needed
origDataDT[, dateTimeUTC := lubridate::as_datetime(dateTimeUTC)] # may not laod as such
l <- NULL # not needed


# Functions ----
doReport <- function(rmd){
  rmdFile <- paste0(projLoc, "/analysis/", rmd, ".Rmd")
  rmarkdown::render(input = rmdFile,
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(projLoc,"/docs/", # for easy github pages management
                                         rmd, makePlotly,"_" , subtitle, ".html")
  )
}



# > settings ----

#> yaml ----
title <- "Air Quality in Southampton (UK)"
subtitle <- "Exploring the data"
authors <- "Ben Anderson (b.anderson@soton.ac.uk `@dataknut`)"
rmd <- "sccAirQualExplore" # use raw SCC data not AURN

# filter the data here
#origDataDT <- origDataDT[dateTimeUTC > lubridate::as_datetime("2020-01-01")]

makePlotly <- "" # '_plotly' -> yes - for plotly versions of charts

# > set doPlotly ----
if(makePlotly == "_plotly"){
  doPlotly <- 1 # for easier if statements
} else {
  doPlotly <- 0
}

# > run report ----
doReport(rmd) # uncomment to run automatically
