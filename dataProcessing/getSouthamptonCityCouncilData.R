# in which we download Southampton hourly air quality data

library(curl)
library(data.table)
library(dkUtils)
library(skimr)
library(lubridate)
library(ggplot2)
library(plotly)

# format: http://southampton.my-air.uk/singlela/relay/access.php?data=graph-data&SiteCode=SH1&StartDate=2019-11-29&EndDate=2019-12-07&download=1
# Getting http://southampton.my-air.uk/singlela/relay/access.php?data=graph-data&SiteCode=SH05&StartDate=2019-01-01&EndDate=2019-12-31&download=1
# sites: SH0 - 5

baseUrl <- "http://southampton.my-air.uk/singlela/relay/access.php?data=graph-data"
dataPath <- path.expand("~/Data/SCC/airQual/")
years <- c("2018", "2019")

refreshData <- function(years){
  sites <- c("0", "1", "2", "3", "4", "5")
  for(y in years){
    for(s in sites){
      rDataF <- paste0(baseUrl, "&SiteCode=SH", s,"&StartDate=" ,y, "-01-01&EndDate=", y,"-12-31&download=1")
      print(paste0("Getting ",  rDataF))
      dt <- data.table::fread(rDataF) # not exported
      of <- paste0(dataPath,"raw/", y, "_SSC_site_", s, "_hourlyAirQual.csv")
      data.table::fwrite(dt, file = of)
      dkUtils::gzipIt(of)
      
      # site specific variable coding (so we can combine the whole lot)
      message("Site = ", s)
      message("Variables", names(dt))
      
      if(s == 0){
        # Southampton - A33 Roadside AURN: Nitric Oxide (ug/m3)	
        # Southampton - A33 Roadside AURN: Nitrogen Dioxide (ug/m3)	
        # Southampton - A33 Roadside AURN: Oxides of Nitrogen (ug/m3)	
        # Southampton - A33 Roadside AURN: PM10 Particulate (ug/m3)
        dt[, nox := `Southampton - A33 Roadside AURN: Nitric Oxide (ug/m3)`]
        dt[, nox2 := `Southampton - A33 Roadside AURN: Nitrogen Dioxide (ug/m3)`]
        dt[, noxes := `Southampton - A33 Roadside AURN: Oxides of Nitrogen (ug/m3)`]
        dt[, pm10 := `Southampton - A33 Roadside AURN: PM10 Particulate (ug/m3)`]
        dt[, site := "Southampton - A33 Roadside AURN"]
        dt <- dt[, .(MeasurementDateGMT, nox, nox2, noxes, pm10, site)]
      }
      if(s == 1){
        dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, nox := `Southampton Background AURN: Nitric Oxide (ug/m3)`]
        dt[, nox2 := `Southampton Background AURN: Nitrogen Dioxide (ug/m3)`]
        dt[, noxes := `Southampton Background AURN: Oxides of Nitrogen (ug/m3)`]
        dt[, oz := `Southampton Background AURN: Ozone (ug/m3)`]
        dt[, pm10 := `Southampton Background AURN: PM10 Particulate (ug/m3)`]
        dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        dt[, so2 := `Southampton Background AURN: Sulphur Dioxide (ug/m3)`]
        dt[, site := "Southampton Background AURN"]
        dt <- dt[, .(MeasurementDateGMT, co, nox, nox2, noxes, oz, pm10, pm2_5, so2, site)]
      }
      if(s == 2){
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, nox := `Southampton - Redbridge: Nitric Oxide (ug/m3)`]
        dt[, nox2 := `Southampton - Redbridge: Nitrogen Dioxide (ug/m3)`]
        dt[, noxes := `Southampton - Redbridge: Oxides of Nitrogen (ug/m3)`]
        dt[, oz := `Southampton - Redbridge: Ozone (ug/m3)`]
        dt[, pm10 := `Southampton - Redbridge: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        dt[, so2 := `Southampton - Redbridge: Sulphur Dioxide (ug/m3)`]
        dt[, site := "Southampton - Redbridge"]
        dt <- dt[, .(MeasurementDateGMT, nox, nox2, noxes, oz, pm10, so2, site)]
      }
      if(s == 3){
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, nox := `Southampton - Onslow Road: Nitric Oxide (ug/m3)`]
        dt[, nox2 := `Southampton - Onslow Road: Nitrogen Dioxide (ug/m3)`]
        dt[, noxes := `Southampton - Onslow Road: Oxides of Nitrogen (ug/m3)`]
        #dt[, oz := `Southampton - Onslow Road: Ozone (ug/m3)`]
        #dt[, pm10 := `Southampton - Onslow Road: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        #dt[, so2 := `Southampton - Onslow Road: Sulphur Dioxide (ug/m3)`]
        dt[, site := "Southampton - Onslow Road"]
        dt <- dt[, .(MeasurementDateGMT, nox, nox2, noxes, site)]
      }
      if(s == 4){
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, nox := `Southampton - Bitterne: Nitric Oxide (ug/m3)`]
        dt[, nox2 := `Southampton - Bitterne: Nitrogen Dioxide (ug/m3)`]
        dt[, noxes := `Southampton - Bitterne: Oxides of Nitrogen (ug/m3)`]
        #dt[, oz := `Southampton Background AURN: Ozone (ug/m3)`]
        dt[, pm10 := `Southampton - Bitterne: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        dt[, so2 := `Southampton - Bitterne: Sulphur Dioxide (ug/m3)`]
        dt[, site := "Southampton - Bitterne"]
        dt <- dt[, .(MeasurementDateGMT, nox, nox2, noxes, pm10, so2, site)]
      }
      if(s == 5){
        #dt[, co := `Southampton Background AURN: Carbon Monoxide (mg/m3)`]
        dt[, nox := `Southampton - Victoria Road: Nitric Oxide (ug/m3)`]
        dt[, nox2 := `Southampton - Victoria Road: Nitrogen Dioxide (ug/m3)`]
        dt[, noxes := `Southampton - Victoria Road: Oxides of Nitrogen (ug/m3)`]
        #dt[, oz := `Southampton Background AURN: Ozone (ug/m3)`]
        #dt[, pm10 := `Southampton - Victoria Road: PM10 Particulate (ug/m3)`]
        #dt[, pm2_5 := `Southampton Background AURN: PM2.5 Particulate (ug/m3)`]
        #dt[, so2 := `Southampton - Victoria Road: Sulphur Dioxide (ug/m3)`]
        dt[, site := "Southampton - Victoria Road"]
        dt <- dt[, .(MeasurementDateGMT, nox, nox2, noxes, site)]
      }
    
      pf <- paste0(dataPath,"processed/", y, "_SSC_site_", s, "_hourlyAirQual_processed.csv")
      data.table::fwrite(dt, file = pf)
      dkUtils::gzipIt(pf)
    }
  }
}

refreshData(years)
