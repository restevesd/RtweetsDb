source('helper.R')

source('RtweetsDb.R')

connection <- getConnection(testDbPath)

questions <- data.frame(id=c(1,2), sentence=c('q1', 'q2'))
questionsM1 <- data.frame(id=c(1,2,5), sentence=c('q1', 'q2', 'q5'))
newQuestions <- data.frame(id=c(2,3), sentence=c('q2b', 'q3'))
answersQuestions <- data.frame(answers_id  = c(1,2,3,4),
                               questions_id = c(1,2,3,4))

newAnswersQuestions <- data.frame(answers_id  = c(1,2,3,4),
                                  questions_id = c(1,2,4,5))


describe('dbAddChildrenM2M', {
  describe('quesitonnaire with id', {
    questionnaire <- data.frame(id=1,title=c('QS1'))
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', questions)
    expect_that(dbReadTable(connection, 'questionnaires')[1,]$id, equals(1))
    expect_that(dbReadTable(connection, 'questionnaires')[1,2], equals('QS1'))
    qq.df <- dbReadTable(connection, 'questionnairesQuestions')
    expect_that(dim(qq.df), equals(c(2,2)))
    expect_that(qq.df[2,]$questions_fk, equals(2))
    expect_that(qq.df[1,]$questionnaires_fk, equals(1))
    qs.df <- dbReadTable(connection, 'questions')
    expect_that(dim(qs.df), equals(c(2,2)))
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', newQuestions)

    q.df <- dbReadTable(connection, 'questionnaires')
    expect_that(dim(q.df), equals(c(1,2)))
    qs.df <- dbReadTable(connection, 'questions')
    expect_that(dim(qs.df), equals(c(3,2)))
    qq.df <- dbReadTable(connection, 'questionnairesQuestions')
    expect_that(dim(qq.df), equals(c(3,2)))
  })

  describe('quesitonnaire without id', {
    clearDB(connection)
    questionnaire <- data.frame(title=c('QS1'))
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', questions, father.pk='title')
    q.df <- dbReadTable(connection, 'questionnaires')
    expect_that(dim(q.df), equals(c(1,1)))
    qq.df <- dbReadTable(connection, 'questionnairesQuestions')
    expect_that(dim(qq.df), equals(c(2,2)))
    expect_that(qq.df[2,]$questions_fk, equals(2))
    expect_that(qq.df[1,]$questionnaires_fk, equals("QS1"))
    qs.df <- dbReadTable(connection, 'questions')
    expect_that(dim(qs.df), equals(c(2,2)))
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', newQuestions, father.pk='title')
    q.df <- dbReadTable(connection, 'questionnaires')
    expect_that(dim(q.df), equals(c(1,1)))
    qs.df <- dbReadTable(connection, 'questions')
    expect_that(dim(qs.df), equals(c(3,2)))

    qq.df <- dbReadTable(connection, 'questionnairesQuestions')

    expect_that(dim(qq.df), equals(c(3,2)))
  })
})



