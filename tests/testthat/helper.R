setwd('../..')

testDbPath <- 'db/test.db'
#delete sqlite test db if exises
if (file.exists(testDbPath)) file.remove(testDbPath)

clearDB <-  function(connection) {
  dbRemoveTableIfExists(connection, 'questions')
  dbRemoveTableIfExists(connection, 'questionnaires')
  dbRemoveTableIfExists(connection, 'questionnairesQuestions')    
}
