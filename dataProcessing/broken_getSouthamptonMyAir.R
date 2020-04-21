# in which we download Southampton hourly air quality data from:

# http://southampton.my-air.uk

# seems to have stopped working

# (NOT from AURN)

# Libraries ----
library(curl)
library(data.table)
library(dkUtils)
library(skimr)
library(lubridate)

# format: http://southampton.my-air.uk/singlela/relay/access.php?data=graph-data&SiteCode=SH1&StartDate=2019-11-29&EndDate=2019-12-07&download=1
# Getting http://southampton.my-air.uk/singlela/relay/access.php?data=graph-data&SiteCode=SH05&StartDate=2019-01-01&EndDate=2019-12-31&download=1

# Parameters ----

# > years ----
#"2016", "2017", "2018", 
years <- c("2020")
upTo <- lubridate::today()

# > locations ----
locs <- list()
# sites: SH0 - 5 <- Southampton
# SH0 A33 Roadside AURN
locs$sh0 <- "Southampton - A33 Roadside\n(near docks, AURN site)"
# SH1 Southampton Background AURN
locs$sh1 <- "Southampton - Background\n(near city centre, AURN site)"
locs$sh2 <- "Southampton - Redbridge"
# SH3 Onslow Road
locs$sh3 <- "Southampton - Onslow Road\n(near RSH)"
locs$sh4 <- "Southampton - Bitterne"
# SH5 Victoria Road
locs$sh5 <- "Southampton - Victoria Road\n(Woolston)"

#sites: <- Eastleigh
# ES1 Southampton Road
locs$es1 <- "Eastleigh - Southampton Road (Centre)"
# ES2 Steele Close
locs$es2 <- "Eastleigh - Steele Close (near M3)"
# ES3 The Point
locs$es3 <- "Eastleigh - The Point (Centre)"

baseUrl <- "http://southampton.my-air.uk/singlela/relay/access.php?data=graph-data"
dataPath <- path.expand("~/Data/SCC/airQual/direct/")

metaDT <- data.table::data.table() # meta data bucket

