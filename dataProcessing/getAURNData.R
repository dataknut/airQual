# in which we download Southampton hourly air quality data
# or any others we choose using
# importAURN from http://davidcarslaw.github.io/openair/

library(openair)
library(data.table)
library(dkUtils)
library(skimr)
library(lubridate)

# sites in AURN speak:
# UKA00613 : A33 https://uk-air.defra.gov.uk/networks/site-info?site_id=SA33&view=View

dataPath <- path.expand("~/Data/SCC/airQual/aurn/")
#"2016", "2017", "2018", 
years <- c("2019")

dfW <- openair::importAURN(
  site = "SA33",
  year = 2019,
  pollutant = "all",
  hc = FALSE,
  meta = TRUE,
  to_narrow = FALSE, # produces long form data yay!
  verbose = TRUE # for now
)

dfL <- openair::importAURN(
  site = "SA33",
  year = 2019,
  pollutant = "all",
  hc = FALSE,
  meta = TRUE,
  to_narrow = TRUE, # produces long form data yay!
  verbose = FALSE
)

dtL <- data.table::as.data.table(dfL) # we like data.tables

openair::windRose(dfW) # only works with wide form
openair::pollutionRose(dfW, pollutant = "no") # only works with wide form
openair::calendarPlot(dfW, pollutant = "no")


# ws (wind speed)
# wd (wind direction) 

metaDT <- data.table::as.data.table(openair::importMeta())
