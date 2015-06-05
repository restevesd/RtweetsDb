# TweetsDb

This project will contain set of function to interact with a database
that save tweets.

It does the following:

* creates db;
* creates table following schema (tweets, hashes, tweetsHashes);
* connects with twitter and gets tweets with specific hash
* updates tweets with new tweets only 
* updates tweetsHashes with new tweets/hashes only
* return data.frame of tweets for specific hash


## Plan

* more ...

## Testing

    require('testthat')
    test_dir('tests/testthat')