# Functions ----
refreshData <- function(years){
  sites <- c("0", "1", "2", "3", "4", "5")
  for(y in years){
    for(s in sites){
      council <- "SH" # set to Southampton for now
      rDataF <- paste0(baseUrl, "&SiteCode=", council, s,"&StartDate=" ,y, "-01-01&EndDate=", y,"-12-31&download=1")
      print(paste0("Getting ",  rDataF))
      dt <- data.table::fread(rDataF) # not exported
      of <- paste0(dataPath,"raw/", y, "_SSC_site_", s, "_hourlyAirQual.csv")
      data.table::fwrite(dt, file = of)
      dkUtils::gzipIt(of)
      
      # site specific variable coding (so we can combine the whole lot)
      message("Site = ", s)
      message("Variables", names(dt))
      
      if(s == 0){
        # the column names are specific to the site so can't loop easily :-(
        loc <- locs$sh0
        message("Location: ", loc)
        dt[, no := `Southampton - A33 Roadside AURN: Nitric Oxide (ug/m3)`]
        dt[, no2 := `Southampton - A33 Roadside AURN: Nitrogen Dioxide (ug/m3)`]
        dt[, nox := `Southampton - A33 Roadside AURN: Oxides of Nitrogen (ug/m3)`]
        dt[, pm10 := `Southampton - A33 Roadside AURN: PM10 Particulate (ug/m3)`]
        dt[, site := loc]
        dt <- dt[, .(site, MeasurementDateGMT, no, no2, nox, pm10)]
      }
      if(s == 1){
        loc <- locs$sh1
        message("Location: ", loc)
        dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, no := `Southampton Background AURN: Nitric Oxide (ug/m3)`]
        dt[, no2 := `Southampton Background AURN: Nitrogen Dioxide (ug/m3)`]
        dt[, nox := `Southampton Background AURN: Oxides of Nitrogen (ug/m3)`]
        dt[, oz := `Southampton Background AURN: Ozone (ug/m3)`]
        dt[, pm10 := `Southampton Background AURN: PM10 Particulate (ug/m3)`]
        dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        dt[, so2 := `Southampton Background AURN: Sulphur Dioxide (ug/m3)`]
        dt[, site := loc]
        dt <- dt[, .(site, MeasurementDateGMT, co, no, no2, nox, oz, pm10, pm2_5, so2)]
      }
      if(s == 2){
        loc <- locs$sh2
        message("Location: ", loc)
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, no := `Southampton - Redbridge: Nitric Oxide (ug/m3)`]
        dt[, no2 := `Southampton - Redbridge: Nitrogen Dioxide (ug/m3)`]
        dt[, nox := `Southampton - Redbridge: Oxides of Nitrogen (ug/m3)`]
        dt[, oz := `Southampton - Redbridge: Ozone (ug/m3)`]
        dt[, pm10 := `Southampton - Redbridge: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        dt[, so2 := `Southampton - Redbridge: Sulphur Dioxide (ug/m3)`]
        dt[, site := loc]
        dt <- dt[, .(site, MeasurementDateGMT, no, no2, nox, oz, pm10, so2)]
      }
      if(s == 3){
        loc <- locs$sh3
        message("Location: ", loc)
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, no := `Southampton - Onslow Road: Nitric Oxide (ug/m3)`]
        dt[, no2 := `Southampton - Onslow Road: Nitrogen Dioxide (ug/m3)`]
        dt[, nox := `Southampton - Onslow Road: Oxides of Nitrogen (ug/m3)`]
        #dt[, oz := `Southampton - Onslow Road: Ozone (ug/m3)`]
        #dt[, pm10 := `Southampton - Onslow Road: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        #dt[, so2 := `Southampton - Onslow Road: Sulphur Dioxide (ug/m3)`]
        dt[, site := loc]
        dt <- dt[, .(site, MeasurementDateGMT, no, no2, nox)]
      }
      if(s == 4){
        loc <- locs$sh4
        message("Location: ", loc)
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, no := `Southampton - Bitterne: Nitric Oxide (ug/m3)`]
        dt[, no2 := `Southampton - Bitterne: Nitrogen Dioxide (ug/m3)`]
        dt[, nox := `Southampton - Bitterne: Oxides of Nitrogen (ug/m3)`]
        #dt[, oz := `Southampton Background AURN: Ozone (ug/m3)`]
        dt[, pm10 := `Southampton - Bitterne: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        dt[, so2 := `Southampton - Bitterne: Sulphur Dioxide (ug/m3)`]
        dt[, site := loc]
        dt <- dt[, .(site, MeasurementDateGMT, no, no2, nox, pm10, so2)]
      }
      if(s == 5){
        loc <- locs$sh5
        message("Location: ", loc)
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, no := `Southampton - Victoria Road: Nitric Oxide (ug/m3)`]
        dt[, no2 := `Southampton - Victoria Road: Nitrogen Dioxide (ug/m3)`]
        dt[, nox := `Southampton - Victoria Road: Oxides of Nitrogen (ug/m3)`]
        #dt[, oz := `Southampton Background AURN: Ozone (ug/m3)`]
        #dt[, pm10 := `Southampton - Victoria Road: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        #dt[, so2 := `Southampton - Victoria Road: Sulphur Dioxide (ug/m3)`]
        dt[, site := loc]
        dt[, .(site, MeasurementDateGMT, no, no2, nox)]
      }
      dt[, dateTimeUTC := lubridate::ymd_hm(MeasurementDateGMT)] # makes life so much easier later
      pf <- paste0(dataPath,"processed/", y, "_SSC_site_", s, "_hourlyAirQual_processed.csv")
      data.table::fwrite(dt, file = pf)
      dkUtils::gzipIt(pf)
      meta <- dt[, .(startDate = min(dateTimeUTC),
                     endDate = max(dateTimeUTC),
                     site = loc,
                     year = y)]
      metaDT <- rbind(metaDT, meta)
    }
  }
  return(metaDT)
}

# code ----
# do not run - will over-write existing data with NULL as my-air has stopped
#metaDT <- refreshData(years = years)

# done ----
# check what arrived
metaDT
