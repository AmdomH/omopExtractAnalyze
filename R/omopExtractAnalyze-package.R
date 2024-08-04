# omopExtractAnalyze-package.R

#' omopExtractAnalyze: A package for Extracting and Analyzing OMOP CDM Data
#'
#' The omopExtractAnalyze package provides tools for extracting and visualizing patient condition data from the OMOP CDM database. It includes functions for data extraction, trend plotting, and launching an interactive Shiny application.
#'
#' @docType package
#' @name omopExtractAnalyze
#' @import SqlRender
#' @import dplyr
#' @import DatabaseConnector
#' @import Eunomia
#' @import ggplot2
#' @import shiny
#'
#' @section Functions:
#' \describe{
#'   \item{\code{\link{extractPatients}}}{Extracts counts of all conditions by year and month from the OMOP CDM database.}
#'   \item{\code{\link{plotTrend}}}{Generates a plot of the number of patients per year or per month for each condition.}
#'   \item{\code{\link{launchShinyApp}}}{Launches a Shiny app to visualize patient condition data.}
#' }
#'
#' @examples
#' \dontrun{
#' library(omopExtractAnalyze)
#'
#' # Establish a database connection
#' connection <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
#'
#' # Extract patient data
#' patient_data <- extractPatients(connection)
#'
#' # Plot the trend by year
#' plotTrend(patient_data)
#'
#' # Launch the Shiny app
#' launchShinyApp()
#' }
"_PACKAGE"
