# make file. Makes everything

# refresh the data
source("dataProcessing/getAURNData.R")
#source("dataProcessing/getSouthamptonCityCouncilData.R")
source("dataProcessing/getSouthamptonHantsAir.R")

# run the lockdown analysis
source("rmd/make_SotonLockdown.R")
