# Makes the data analysis report
# Saves result 
library(airQual)
airQual::setup() # in case we didn't earlier
# Load libraries needed across all .Rmd files ----
localLibs <- c("rmarkdown",
               "bookdown",
               "data.table",
               "drake", # what gets done stays done
               "here", # where are we?
               "lubridate", # fixing dates & times
               "utils" # for reading .gz files with data.table
)

library(dkUtils)
dkUtils::loadLibraries(localLibs)              # Load script specific packages

# Project Settings ----
update <- "yep" # editing this forces drake to re-load the data
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

myParams$sccDataPath <- path.expand(paste0(aqParams$SCCdataPath, "/myAir/"))
#myParams$sccDataPath <- path.expand("~/Data/SCC/airQual/myAir/")
myParams$hantsAirDataPath <- path.expand(paste0(aqParams$SCCdataPath, "/hantsAir/"))
#path.expand("~/Data/SCC/airQual/hantsAir/")
#myParams$aurnDataPath <- path.expand("~/Data/SCC/airQual/aurn/")
myParams$aurnDataPath <- path.expand(paste0(aqParams$SCCdataPath, "/aurn/"))

# Functions
loadSSCData <- function(update){
  # > SSC data ----
  # do not use, no longer updting from my-air
  # files <- list.files(paste0(myParams$sccDataPath, "processed/"), pattern = "*.gz", full.names = TRUE)
  # l <- lapply(files, data.table::fread)
  # origDataDT <- rbindlist(l, fill = TRUE) # rbind them
  # 
  # origDataDT$MeasurementDateGMT <- NULL # not needed
  # origDataDT[, dateTimeUTC := lubridate::as_datetime(dateTimeUTC)] # may not laod as such
  # l <- NULL # not needed
  # 
  # lDT <- data.table::melt(origDataDT,
  #                         id.vars=c("site","dateTimeUTC"),
  #                         measure.vars = c("co","no2","nox","oz","pm10","pm2_5","so2"),
  #                         value.name = "value" # varies 
  # )
  # 
  # lDT[, obsDate := lubridate::date(dateTimeUTC)]
  # lDT[, source := "southampton.my-air.uk"]
  # # map to AURN definitions
  # lDT[, pollutant := as.character(variable)]
  # lDT[, pollutant := ifelse(pollutant == "oz", "o3", pollutant)]
  # lDT[, pollutant := ifelse(pollutant == "pm2_5", "pm2.5", pollutant)]
  
  # hantsAir data
  files <- list.files(paste0(myParams$hantsAirDataPath, "processed/"), pattern = "*.gz", full.names = TRUE)
  # could limit this to just 2017 ->
  l <- lapply(files, data.table::fread)
  dt <- rbindlist(l, fill = TRUE) # rbind them
  l <- NULL
  dt[, dateTimeUTC := lubridate::as_datetime(dateTimeUTC)]
  dt[, ratified := `Provisional or Ratified`]
  dt[, value := as.numeric(value)] # to match AURN
  dt[, pollutant := ifelse(pollutant == "NO","no" , pollutant)] # fix to AURN
  dt[, pollutant := ifelse(pollutant == "NO2","no2" , pollutant)] # fix to AURN
  dt[, pollutant := ifelse(pollutant == "NOX","nox" , pollutant)] # fix to AURN
  dt[, pollutant := ifelse(pollutant == "PM10","pm10" , pollutant)] # fix to AURN
  dt[, pollutant := ifelse(pollutant == "PM25","pm2.5" , pollutant)] # fix to AURN
  dt[, pollutant := ifelse(pollutant == "SO2","sp2" , pollutant)] # fix to AURN
  return(dt)
}

loadAURNData <- function(update){
  # > AURN data ----
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
  
  files <- list.files(paste0(myParams$aurnDataPath, "processed/"), pattern = "*long.csv.gz", full.names = TRUE)
  l <- lapply(files, data.table::fread)
  dt <- rbindlist(l, fill = TRUE) # rbind them
  
  dt[, dateTimeUTC := lubridate::as_datetime(date)]
  dt[, obsDate := lubridate::date(dateTimeUTC)]
  dt[, ratified := "?"]
  dt[, source := "AURN"]
  return(dt)
}

