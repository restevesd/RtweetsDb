require('twitteR')
source('twitterAuth.R')
source('createDB.R')

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

dm.tweets <- searchTwitter("#python", n=50, lang="es")

dm.df <- twListToDF(dm.tweets)

