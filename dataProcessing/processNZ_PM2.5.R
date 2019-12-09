# test NZ MfE air quality data

# source: https://data.mfe.govt.nz/data/category/environmental-reporting/air/

library(data.table)
library(ggplot2)

annualThreshold <- 10 # WHO
dailyThreshold <- 25 # WHO

dPath <- "~/Data/NZ_mfe/airQuality/"
pm2.5File <- "mfe-pm25-concentrations-200817-CSV/pm25-concentrations-200817.csv"

df <- paste0(dPath, pm2.5File)

pm2.5dt <- data.table::fread(df)
pm2.5dt[, ba_date := lubridate::as_date(date)]
# the data is daily but there may be gaps?
summary(pm2.5dt)
nrow(pm2.5dt)
uniqueN(pm2.5dt, by = c("site","date")) # if the same as aboe then no duplicates

plotDT <- pm2.5dt[, .(meanPM2.5 = mean(pm2_5)), keyby = .(council, ba_date)]
ggplot2::ggplot(plotDT, aes(x = ba_date, y = council, alpha = meanPM2.5)) +
  geom_tile()

ggplot2::ggplot(pm2.5dt, aes(x = ba_date, y = site, alpha = pm2_5)) +
  geom_tile()