library(testthat)
library(omopExtractAnalyze)
library(ggplot2)

#Test plotTrend default (Yearly)
test_that("plotTrend returns a ggplot object", {
  #skip_on_cran()

  connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
  on.exit(DatabaseConnector::disconnect(connection))

  patient_data <- extractPatients(connection)
  plot <- plotTrend(patient_data)

  expect_s3_class(plot, "ggplot")
})

#Test plotTrend Monthly
test_that("plotTrend works with monthly data", {
  #skip_on_cran()

  connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
  on.exit(DatabaseConnector::disconnect(connection))

  patient_data <- extractPatients(connection)
  plot <- plotTrend(patient_data, byMonth = TRUE)

  expect_s3_class(plot, "ggplot")
})
