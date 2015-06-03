source('helper.R')
source('createDb.R')

describe('creating db', {
  it("is expected to create DB", {
    expect_that(file.exists(testDbPath), is_false())
    getConnection(testDbPath)
    expect_that(file.exists(testDbPath), is_true())
  })
})

connection <- getConnection(testDbPath)

describe('createTable()', {
  it('should create table', {
    createTable(connection, "question", "id int, sentence text")
    expect_that(dbExistsTable(connection, "question"), is_true())
    expect_that('id' %in% dbListFields(connection, 'question'), is_true())
  })
})

