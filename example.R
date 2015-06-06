source('twitterDb.R')

createTwitterModels()


getAndSaveTweets('#python')
getAndSaveTweets('#ruby')
getAndSaveTweets('#R')
getAndSaveTweets('#javascript')

getTweetsFromDB('#python')

updateAllHashes()






