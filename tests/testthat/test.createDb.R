source('helper.R')


source('createDb.R')
test_that('creating db', {
  expect_that(file.exists(testDbPath), is_false())
  con <- getConnection(testDbPath)
  expect_that(file.exists(testDbPath), is_true())
})





