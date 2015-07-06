## Working directory for this script should be the root of the project
## If this file is in working directory, you can run command
## setwd('..')

source('RtweetsDb.R')

twitterOAuth()
createTwitterModels() # follows schemas in config/db

tweets.df <- getAll('tweets')
