# In R/plotTrend.R
#' Plot Patient Condition Trends
#'
#' This function takes the output from the `extractPatients` function as input and returns a plot
#' with the number of patients per year (default) or per month for each condition in the data.
#'
#' @param data A data frame with columns: condition, year, month, count
#' @param byMonth Logical, if TRUE, plot by month; otherwise, plot by year (default)
#'
#' @return A ggplot2 object
#' @export
#' @importFrom ggplot2 ggplot aes geom_line facet_wrap labs theme element_text
#' @importFrom dplyr mutate
#' @examples
#' \dontrun{
#' connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
#' patient_data <- extractPatients(connection)
#' plotTrend(patient_data)
#' DatabaseConnector::disconnect(connection)
#' }
plotTrend <- function(data, byMonth = FALSE) {
  library(ggplot2)
  library(dplyr)

  data <- data %>%
    mutate(period = ifelse(byMonth, paste(year, month, sep = "-"), as.character(year)))

  # Convert condition to factor
  data$condition <- as.factor(data$condition)

  p <- ggplot(data, aes(x = period, y = count, group = condition, color = condition)) +
    geom_line() +
    facet_wrap(~ condition, scales = "free_y") +
    labs(x = ifelse(byMonth, "Month", "Year"), y = "Number of Patients", title = "Condition Trends Over Time") +
    theme(axis.text.x = element_text(angle = 90, hjust = 1))

  return(p)
}
