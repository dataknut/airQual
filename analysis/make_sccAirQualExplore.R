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

# https://www.who.int/news-room/fact-sheets/detail/ambient-(outdoor)-air-quality-and-health
annualPm10Threshold_WHO <- 20
dailyPm10Threshold_WHO <- 50 
annualPm2.5Threshold_WHO <- 10
dailyPm2.5Threshold_WHO <- 25 
annualno2Threshold_WHO <- 40
hourlyno2Threshold_WHO <- 200 

dataPath <- path.expand("~/Data/SCC/airQual/")

# fone files
files <- list.files(paste0(dataPath, "/processed/"), pattern = "*.gz", full.names = TRUE)
# load as a list
l <- lapply(files, data.table::fread)
dt <- rbindlist(l, fill = TRUE) # rbind them
dt[, obsDateTime := lubridate::ymd_hm(MeasurementDateGMT)]

dt$MeasurementDateGMT <- NULL # not needed


# Functions ----
doReport <- function(rmd){
  rmdFile <- paste0(projLoc, "/analysis/", rmd, ".Rmd")
  rmarkdown::render(input = rmdFile,
                    params = list(title = title,
                                  subtitle = subtitle,
                                  authors = authors),
                    output_file = paste0(projLoc,"/analysis/", rmd, makePlotly, ".html")
  )
}



# > run report ----

#> yaml ----
title <- "Air Quality in Southampton (UK)"
subtitle <- "Exploring the data"
authors <- "Ben Anderson (b.anderson@soton.ac.uk `@dataknut`)"
rmd <- "sccAirQualExplore"

makePlotly <- "_plotly" # '_plotly' -> yes - for plotly versions of charts

# set doPlotly
if(makePlotly == "_plotly"){
  doPlotly <- 1 # for easier if statements
} else {
  doPlotly <- 0
}


doReport(rmd) # uncomment to run automatically
