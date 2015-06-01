setwd('../..')

testDbPath <- 'db/test.db'
#delete sqlite test db if exises
if (file.exists(testDbPath)) file.remove(testDbPath)

