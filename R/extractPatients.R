#' Extract Patient Condition Counts
#'
#' This function extracts counts of all conditions by year and month from the
#' condition occurrence table in an OMOP CDM database.
#'
#' @param connection A database connection object
#'
#' @return A data frame with columns: condition_concept_id, condition_name, year, month, count
#' @export
#' @importFrom SqlRender render translate
#' @importFrom dplyr collect
#' @importFrom SqlRender render translate
#' @importFrom dplyr collect
#' @examples
#' \dontrun{
#' connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
#' patient_data <- extractPatients(connection)
#' head(patient_data)
#' DatabaseConnector::disconnect(connection)
#' }
extractPatients <- function(connection) {
  sql <- "
    SELECT
      c.concept_name AS condition,
      YEAR(co.condition_start_date) AS year,
      MONTH(co.condition_start_date) AS month,
      COUNT(*) AS count
    FROM
      @cdm_database_schema.condition_occurrence co
    JOIN
      @cdm_database_schema.concept c ON co.condition_concept_id = c.concept_id
    GROUP BY
      c.concept_name,
      YEAR(co.condition_start_date),
      MONTH(co.condition_start_date)
    ORDER BY
      count DESC
  "

  # Render the SQL for the specific dialect
  rendered_sql <- SqlRender::render(sql, cdm_database_schema = "main")
  translated_sql <- SqlRender::translate(rendered_sql, targetDialect = connection@dbms)

  # Execute the query and return the results as a data frame
  result <- dplyr::collect(dplyr::tbl(connection, dplyr::sql(translated_sql)))

  return(result)
}
