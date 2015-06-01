require('DBI')
require("RSQLite")

getConnection <- function(dbFileName) {
  if (!file.exists('db')) dir.create('db')
  dbConnect(SQLite(), dbFileName) 
}

create.table <- function(connection, table.name,
                         schema.file.name) {
  table.columns <- readChar(schema.file.name, file.info(schema.file.name)$size)
  create.table.query <- paste0(
      "CREATE TABLE ",table.name,  " (",  table.columns, ");")
  dbSendQuery(connection, create.table.query)
}












