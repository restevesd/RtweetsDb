source('createDb.R')

tweets.table.name <- "tweets"
tweets.table.schema.file.name <- "conf/db/tweetsTable.txt"

# creates tweets table

if (!dbExistsTable(con, tweets.table.name)) {
  create.table(tweets.table.name, tweets.table.schema.file.name)
}

