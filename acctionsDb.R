require('DBI')

getColumn <- function(connection, model, column.names) {
  cols.txt <- paste(column.names, collapse=', ')
  query.txt <- paste("SELECT", cols.txt, "FROM", model)
  res <- dbSendQuery(connection, query.txt)
  dbFetch(res)
}

findExistingRows <- function(df1, df2, column.names) {
  ines <- c()
  ines=c(ines, which(df1[[column.names]] == 2))
}

dbWriteNewRows <- function(connection, model, df, pk='id') {
  if (dbExistsTable(connection, model)) {
    df.old <-   getColumn(connection, model, pk)
    newDf <- merge(df, df.old)
    dbWriteTable(connection, model, newDf, append=TRUE)
  } else {
    dbWriteTable(connection, model, df)
  }
}

