# RtweetsDb


## Description

This project contains set of functions that interact with a database
of tweets.

It does the following general operations.

* creates db (sqlite tested at the moment, but other should work with minor modification);
* creates tables following schema (see config/db for twitter schema)
* creates many-two-many association between two models

And the following, twitter specific:

* creates table following schema (tweets, hashes, tweetsHashes)
* connects with twitter and gets tweets with specific hash
* updates tweets with new tweets only 
* updates tweetsHashes with new tweets/hashes only
* return data.frame of tweets for specific hash

## Future plans

* adds user model

## How it interacts with Twitter

* First you need to create twitter app at https://dev.twitter.com/
* Create file 'config/twitterAuth.R' and assign appropriate values to variables: 
`api_key, api_secret, access_token, access_token_secret`. That is
```R
# config/twitterAuth.R
api_key <- "API_KEY"
api_secret <- "API_SECRET"
access_token <- "ACCESS_TOKEN"
access_token_secret <- "ACCESS_TOKEN_SECRET"
```
This file should be ignored by git.
* From root directory of the project load functions:
```R
source('RtweetsDb.R')
```
* Authentication:
```R
twitterOAuth()
```
* Create Db and models:
```
createTwitterModels()
```
* Add hashes to DB:
```
addHash(c('#STOPDesigualdad','#IGUALES'))
```
* Update:
```
updateAllHashes()
```
As default it downloads 100 tweets per hash, change it in
`config/twitterDb.R`.
* Read tweets from Db associated to hash:
```
getTweetsFromDB('#STOPDesigualdad')
```

## Twitter Analitcs

There is complementary project https://github.com/sbartek/RtweetsAnalytics
that provide analytics for the Db created by this.

## Testing

    require('testthat')
    test_dir('tests/testthat')

