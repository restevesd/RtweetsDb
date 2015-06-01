source('createDb.R')

dbFileName <- "db/tweets.db"

tweetsTS <- c("tweets", "conf/db/tweetsTable.txt")
hashesTS <- c("hashes", "conf/db/hashesTable.txt")
tweetsHashesTS <- c("tweetsHashes", "conf/db/tweetsHashesTable.txt")

# creates tweets table

connection <- getConnection(dbFileName)

createTableFromFile(connection, tweetsTS[1], tweetsTS[2])
createTableFromFile(connection, hashesTS[1], hashesTS[2])
createTableFromFile(connection, tweetsHashesTS[1], tweetsHashesTS[2])
