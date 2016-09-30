## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## Academic Contact: Arno Bosse (http://orcid.org/0000-0003-3681-1289)
## Data Source: emlo.bodleian.ox.ac.uk
## ================================================================================
## =============================== Description ====================================
## ================================================================================
## Using http://stackoverflow.com/a/32171132/1659890 this creates a date picker that
## only allows years to be selected

library(shiny)
library(htmltools)
shinyApp(
  ui = fluidPage(uiOutput("year_only_date_picker")),
  server = function(input, output) {
    ## From http://stackoverflow.com/a/32171132/1659890
    mydateInput <-
      function(inputId,
               label,
               value = NULL,
               min = NULL,
               max = NULL,
               format = "yyyy-mm-dd",
               startview = "month",
               weekstart = 0,
               language = "en",
               minviewmode = "months",
               width = NULL) {
        # If value is a date object, convert it to a string with yyyy-mm-dd format
        # Same for min and max
        if (inherits(value, "Date"))
          value <- format(value, "%Y-%m-%d")
        if (inherits(min,   "Date"))
          min   <- format(min,   "%Y-%m-%d")
        if (inherits(max,   "Date"))
          max   <- format(max,   "%Y-%m-%d")
        
        htmltools::attachDependencies(
          tags$div(
            id = inputId,
            class = "shiny-date-input form-group shiny-input-container",
            style = if (!is.null(width))
              paste0("width: ", validateCssUnit(width), ";"),
            
            controlLabel(inputId, label),
            tags$input(
              type = "text",
              # datepicker class necessary for dropdown to display correctly
              class = "form-control datepicker",
              `data-date-language` = language,
              `data-date-weekstart` = weekstart,
              `data-date-format` = format,
              `data-date-start-view` = startview,
              `data-date-min-view-mode` = minviewmode,
              `data-min-date` = min,
              `data-max-date` = max,
              `data-initial-date` = value
            )
          ),
          datePickerDependency
        )
      }
    
    `%AND%` <- function(x, y) {
      if (!is.null(x) && !is.na(x))
        if (!is.null(y) && !is.na(y))
          return(y)
      return(NULL)
    }
    
    controlLabel <- function(controlName, label) {
      label %AND% tags$label(class = "control-label", `for` = controlName, label)
    }
    
    datePickerDependency <- htmlDependency(
      "bootstrap-datepicker",
      "1.0.2",
      c(href = "shared/datepicker"),
      script = "js/bootstrap-datepicker.min.js",
      stylesheet = "css/datepicker.css"
    )
    
    
    output$year_only_date_picker <- renderUI({
      mydateInput(
        inputId = "date",
        label = "Date",
        value = paste0(1900, "-01-01"),
        min = paste0(1800, "-01-01"),
        max = paste0(2010, "-01-01"),
        format = "yyyy",
        minviewmode = "years",
        startview = "decade"
      )
    })
    
  }
)