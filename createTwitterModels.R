source('createDb.R')

## models <- list(c("tweets", "conf/db/tweetsTable.txt"),
##                c("hashes", "conf/db/hashesTable.txt"),
##                c("tweetsHashes", "conf/db/tweetsHashesTable.txt"))

##                                         #dbFileName="db/tweets.db"

createModels <- function(connection, models) {
  lapply(models, function(model) {
    createTableFromFile(connection, model[1], model[2])
  })
}

