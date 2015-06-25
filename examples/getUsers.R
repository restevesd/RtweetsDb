# Working directory for this script should be the root of the project
# If this file is in working directory, you can run command
# setwd('..')
#

source('RtweetsDb.R')

twitterOAuth()
newHashes.list <- updateAllHashes()


users <- getAllUsers()

users
getTweetsFromDB('#IGUALES')
