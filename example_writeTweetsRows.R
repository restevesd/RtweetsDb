require('twitteR')

# In file 'twitterAuth.R' one can assign appropriate values to variables: 
# api_key, api_secret, access_token, access_token_secret

if (file.exists('twitterAuth.R')) {
  source('twitterAuth.R')
}

source('createModels.R')
source('acctionsDb.R')
source('createDb.R')

models <- list(c("tweets", "conf/db/tweetsTable.txt"))

connection <- getConnection('db/tweets.db')
createModels(connection, models)

dbListTables(connection)

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

hash.txt <- '#python'

tweets2.tweets <- searchTwitter(hash.txt, n=2, lang="es")
tweets2.df <- twListToDF(tweets2.tweets)
dbWriteNewRows(connection, 'tweets', tweets2.df)
print(dbReadTable(connection, 'tweets'))

tweets3.tweets <- searchTwitter(hash.txt, n=3, lang="es")
tweets3.df <- twListToDF(tweets3.tweets)
dbWriteNewRows(connection, 'tweets', tweets3.df)
print(dbReadTable(connection, 'tweets'))

dbDisconnect(connection)
