library(shiny)
library(highcharter)
library(htmltools)
library(dplyr)
library(tidyr)

country_schooling <- read.csv(file = "data/ethopia_education_schooling.csv", stringsAsFactors = F)
country_schooling$Sample.Size <- as.numeric(gsub(",","",country_schooling$Sample.Size))


measure_list <- c("percentage.in.school", 
                  "highest.grade.completed.2006", "Percentage.children.over.age.for.grade", 
                  "percentage.attending.private.schools..", "Sample.Size")

measure_list <- setNames(measure_list, trimws(gsub("\\.", " ", measure_list)))

property_measure_groups <- c("Older Round 2", "Young Round 4")

## ============================ Stacked bar chart function ==============================
## ======================================================================================

stacked_bar_chart <- function(data = NA,
                              categories_column = NA,
                              measure_columns = NA,
                              stacking_type = NA,
                              ordering_function = c) {
  
  ordered_measure <-
    order(unlist(lapply(measure_columns, function(x) {
      ordering_function(data[, x])
    })),
    decreasing = TRUE) - 1
  
  chart <- highchart() %>%
    hc_xAxis(categories = data[, categories_column],
             title = categories_column)
  
  invisible(lapply(1:length(measure_columns), function(colNumber) {
    chart <<-
      hc_add_series(
        hc = chart,
        name = measure_columns[colNumber],
        data = data[, measure_columns[colNumber]],
        index = ordered_measure[colNumber]
      )
  }))
  
  chart %>%
    hc_chart(type = "bar") %>%
    hc_plotOptions(series = list(stacking = as.character(stacking_type))) %>%
    hc_legend(reversed = TRUE)
}

## ============================ shinyServer ==============================
## ======================================================================================

shinyServer(function(input, output){
  
  output$selected_category_UI <- renderUI({
    
    selectInput("selected_category", label = "Selected measure",
                choices = unique(country_schooling$Property.Type))
    
  })
  
  output$selected_measure_UI <- renderUI({
    
    selectInput("selected_measure", label = "Selected measure",
                choices = measure_list)
    
  })
  
  output$selected_stacking_UI <- renderUI({
    
    selectInput("selected_stacking", label = "Selected stacking",
                choices = list("No stacking" = NA, "Total Observations" = "normal", "Percentage" = "percent"))
    
  })
  
  output$comparison_chart <- renderHighchart({
    
    if(is.null(input$selected_measure)){
      return()
    }
    
    print(filter(country_schooling, Property.Type == input$selected_category) %>%
            select_("Property", "Cohort", input$selected_measure))
    
    data_to_viz <- filter(country_schooling, Property.Type == input$selected_category) %>%
      select_("Property", "Cohort", input$selected_measure) %>%
      spread_("Cohort", input$selected_measure)
    
    
    
    stacked_bar_chart(
      data = data_to_viz,
      categories_column = "Property",
      measure_columns = property_measure_groups,
      ## selectInput always returns a character, to negate stacking need to give NA to argument
      stacking_type = if(input$selected_stacking != "NA"){input$selected_stacking} else NA
    )
    
    
    
  })
  
})