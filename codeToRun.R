library(Eunomia)
library(DatabaseConnector)
library(ggplot2)
library(shiny)
library(omopExtractAnalyze)
# Get connection to Eunomia test database
connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())

# Test the function:  extractPatients()
result <- extractPatients(connection)

# Check the results
print(head(result))
print(tail(result))
print(paste("Number of rows:", nrow(result)))

# Disconnect
DatabaseConnector::disconnect(connection)


#2 Test the function:  plotTrend()
# Test the plotTrend function for yearly data
result%>%
  head(10)%>%
  plotTrend()
# Test the plotTrend function for monthly data
result%>%
  head()%>%
  plotTrend(byMonth = TRUE)

# Test the function:  function()
launchShinyApp()
