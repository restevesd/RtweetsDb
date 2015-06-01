db.file.name <- "db/tweets.db"

require('DBI')
require("RSQLite")

if (!file.exists('db')) dir.create('db')
con <- dbConnect(SQLite(), db.file.name) 

create.table <- function(table.name, schema.file.name, db.file.name=db.file.name) {
  table.columns <- readChar(schema.file.name, file.info(schema.file.name)$size)
  create.table.query <- paste0(
      "CREATE TABLE ",table.name,  " (",  table.columns, ");")
  dbSendQuery(con, create.table.query)
}












