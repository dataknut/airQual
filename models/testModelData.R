# testing model results
library(data.table)
library(ggplot2)
library(GGally)   
library(lubridate)
library(skimr)

dPath <- path.expand("~/Dropbox/Work/DraftPapers/2020_AirQual_Covid/")

df <- "sotonExtract2017_2020_v2_predicted(0.01-0.5) Short TP.csv"

dt <- data.table::fread(paste0(dPath, df))

table(dt$Pollutant)

skimr::skim(dt)
dt[, year := lubridate::year(`Date Time UTC`)]

pointPlot <- ggplot2::ggplot(dt[Pollutant == "no2"], aes(x = Observed, 
                                            y = `Predicted (0.01)`,
                                            colour = Site)) +
  geom_point() +
  facet_grid(Site ~ .) +
  theme(legend.position="bottom")
ggsave(paste0(dPath, "pointPlot.jpg"),pointPlot)

pairsDT <- dt[, .(Observed, `Predicted (0.01)`, `Predicted (0.1)`, `Predicted (0.5)`)]

pairsPlot <- GGally::ggpairs(pairsDT)
ggsave(paste0(dPath, "pairsPlot.jpg"),pairsPlot)
