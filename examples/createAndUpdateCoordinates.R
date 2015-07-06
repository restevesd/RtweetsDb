## Working directory for this script should be the root of the project
## If this file is in working directory, you can run command
## setwd('..')

source('RtweetsDb.R')


createCoordinatesModel()


lookupAndAddCoordinates(c("Barcelona", "Zaragoza"))

lookupAndAddCoordinates(c("Barcelona", "Antofagasta"))

lookupAndAddCoordinates(c("Barcelona", "Antofagasta", "Warszawa", "Denton", "Coventry"))

lookupAndAddCoordinates(c("Barcelona", "Bialystok"))
