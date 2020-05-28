# file sourced by airQual::setup()

# Package parameters ----

aqParams <<- list() # params holder

# > Location of the repo ----
library(here)
aqParams$repoLoc <- here::here()

# Data ----
# attempt to guess the platform & user
aqParams$info <- Sys.info()
aqParams$sysname <- aqParams$info[[1]]
aqParams$nodename <- aqParams$info[[4]]
aqParams$login <- aqParams$info[[6]]
aqParams$user <- aqParams$info[[7]]

# > Set data path ----
if(aqParams$user == "ben" & aqParams$sysname == "Darwin"){
  # BA laptop
  aqParams$SCCdataPath <- path.expand("~/Data/SCC/airQual")
}
if(aqParams$user == "ba1e12" & startsWith(aqParams$nodename, "srv02405")){
  # UoS RStudio server
  aqParams$SCCdataPath <- path.expand("/mnt/SERG_data/airqual")
}

message("We're ", aqParams$user, " using " , aqParams$sysname, " on ", aqParams$nodename)
message("=> Base data path : ", aqParams$SCCdataPath)

# > Misc data ----
aqParams$bytesToMb <- 0.000001

# For .Rmd ----
# > Default yaml for Rmd ----
aqParams$pubLoc <- "[Sustainable Energy Research Centre](http://www.energy.soton.ac.uk), University of Southampton: Southampton"
aqParams$Authors <- "Anderson, B."

# > Rmd includes ----
aqParams$licenseCCBY <- paste0(aqParams$repoLoc, "/includes/licenseCCBY.Rmd")
aqParams$support <- paste0(aqParams$repoLoc, "/includes/supportGeneric.Rmd")
aqParams$history <- paste0(aqParams$repoLoc, "/includes/historyGeneric.Rmd")
aqParams$citation <- paste0(aqParams$repoLoc, "/includes/citationGeneric.Rmd")

