require('twitteR')

# In file 'twitterAuth.R' one can assign appropriate values to variables: 
# api_key, api_secret, access_token, access_token_secret

if (file.exists('twitterAuth.R')) {
  source('twitterAuth.R')
}

source('createModels.R')
source('acctionsDb.R')
source('createDb.R')

models <- list(c("tweets", "conf/db/tweetsTable.txt"),
               c("hashes", "conf/db/hashesTable.txt") )


connection <- getConnection('db/tweets.db')
createModels(connection, models)

dbListTables(connection)

options(httr_oauth_cache=TRUE)
setup_twitter_oauth(api_key, api_secret, access_token, access_token_secret)

hash.txt <- '#python'
tweets.tweets <- searchTwitter(hash.txt, n=50, lang="es")
tweets.df <- twListToDF(tweets.tweets)


hash.row <- data.frame(hash='#python')
hash.row
dbAddChildrenM2M(connection, 'hashes', hash.row,
                 'tweets', tweets.df, father.pk='hash')
dbReadChildrenM2M(connection, 'hashes', hash.row,
                 'tweets', tweets.df, father.pk='hash')


tws <- dbReadTable(connection, "tweets")
dbReadTable(connection, "hashes")
dbReadTable(connection, "hashesTweets")
dbReadTable(connection, "tweets")





