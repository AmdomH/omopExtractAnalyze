test_that("extractPatients returns a data frame with expected columns", {
  skip_on_cran()

  connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
  on.exit(DatabaseConnector::disconnect(connection))

  result <- extractPatients(connection)

  print(result)  # Print the result for debugging

  expected_columns <- c("condition", "year", "month", "count")
  expect_s3_class(result, "data.frame")
  expect_true(all(expected_columns %in% colnames(result)))
})

test_that("extractPatients returns non-empty results", {
  skip_on_cran()

  connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
  on.exit(DatabaseConnector::disconnect(connection))

  result <- extractPatients(connection)

  expect_true(nrow(result) > 0)
})

