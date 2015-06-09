source('twitterDb.R')

twitterOAuth()
createTwitterModels()

addHash(c('#STOPDesigualdad','#IGUALES'))

updateAllHashes()

#getAndSaveTweets('#testingRtweets')

dim(getTweetsFromDB('#STOPDesigualdad'))







