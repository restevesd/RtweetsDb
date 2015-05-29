require('twitteR')

# In file 'twitterAuth.R' one can assign appropriate values to variables: 
# api_key, api_secret, access_token, access_token_secret

if (file.edit('twitterAuth.R')) {
  source('twitterAuth.R')
}
source('createDb.R')

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

dm.tweets <- searchTwitter("#python", n=50, lang="es")

dm.df <- twListToDF(dm.tweets)

dbReadTable(con, "tweets")
dbWriteTable(con, "tweets", dm.df, append=TRUE)
dbReadTable(con, "tweets")
