source('helper.R')
source('createDb.R')
source('acctionsDb.R')

connection <- getConnection(testDbPath)
questions <- data.frame(id=c(1,2), sentence=c('q1', 'q2'))
newQuestions <- data.frame(id=c(2,3), sentence=c('q2b', 'q3'))

describe('getColumn()', {
  it('is expect to return a vector with a column', {
    dbWriteTable(connection, 'questions', questions)
    col <- getColumn(connection, 'questions', 'sentence')
    expect_that(col, equals(c('q1', 'q2')))
    dbRemoveTable(connection, 'questions')
  })
})

describe('getIds()', {
  it('is expect to return a vector with a column of ids', {
    dbWriteTable(connection, 'questions', questions)
    col <- getIds(connection, 'questions')
    expect_that(col, equals(c(1, 2)))
    dbRemoveTable(connection, 'questions')
  })
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

