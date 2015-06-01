source('createDb.R')

dbFileName <- "db/tweets.db"

tweets.table.name <- "tweets"
tweets.table.schema.file.name <- "conf/db/tweetsTable.txt"

# creates tweets table

con <- getConnection(dbFileName)

if (!dbExistsTable(con, tweets.table.name)) {
  create.table(tweets.table.name, tweets.table.schema.file.name)
}

