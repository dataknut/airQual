# in which we download Southampton hourly air quality data
# or any others we choose using
# importAURN from http://davidcarslaw.github.io/openair/

# Libraries ----
library(openair)
library(data.table)
library(dkUtils)
library(skimr)
library(lubridate)

# Parameters ----
# sites in AURN speak:
# UKA00613 : A33 https://uk-air.defra.gov.uk/networks/site-info?site_id=SA33&view=View
# SOUT https://uk-air.defra.gov.uk/networks/site-info?site_id=SOUT&view=View

# Data cookery: https://uk-air.defra.gov.uk/assets/documents/Data_Validation_and_Ratification_Process_Apr_2017.pdf
dataPath <- path.expand(paste0(aqParams$SCCdataPath, "/aurn/"))
#"2016", "2017", "2018", "2019" # use these to update further back
years <- c("2020")
sites <- c("SA33", "SOUT")

# get data ----
lyearDT <- data.table::data.table()
wyearDT <- data.table::data.table()
aurnRawDT <- data.table::data.table()
  
for(y in years){
  # long form
  for(s in sites){
    df <- openair::importAURN(
      site = s,
      year = y,
      pollutant = "all",
      hc = FALSE,
      to_narrow = TRUE, # produces long form data yay!
      verbose = TRUE
    )
    ldt <- data.table::as.data.table(df)
    lyearDT <- rbind(ldt, lyearDT)
  }
  of <- paste0(dataPath,"processed/AURN_SSC_sites_hourlyAirQual_processed_", y,"_long.csv")
  data.table::fwrite(lyearDT, file = of)
  dkUtils::gzipIt(of)
  
  # wide form
  for(s in sites){
    df <- openair::importAURN(
      site = s,
      year = y,
      pollutant = "all",
      hc = FALSE,
      to_narrow = FALSE, # produces wide form data
      verbose = TRUE
    )
    dt <- data.table::as.data.table(df)
    wyearDT <- rbind(dt, wyearDT, fill = TRUE) # different number of columns
  }
  of <- paste0(dataPath,"processed/AURN_SSC_sites_hourlyAirQual_processed_", y,"_wide.csv")
  data.table::fwrite(wyearDT, file = of)
  dkUtils::gzipIt(of)
  aurnRawDT <- rbind(aurnRawDT, lyearDT)
  wyearDT <- NULL
  lyearDT <- NULL
}

aurnRawDT[, obsDateTimeUTC := lubridate::as_datetime(date)]
summary(aurnRawDT)

# Last data entry:
lastData <- max(aurnRawDT[!is.na(value), (obsDateTimeUTC)])
lastData

now() - lastData

# done ----
