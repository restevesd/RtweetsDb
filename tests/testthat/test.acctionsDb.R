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

clearDB <-  function() {
  dbRemoveTableIfExists(connection, 'questions')
  dbRemoveTableIfExists(connection, 'questionnaires')
  dbRemoveTableIfExists(connection, 'questionnairesQuestions')    
}

describe('getColumn()', {
  dbWriteTable(connection, 'questions', questions)
  describe('when one column given', {
    it('is expect to return a dataframe with the column', {
      col <- getColumn(connection, 'questions', 'sentence')
      expect_that(dim(col), equals(c(2,1)))
      expect_that(col$sentence, equals(c('q1', 'q2')))
    })
  })
  describe('when two columns given', {
    it('is expect to return a dataframe with the column', {
      col <- getColumn(connection, 'questions', c('sentence','id'))
      expect_that(dim(col), equals(c(2,2)))
      expect_that(col$sentence, equals(c('q1', 'q2')))
      expect_that(col$id, equals(c(1, 2)))
    })
  })
  dbRemoveTable(connection, 'questions')
})

describe('selectNewRows', {
  describe('one new', {
    q1 <- data.frame(id=c(2,1))
    q2 <- data.frame(id=c(3,2,1))
    expect_that(selectNewRows(q2,q1)[1,1], equals(3))
  })
  describe('one new, different order', {
    q1 <- data.frame(id=c(2,1))
    q2 <- data.frame(id=c(2,3,1))
    expect_that(selectNewRows(q2,q1)[1,1], equals(3))
  })
  describe('one new, different order', {
    q1 <- data.frame(id=c(2,1))
    q2 <- data.frame(id=c(3))
    expect_that(selectNewRows(q2,q1)[1,1], equals(3))
  })
  describe('no new', {
    q1 <- data.frame(id=c(2,1))
    q2 <- data.frame(id=c(2))
    expect_that(selectNewRows(q2,q1),is_null())
  })
  describe('no old', {
    q1 <- data.frame()
    q2 <- data.frame(id=c(1))
    expect_that(selectNewRows(q2,q1)[1,1], equals(1))
  })
  describe('does not desorder columns', {
    q1 <- data.frame(id=c(2,1))
    q2 <- data.frame(x=c(1,1,1),id=c(2,3,1))
    cn <- colnames(selectNewRows(q2,q1))
    expect_that(cn, equals(c('x', 'id')))
  })
});

describe("dbWriteNewRows()", {

  it('only appends rows that have new id', {
    questions <- data.frame(id=c(1,2), sentence=c('q1', 'q2'))
    newQuestions <- data.frame(id=c(2,3), sentence=c('q2b', 'q3'))
    dbWriteNewRows(connection, 'questions', questions)
    expect_that(dim(dbReadTable(connection, 'questions')),
                equals(c(2,2)))
    dbWriteNewRows(connection, 'questions', newQuestions)
    rdf <- dbReadTable(connection, 'questions')
    expect_that(rdf[3,2], equals('q3'))
    expect_that(dim(rdf), equals(c(3,2)))
  });

  it('should appends rows that have new pk (multiple)', {
    dbWriteNewRows(connection, 'answersQuestions',
                   answersQuestions, pk=c('answers_id', 'questions_id'))
    rdf <- dbReadTable(connection, 'answersQuestions')
    expect_that(dim(rdf), equals(c(4,2)))
    dbWriteNewRows(connection, 'answersQuestions',
                   newAnswersQuestions, pk=c('answers_id', 'questions_id'))
    expect_that(dim(dbReadTable(connection, 'answersQuestions')),
                equals(c(6,2)))
  })

  it('should eliminate duplicates', {
    duplicates.questions <- data.frame(id=c(5,5), sentence=c('q2', 'q3'))
    ###dbWriteNewRows(connection, 'questions', duplicates.questions)
    #r.questions <- dbReadTable(connection, 'questions')
    #expect_that(dim(r.questions), equals(c(2,2)))
  })
  
  describe('when a rownames are given', {
    question.df <- data.frame(id=23456, sentence='ala ma kota')
    rownames(question.df) <- c('row1')
    it('should add a row',{
      #dbWriteNewRows(connection, 'questions', question.df)
    })
  })


  
})

describe('dbReadChildrenM2M', {
  beforeEach <- clearDB
  
  describe('write twice', {
    beforeEach()
    questionnaire <- data.frame(title=c('QS1'))
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', questions, father.pk='title')
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', rbind(questions, newQuestions), father.pk='title')
    res.df <- dbReadChildrenM2M(connection, 'questionnaires', 'QS1',
                                'questions', father.pk='title')
    expect_that(dim(res.df), equals(c(3,2)))
  })

  describe('write once two hashes', {
    beforeEach()
    questionnaire <- data.frame(title=c('QS1'))
    questionnaire2 <- data.frame(title=c('QS2'))
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire,
                     'questions', questions, father.pk='title')
    dbAddChildrenM2M(connection,
                     'questionnaires', questionnaire2,
                     'questions', newQuestions, father.pk='title')
    it('is expected to return 2 results', {
      res.df <- dbReadChildrenM2M(connection, 'questionnaires', 'QS1',
                                'questions', father.pk='title')
      expect_that(dim(res.df), equals(c(2,2)))
    })
    it('is also expected to return 2 results', {
      res.df <- dbReadChildrenM2M(connection, 'questionnaires', 'QS2',
                                  'questions', father.pk='title')
      expect_that(dim(res.df), equals(c(2,2)))
    })
    it('sometimes can return less when set n.fetch', {
      res.df <- dbReadChildrenM2M(connection, 'questionnaires', 'QS2',
                                  'questions', father.pk='title',
                                  n.fetch=1)
      expect_that(dim(res.df), equals(c(1,2)))
    })
  })

})
