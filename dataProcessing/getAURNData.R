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
dataPath <- path.expand("~/Data/SCC/airQual/aurn/")
#"2016", "2017", "2018", 
years <- c("2020")
sites <- c("SA33", "SOUT")

# get data ----
allDT <- data.table::data.table()

for(y in years){
  for(s in sites){
    df <- openair::importAURN(
      site = s,
      year = y,
      pollutant = "all",
      hc = FALSE,
      to_narrow = TRUE, # produces long form data yay!
      verbose = TRUE
    )
    dt <- data.table::as.data.table(df)
    allDT <- rbind(dt, allDT)
  }
}


pf <- paste0(dataPath,"processed/AURN_SSC_sites_hourlyAirQual_processed.csv")
data.table::fwrite(allDT, file = pf)
dkUtils::gzipIt(pf)

skimr::skim(allDT)

# done ----
