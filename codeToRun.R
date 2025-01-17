library(Eunomia)
library(DatabaseConnector)
library(ggplot2)
library(dplyr)
library(shiny)
if(!require("omopExtractAnalyze")) devtools::install_github("AmdomH/omopExtractAnalyze")
library(omopExtractAnalyze)
# Get connection to Eunomia test database
connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())

# Test the function:  extractPatients()
result <- extractPatients(connection)

# Check the results
print(paste("Number of rows:", nrow(result)))
print(head(result))
print(tail(result))


# Disconnect
DatabaseConnector::disconnect(connection)

#2 Test the function:  plotTrend()
# Test the plotTrend function for yearly data, condition = "Viral sinusitis"
result%>%
  plotTrend(condition = "Viral sinusitis")

# Test the plotTrend function for yearly data, all conditions
result%>%
  plotTrend()

# Test the plotTrend function for monthly data, condition = "Viral sinusitis"
result%>%
  plotTrend(byMonth = TRUE, condition = "Viral sinusitis")

# Test the plotTrend function for months data, all conditions
result%>%
  plotTrend(byMonth = TRUE)

# Test the plotTrend function for yearly data, condition = "Hep B", non existent
result%>%
  plotTrend(condition = "Hep B")


#3 Test the function:  launchShinyApp()
launchShinyApp()
