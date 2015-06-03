source('helper.R')
source('createDb.R')
source('acctionsDb.R')

connection <- getConnection(testDbPath)
questions <- data.frame(id=c(1,2), sentence=c('q1', 'q2'))
newQuestions <- data.frame(id=c(2,3), sentence=c('q2b', 'q3'))

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



describe("dbWriteNewRows", {
  it('appends rows that have new id', {
    dbWriteNewRows(connection, 'questions', questions)
    expect_that(dim(dbReadTable(connection, 'questions')),
                equals(c(2,2)))
    dbWriteNewRows(connection, 'questions', newQuestions)
    expect_that(dim(dbReadTable(connection, 'questions')),
                equals(c(3,2)))
  });
});

