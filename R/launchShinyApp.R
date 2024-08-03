#' Launch Shiny App
#'
#' This function launches a Shiny app for visualizing patient condition trends.
#'
#' @export
launchShinyApp <- function() {
  library(shiny)
  library(ggplot2)
  library(dplyr)
  library(omopExtractAnalyze)

  ui <- fluidPage(
    titlePanel("Patient Condition Trends"),
    sidebarLayout(
      sidebarPanel(
        selectInput("condition", "Select Condition:", choices = NULL),
        checkboxInput("byMonth", "Plot by Month", value = FALSE)
      ),
      mainPanel(
        plotOutput("trendPlot")
      )
    )
  )

  server <- function(input, output, session) {
    # Load data once and use it throughout the app
    connection <- DatabaseConnector::connect(Eunomia::getEunomiaConnectionDetails())
    data <- extractPatients(connection)
    DatabaseConnector::disconnect(connection)

    # Update condition choices
    observe({
      updateSelectInput(session, "condition", choices = unique(data$condition))
    })

    filteredData <- reactive({
      data %>% filter(condition == input$condition)
    })

    output$trendPlot <- renderPlot({
      plotTrend(filteredData(), byMonth = input$byMonth)
    })
  }

  shinyApp(ui, server)
}
