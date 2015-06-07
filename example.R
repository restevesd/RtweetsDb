source('twitterDb.R')

twitterOAuth()
createTwitterModels()

addHash(c('#python', '#ruby', '#R', '#javascript'))

updateAllHashes()

#getAndSaveTweets('#testingRtweets')

dim(getTweetsFromDB('#R'))







