
## =============================== License ========================================
## ================================================================================
## This work is distributed under the MIT license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: David Ruvolo
## ================================================================================


#' load packages
library(shiny)
library(rhandsontable)
library(DT)
library(shinyjs)
library(shinyBS)

#' cd = pwd
setwd(getwd())

#' logic for loading data file
testFile <- "cars_data.rds"     # target file

if(file.exists(testFile)){
  mtcarsDF <- readRDS("cars_data.rds")     # load data
} else {                                     # create new data
  mtcarsDF <- mtcars
  row.names(mtcarsDF) <- NULL
  mtcarsDF$car <- row.names(mtcars)
  mtcarsDF <- mtcarsDF[,c(12, 1:11)]
}

## MAKE UI
ui <- shinyUI(fluidPage(
  useShinyjs(),
  titlePanel("Data Editor Exmple Using 'mtcars'"),
  sidebarLayout(
    sidebarPanel(
      helpText("A Shiny app using the 'rhandsontable' package."),
      actionButton("view",label = "view", icon=icon("binoculars")),
      actionButton("edit",label = "edit", icon=icon("pencil")),
      actionButton("save", label = "save", icon=icon("save")),
      bsModal(id = "saveChanges", "Do you want to save changes?", "save", size = "small",
              wellPanel(
                helpText("Saving will overwrite existing data! This cannot be undone."),
                actionButton("no", "No"),
                actionButton("yes", "Yes")
              ))
    ),
    mainPanel(
      textOutput("textToPrint"),
      dataTableOutput("table"),
      rHandsontableOutput("hot")
    )
  )
))

## MAKE SERVER
server <- function(input, output, session){
  
  values = reactiveValues()
  shinyjs::hide("save")
  
  ## when view is clicked
  observeEvent(input$view,{
    shinyjs::hide("hot")
    shinyjs::hide("save")
    shinyjs::show("table")
    
    output$table <- DT::renderDataTable({
      DT::datatable(mtcarsDF, selection="none")
    })
  })
  
  ## when edit is clicked
  observeEvent(input$edit, {
    shinyjs::show("hot")
    shinyjs::show("save")
    shinyjs::hide("table")
    
    data = reactive({
      if(!is.null(input$hot)){
        DF = hot_to_r(input$hot)
      } else {
        if(is.null(values[["DF"]])){
          DF = data.frame(mtcarsDF)
        } else {
          DF = values[["DF"]]
        }
      }
      
      values[["DF"]] = DF
      DF
      
    })
    
    ## generate HOT
    output$hot <- renderRHandsontable({
      DF = data()
      if (!is.null(DF))
        rhandsontable(DF, stretchH = "all")
    })
  })
  
  # When yes is clicked, save data as RDS
  observeEvent(input$yes,{
    shinyjs::alert("Your data was saved successfully")
    finalDF <- isolate(values[["DF"]])
    mtcarsDF <<- finalDF
    saveRDS(mtcarsDF, file = "cars_data.RDS")
  })
  
}

## RUN APP
shinyApp(ui = ui, server = server)