fixDates <- function(dt){
  dt[, obsDate := lubridate::date(dateTimeUTC)]
  dt[, year := lubridate::year(dateTimeUTC)]
  dt[, origDoW := lubridate::wday(dateTimeUTC, label = TRUE)]
  dt[, month := lubridate::month(obsDate)]
  
  dt[, site := ifelse(site == "Southampton A33", "Southampton A33\n(via AURN)", site)]
  dt[, site := ifelse(site == "Southampton Centre", "Southampton Centre\n(via AURN)", site)]
  
  extractDT <- dt[!is.na(value)] # leave out 2016 so we compare with previous 3 years
  
  # this is such a kludge
  extractDT[, decimalDate := lubridate::decimal_date(obsDate)] # gives year.% of year
  
  # set to 2020 'dates'
  extractDT[, date2020 := lubridate::as_date(lubridate::date_decimal(2020 + (decimalDate - year)))] # sets 'year' portion to 2020 so the lockdown annotation works
  extractDT[, day2020 := lubridate::wday(date2020, label = TRUE)] # 
  
  # 2020 Jan 1st = Weds
  dt2020 <- extractDT[year == 2020] 
  dt2020[, fixedDate := obsDate] # no need to change
  dt2020[, fixedDoW := lubridate::wday(fixedDate,label = TRUE)]
  # table(dt2020$origDoW, dt2020$fixedDoW)
  # head(dt2020[origDoW != fixedDoW])
  
  # shift to the closest aligning day
  # 2019 Jan 1st = Tues
  dt2019 <- extractDT[year == 2019] 
  dt2019[, fixedDate := date2020 -1]
  dt2019[, fixedDoW := lubridate::wday(fixedDate,label = TRUE)]
  # table(dt2019$origDoW, dt2019$fixedDoW)
  # head(dt2019[origDoW != fixedDoW])
  
  # 2018 Jan 1st = Mon
  dt2018 <- extractDT[year == 2018] 
  dt2018[, fixedDate := date2020 - 2]
  dt2018[, fixedDoW := lubridate::wday(fixedDate,label = TRUE)]
  # table(dt2018$origDoW, dt2018$fixedDoW)
  # head(dt2018[origDoW != fixedDoW])
  
  # 2017 Jan 1st = Sat
  dt2017 <- extractDT[year == 2017] 
  dt2017[, fixedDate := date2020 - 3]
  dt2017[, fixedDoW := lubridate::wday(fixedDate,label = TRUE)]
  # table(dt2017$origDoW, dt2017$fixedDoW)
  # head(dt2017[origDoW != fixedDoW])
  
  fixedDT <- rbind(dt2017, dt2018, dt2019, dt2020) # leave out 2016 for now
  
  fixedDT[, fixedDate := lubridate::as_date(fixedDate)]
  fixedDT[, fixedDoW := lubridate::wday(fixedDate,label = TRUE)]
  
  
  fixedDT[, compareYear := ifelse(year == 2020, "2020",
                                  "2017-2019")]
  
  # these should match 
  #table(fixedDT$origDoW, fixedDT$fixedDoW)
  fixedDT[, weekNo := lubridate::week(fixedDate)]
  return(fixedDT)
}

doReport <- function(rmd, vers){
  rmdFile <- paste0(myParams$projLoc, "/rmd/", rmd, ".Rmd")
  rmarkdown::render(input = rmdFile,
                    #output_format = "html_document2", # pdf fails on RStudio server
                    params = list(title = myParams$title,
                                  subtitle = myParams$subtitle,
                                  authors = myParams$authors),
                    output_file = paste0(myParams$projLoc,"/docs/", # for easy github pages management
                                         myParams$rmd, vers, ".html")
  )
}

# drake plan
plan <- drake::drake_plan(
  sotonAirData = loadSSCData(update),
  aurnData = loadAURNData(update),
  allData = rbind(aurnData[, .(dateTimeUTC, pollutant, source, site, value, ratified)],
                  sotonAirData[, .(dateTimeUTC, pollutant, source, site, value, ratified)]),
  fixedData = fixDates(allData)
)

plan # test the plan
make(plan) # run the plan, re-loading data if needed

# get the data back
fixedDT <- drake::readd(fixedData)

# test
fixedDT[, year := lubridate::year(dateTimeUTC)]
with(fixedDT, table(year, source))

with(fixedDT, table(pollutant, source))

fixedDT[, obsDate := lubridate::date(dateTimeUTC)] # put it back


# > Rmd settings ----

#> yaml ----
myParams$title <- "Air Quality in Southampton (UK)"
myParams$authors <- "Ben Anderson (b.anderson@soton.ac.uk `@dataknut`)"

# myParams$rmd <- "sccAirQualDataExtract" 
# myParams$subtitle <- "Extracting data for modelling"

myParams$rmd <- "sccAirQualExplore_covidLockdown2020ForBBCsnaphot"
myParams$version <- ""
# over-write version param for particlar versions
# myParams$version <- "_DEFRA_30_04_2020" # use this to keep particular versions
# sotonAirDT <- sotonAirDT[obsDate < as.Date("2020-04-27")]

myParams$subtitle <- "Exploring the effect of UK covid 19 lockdown on air quality: Summary for BBC South"

#myParams$rmd <- "sccAirQualExplore_windroses" 
#myParams$subtitle <- "Wind and pollution roses 2016-2020 (AURN data)"

# filter the data here
#origDataDT <- origDataDT[dateTimeUTC > lubridate::as_datetime("2020-01-01")]

# test what we have
fixedDT[!is.na(value), .(minDate = min(dateTimeUTC),
                            maxDate = max(dateTimeUTC)
                            ), 
           keyby = .(site, source)]

with(fixedDT, table(site, year, useNA = "always"))

# > run report ----
doReport(myParams$rmd, myParams$version) # un/comment to (not) run automatically
