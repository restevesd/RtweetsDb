require('twitteR')

# In file 'twitterAuth.R' one can assign appropriate values to variables: 
# api_key, api_secret, access_token, access_token_secret

if (file.exists('twitterAuth.R')) {
  source('twitterAuth.R')
}

source('createTwitterModels.R')
source('acctionsDb.R')
source('createDb.R')

models <- list(c("tweets", "conf/db/tweetsTable.txt"),
               c("hashes", "conf/db/hashesTable.txt"),
               c("hashesTweets", "conf/db/hashesTweetsTable.txt"))

connection <- getConnection('db/tweets.db')
createModels(connection, models)

dbListTables(connection)

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

dm.tweets <- searchTwitter("#python", n=50, lang="es")

dm.df <- twListToDF(dm.tweets)

tws <- dbReadTable(connection, "tweets")
dbReadTable(connection, "hashes")
dbReadTable(connection, "tweetsHashes")
dbWriteNewRows(connection, "tweets", dm.df)
dbReadTable(connection, "tweets")

source("acctionsDb.R")
getIds(connection, "tweets")
