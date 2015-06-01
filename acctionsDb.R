require('DBI')

getIds <- function(con, model) {
  queryTxt <- paste0("SELECT id FROM ", model)
  res <- dbSendQuery(con, queryTxt)
  dbFetch(res)$id
}
