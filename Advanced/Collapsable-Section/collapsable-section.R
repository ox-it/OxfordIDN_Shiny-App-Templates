library(shiny)

## from http://stackoverflow.com/a/35175847/1659890

ui <- shinyUI(bootstrapPage(
  wellPanel("Title of App"),
  absolutePanel(
    id = "controls",
    class = "panel panel-default",
    fixed = FALSE,
    # draggable = TRUE,
    top = 60,
    left = "auto",
    right = "auto",
    bottom = "auto",
    width = 330,
    height = "auto",
    HTML(
      '<button data-toggle="collapse" data-target="#demo">Collapsible</button>'
    ),
    tags$div(
      id = 'demo',
      class = "collapse",
      checkboxInput('input_draw_point', 'Draw point', FALSE),
      verbatimTextOutput('summary')
    )
  ),
  sidebarLayout(sidebarPanel(
    selectInput(
      "select_input",
      label = "Shape",
      choices = c("circle", "square")
    )
    
  ),
  mainPanel("foobar"))
))

server <- shinyServer(function(input, output, session) {
  output$summary <- renderPrint(print(cars))
  
})

shinyApp(ui = ui, server = server)