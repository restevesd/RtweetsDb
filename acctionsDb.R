require('DBI')

getColumn <- function(connection, model, column.name) {
  query.txt <- paste0("SELECT ", column.name, " FROM ", model)
  res <- dbSendQuery(connection, query.txt)
  res <- dbFetch(res)
  res[[column.name]]
}

getIds <-function(connection, model) {
  getColumn(connection, model, 'id')
}

dbWriteNewRows <- function(connection, model, df) {
  if (dbExistsTable(connection, model)) {
    ids <- getIds(connection, model)
    newDf <- subset(df, !(id %in% ids))
    dbWriteTable(connection, model, newDf, append=TRUE)
  } else {
    dbWriteTable(connection, model, df)
  }
}

