# In R/plotTrend.R
#' Plot Patient Condition Trends
#'
#' This function takes the output from the `extractPatients` function as input and returns a plot
#' with the number of patients per year (default) or per month for each condition in the data.
#'
#' @param data A data frame with columns: condition, year, month, count
#' @param byMonth Logical, if TRUE, plot by month; otherwise, plot by year (default)
#' @param condition Character, a specific condition to filter by. If NULL, plots all conditions (default: NULL)
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
plotTrend <- function(data, byMonth = FALSE, condition=NULL) {
  library(ggplot2)
  library(dplyr)

  if (!is.null(condition)) {
    data <- data %>% filter(condition == !!condition)
  }

  if (byMonth) {
    # Create df_month for monthly trends
    df_month <- data %>%
      group_by(condition, year, month) %>%
      summarise(total_count = sum(count, na.rm = TRUE)) %>%
      ungroup()

    # Plot monthly trends
    p <- ggplot(df_month, aes(x = factor(month), y = total_count, group = interaction(year, condition), color = as.factor(year))) +
      geom_line() +
      facet_wrap(~ condition, scales = "free_y") +
      labs(x = "Month", y = "Number of Patients", title = ifelse(is.null(condition), "Condition Trends Over Time", paste("Condition Trend for:", condition))) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  } else {
    # Create df_year for yearly trends
    df_year <- data %>%
      group_by(condition, year) %>%
      summarise(total_count = sum(count, na.rm = TRUE)) %>%
      ungroup()

    # Plot yearly trends
    p <- ggplot(df_year, aes(x = factor(year), y = total_count, group = condition, color = condition)) +
      geom_line() +
      facet_wrap(~ condition, scales = "free_y") +
      labs(x = "Year", y = "Number of Patients", title = ifelse(is.null(condition), "Condition Trends Over Time", paste("Condition Trend for:", condition))) +
      theme(axis.text.x = element_text(angle = 90, hjust = 1))
  }

  return(p)
}
