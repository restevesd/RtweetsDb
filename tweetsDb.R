require('DBI')
require("RSQLite")

con <- dbConnect(SQLite(), "rtweetsDb.db") 
dbDisconnect(con)
