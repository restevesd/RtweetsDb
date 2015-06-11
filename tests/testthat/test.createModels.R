source('helper.R')
source('lib/RtweetsDb/createDb.R')
source('lib/RtweetsDb/createModels.R')

models <- list(c("questions", "tests/testthat/models/questions.txt"),
               c("answers", "tests/testthat/models/answers.txt"),
               c("questionsAnswers", "tests/testthat/models/questionsAnswers.txt"))

connection <- getConnection('db/test.tweets.db')
createModels(connection, models)



