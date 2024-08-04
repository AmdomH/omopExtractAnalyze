
<!-- README.md is generated from README.Rmd. Please edit that file -->

# omopExtractAnalyze

<!-- badges: start -->
<!-- badges: end -->

The goal of omopExtractAnalyze is to provide tools for extracting and
visualizing patient condition data from the OMOP CDM database, including
an interactive Shiny application for exploring trends.

## Package Structure

The package is structured as follows:

``` plaintext
omopExtractAnalyze/
├── R/
│   ├── extractPatients.R
│   ├── plotTrend.R
│   └── launchShinyApp.R
├── DESCRIPTION
├── NAMESPACE
└── README.Rmd

## Installation

You can install the development version of omopExtractAnalyze from [GitHub](https://github.com/) with:
```

``` r
# install.packages("devtools")
# library(devtools)
devtools::install_github("AmdomH/omopExtractAnalyze")
```

## Prerequisites

Ensure you have the following packages installed:

``` r
install.packages(c("DBI", "SqlRender", "DatabaseConnector", "ggplot2", "shiny"))
```

This is a basic example which shows you how to solve a common problem:

``` r
library(omopExtractAnalyze)
# Establish a database connection
connection <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

# Extract patient data
patient_data <- extractPatients(connection)

# Plot the trend by year
plotTrend(patient_data)

# Launch the Shiny app
launchShinyApp()
```
