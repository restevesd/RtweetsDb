require('DBI')

capitalize <- function(chars) {
  paste0(toupper(substring(chars, 1, 1)), substring(chars, 2))
}

getColumn <- function(connection, model, column.names) {
  cols.txt <- paste(column.names, collapse=', ')
  query.txt <- paste("SELECT", cols.txt, "FROM", model)
  res <- dbSendQuery(connection, query.txt)
  dbFetch(res)
}

dbWriteNewRows <- function(connection, model, df, pk='id') {
  if (dbExistsTable(connection, model)) {
    df.old <-   getColumn(connection, model, pk)
    if (dim(df.old)[1]!=0) {
      df.old$dbWriteNewRowsControllX152 <- rep('old',dim(df.old)[1])
      mergedDF <- merge(df, df.old, all.x=TRUE, by=pk)
      ines.new <- which(is.na(mergedDF$dbWriteNewRowsControllX152))
      if (length(ines.new)!=0) {
        dbWriteTable(connection, model, df[ines.new,], append=TRUE)
      }
    } else {
      dbWriteTable(connection, model, df, append=TRUE)
    }
  } else {
    dbWriteTable(connection, model, df)
  }
}

dbAddChildrenM2M <- function(connection,
                             father.model, father.row, 
                             children.model, children.df,
                             father.pk='id', children.pk='id',
                             through=NULL
                             ) {
  dbWriteNewRows(connection, father.model, father.row, pk=father.pk)
  dbWriteNewRows(connection, children.model, children.df, pk=children.pk)
  if (is.null(through)) {
    models <- sort(c(father.model,children.model))
    join.model <- paste0(models[1],capitalize(models[2]))
    father.cname <- paste0(father.model,'_fk')
    children.cname <- paste0(children.model,'_fk')
    children.pks <- children.df[[c(children.pk)]]
    n <- length(children.pks)
    join.df <- data.frame(c(children.pks), rep(father.row[[father.pk]], n))
    join.colnames <- c(children.cname, father.cname)
    colnames(join.df) <- join.colnames
    dbWriteNewRows(connection, join.model, join.df, pk=join.colnames)
  }

}
