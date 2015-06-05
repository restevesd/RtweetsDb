require('twitteR')

# In file 'twitterAuth.R' one can assign appropriate values to variables: 
# api_key, api_secret, access_token, access_token_secret

if (file.exists('twitterAuth.R')) {
  source('twitterAuth.R')
}

source('createModels.R')
source('acctionsDb.R')
source('createDb.R')

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

DBPATH <- 'db/tweets.db'

createTwitterModels <- function(db.path=DBPATH) {
  models <- list(c("tweets", "conf/db/tweetsTable.txt"),
                 c("hashes", "conf/db/hashesTable.txt") )
  connection <- getConnection(db.path)

  createModels(connection, models)
  dbDisconnect(connection)
}

createTwitterModels()

getAndSaveTweets <- function(hash.txt, n=100, db.path=DBPATH) {
  tweets.tweets <- searchTwitter(hash.txt, n, lang="es")
  tweets.df <- twListToDF(tweets.tweets)
  hash.row <- data.frame(hash=hash.txt)
  connection <- getConnection(db.path)
  dbAddChildrenM2M(connection, 'hashes', hash.row,
                   'tweets', tweets.df, father.pk='hash')
  dbDisconnect(connection)
}

getTweetsFromDB <- function(hash.txt, db.path=DBPATH) {
  connection <- getConnection(db.path)
  tweets.df <- dbReadChildrenM2M(connection, 'hashes', hash.txt,
                                 'tweets', father.pk='hash')
  dbDisconnect(connection)
  tweets.df
}
