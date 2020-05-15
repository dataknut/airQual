# in which we download Southampton hourly air quality data from:

# http://southampton.my-air.uk

# (NOT from AURN)

# Libraries ----
library(curl)
library(data.table)
library(dkUtils)
library(skimr)
library(lubridate)

# http://www.hantsair.org.uk/hampshire/asp/DownloadSite.asp?la=Southampton&site=SH0&species1=NOm&species2=NO2m&species3=NOXm&species4=PM10m&species5=PM25&species6=&start=1-jan-2020&end=31-jan-2020&res=6&period=hourly&units=

# Parameters ----

# > years ----
# "2010","2011","2012","2013", "2014", "2015", "2016", "2017", "2018","2019"
years <- c("2020")
upTo <- lubridate::today() # could use this to limit current year search but...

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

baseUrl <- "http://www.hantsair.org.uk/hampshire/asp/DownloadSite.asp?la=Southampton"
#dataPath <- path.expand("~/Data/SCC/airQual/hantsAir/")
dataPath <- path.expand(paste0(aqParams$SCCdataPath, "/hantsAir/"))

metaDT <- data.table::data.table() # meta data bucket

# Functions ----
refreshData <- function(years){
  sites <- c("0", "1", "2", "3", "4", "5")
  for(y in years){
    for(s in sites){
      council <- "SH" # set to Southampton for now
      # # http://www.hantsair.org.uk/hampshire/asp/DownloadSite.asp?la=Southampton&site=SH0
      # &species1=NOm&species2=NO2m&species3=NOXm&species4=PM10m&species5=PM25&species6=&start=1-jan-2020&end=31-jan-2020&res=6&period=hourly&units=
#http://www.hantsair.org.uk/hampshire/asp/DownloadSite.asp?la=Southampton&site=SH1&species1=COm&species2=O3m&species3=PM25m&species4=SO2m&species5=&species6=&start=1-jan-2020&end=2-jan-2020&res=6&period=15min&units=
      
      if(s == 0){
        # http://www.hantsair.org.uk/hampshire/asp/DataSite.asp?la=Southampton
        # SH0 : Southampton - A33 Roadside AURN
        # Nitric Oxide (ug/m3) 	
        # Nitrogen Dioxide (ug/m3) 	
        # Oxides of Nitrogen (ug/m3 as NO2) 	
        # PM10 Particulate (by FDMS) (ug/m3)
        loc <- locs$sh0
        message("Location: ", loc)
        # have to specify species precisely for each site
        rDataF <- paste0(baseUrl, "&site=", council, s,
                         "&species1=NOm&species2=NO2m&species3=NOXm&species4=PM10m",
                         "&start=" ,y, "-01-01&end=", y,"-12-31",
                         "&res=6&period=hourly&units=")
      }
      if(s == 1){
        # http://www.hantsair.org.uk/hampshire/asp/DataSite.asp?la=Southampton
        # SH1 : Southampton Background AURN
        # Carbon Monoxide (mg/m3) 	
        # Nitric Oxide (ug/m3) 	
        # Nitrogen Dioxide (ug/m3) 	
        # Oxides of Nitrogen (ug/m3 as NO2) 	
        # Ozone (ug/m3) 	
        # PM10 Particulate (by FDMS) (ug/m3) 	
        # PM2.5 Particulate (by FDMS) (ug/m3) 	
        # Sulphur Dioxide (ug/m3)
        loc <- locs$sh1
        message("Location: ", loc)
        # have to specify species precisely for each site
        # can only get 6 max
        rDataF <- paste0(baseUrl, "&site=", council, s,
                         "&species1=NOm&species2=NO2m&species3=NOXm&species4=PM10m&species5=PM25m&species6=SO2m",
                         "&start=" ,y, "-01-01&end=", y,"-12-31",
                         #"&start=1996-01-01&end=2020-12-31",
                         "&res=6&period=hourly&units=")
      }
      if(s == 2){
        # Southampton - Redbridge
        # Nitric Oxide (ug/m3) 	
        # Nitrogen Dioxide (ug/m3) 	
        # Oxides of Nitrogen (ug/m3 as NO2) 	
        # Ozone (ug/m3) 	
        # PM10 Particulate (by TEOM) (ug/m3) 	
        # Sulphur Dioxide (ug/m3)
        loc <- locs$sh2
        message("Location: ", loc)
        # have to specify species precisely for each site
        # can only get 6 max
        rDataF <- paste0(baseUrl, "&site=", council, s,
                         "&species1=NOm&species2=NO2m&species3=NOXm&species4=PM10m&species3=SO2m",
                         "&start=" ,y, "-01-01&end=", y,"-12-31",
                         "&res=6&period=hourly&units=")
      }
      if(s == 3){
        # Southampton - Onslow Road
        # Nitric Oxide (ug/m3) 	
        # Nitrogen Dioxide (ug/m3) 	
        # Oxides of Nitrogen (ug/m3 as NO2)
        loc <- locs$sh3
        message("Location: ", loc)
        # have to specify species precisely for each site
        # can only get 6 max
        rDataF <- paste0(baseUrl, "&site=", council, s,
                         "&species1=NOm&species2=NO2m&species3=NOXm",
                         "&start=" ,y, "-01-01&end=", y,"-12-31",
                         "&res=6&period=hourly&units=")
      }
      if(s == 4){
        # http://www.hantsair.org.uk/hampshire/asp/DataSite.asp?la=Southampton
        # SH4 : Southampton - Bitterne
        # Nitric Oxide (ug/m3) 	
        # Nitrogen Dioxide (ug/m3) 	
        # Oxides of Nitrogen (ug/m3 as NO2) 	
        # PM10 Particulate (by TEOM) (ug/m3) 	
        # Sulphur Dioxide (ug/m3)
        loc <- locs$sh4
        message("Location: ", loc)
        # have to specify species precisely for each site
        # can only get 6 max
        rDataF <- paste0(baseUrl, "&site=", council, s,
                         "&species1=NOm&species2=NO2m&species3=NOXm&species4=PM10m&species5=PM25m&species6=SO2m",
                         "&start=" ,y, "-01-01&end=", y,"-12-31",
                         "&res=6&period=hourly&units=")
      }
      if(s == 5){
        # Southampton - Victoria Road
        # Nitric Oxide (ug/m3) 	
        # Nitrogen Dioxide (ug/m3) 	
        # Oxides of Nitrogen (ug/m3 as NO2)
        loc <- locs$sh5
        message("Location: ", loc)
        # have to specify species precisely for each site
        # can only get 6 max
        rDataF <- paste0(baseUrl, "&site=", council, s,
                         "&species1=NOm&species2=NO2m&species3=NOX",
                         "&start=" ,y, "-01-01&end=", y,"-12-31",
                         "&res=6&period=hourly&units=")
      }
      print(paste0("Getting ",  rDataF)) # gets set inside each if()
      try(dt <- data.table::fread(rDataF)) # might fail
      dt[, siteLoc := loc] # gets set inside each if()
      of <- paste0(dataPath,"raw/", y, "_hantsAir_site_", council,s, "_hourlyAirQual.csv")
      # as received
      data.table::fwrite(dt, file = of)
      dkUtils::gzipIt(of)
      
      # site specific variable coding (so we can combine the whole lot)
      message("Site = ", council, s)
      #message("Variables", names(dt))
      
      dt[, dateTimeUTC := lubridate::dmy_hm(ReadingDateTime)] # makes life so much easier later
      dt[, pollutant := Species] # to line up with my-air format
      dt[, source := "hantsAir"]
      dt[, siteCode := Site]
      dt[, site := siteLoc]
      dt[, value := Value]
      pf <- paste0(dataPath,"processed/", y, "_hantsAir_site_", council, s, "_hourlyAirQual_processed.csv")
      data.table::fwrite(dt, file = pf)
      dkUtils::gzipIt(pf)
      meta <- dt[, .(startDate = min(dateTimeUTC),
                     endDate = max(dateTimeUTC),
                     site = loc, # most recent
                     year = y)]
      metaDT <- rbind(metaDT, meta)
    }
  }
  return(metaDT)
}

# code ----
metaDT <- refreshData(years = years)

# done ----
# check what arrived
metaDT
