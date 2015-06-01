require('twitteR')

# In file 'twitterAuth.R' one can assign appropriate values to variables: 
# api_key, api_secret, access_token, access_token_secret

if (file.exists('twitterAuth.R')) {
  source('twitterAuth.R')
}

source('createTwiterModels.R')

dbListTables(connection)

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

dm.tweets <- searchTwitter("#python", n=50, lang="es")

dm.df <- twListToDF(dm.tweets)

dbReadTable(connection, "tweets")
dbReadTable(connection, "hashes")
dbReadTable(connection, "tweetsHashes")
dbWriteTable(connection, "tweets", dm.df, append=TRUE)
dbReadTable(connection, "tweets")

source("acctionsDb.R")
getIds(connection, "tweets")
