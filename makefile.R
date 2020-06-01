# make file. Makes everything
library(airQual)
airQual::setup()

# refresh the data
source("dataProcessing/getAURNData.R")
#source("dataProcessing/getSouthamptonCityCouncilData.R")
source("dataProcessing/getSouthamptonHantsAir.R")

tablesToDelete <- data.table::tables()
l <- tablesToDelete[, NAME]
remove(list = l) # clear memory. Each script really ought to do this for itself

# run the lockdown analysis
# if you get memory errors restart R here, the rmarkdown::render() can fail
source("rmd/make_SotonLockdown.R")
