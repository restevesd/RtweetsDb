db.file.name <- "db/tweets.db"

tweets.table.name <- "tweets"


tweets.table.schema.file.name <- "conf/db/tweetsTable.txt"

require('DBI')
require("RSQLite")

if (!file.exists('db')) dir.create('db')
con <- dbConnect(SQLite(), db.file.name) 

create.table <- function(table.name, schema.file.name) {
  table.columns <- readChar(schema.file.name, file.info(schema.file.name)$size)
  create.table.query <- paste0(
      "CREATE TABLE ",table.name,  " (",  table.columns, ");")
  dbSendQuery(con, create.table.query)
}


if (!dbExistsTable(con, tweets.table.name)) {
  create.table(tweets.table.name, tweets.table.schema.file.name)
}


dbExistsTable(con, tweets.table.name)









