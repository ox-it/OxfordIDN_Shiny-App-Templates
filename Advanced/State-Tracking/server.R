library(shiny)
library(visNetwork)

visN_nodes <- data.frame("id" = 1:8)

shinyServer(function(input, output, session) {
  ## =========================== Control Tracker ==================================
  ## ==============================================================================
  
  control_tracker <-
    reactiveValues(
      selected_node = 0,
      destructive_inputs = 0,
      both = 0,
      check = 1
    )
  
  observeEvent(c(input$shape_do_change, input$focus_do_change), {
    control_tracker$destructive_inputs <-
      control_tracker$destructive_inputs + 1
  })
  
  observeEvent(c(input$shape_do_change, input$current_node_id), {
    control_tracker$both <- control_tracker$both + 1
  })
  
  observeEvent(c(input$current_node_id), {
    control_tracker$check <-
      list(control_tracker$destructive_inputs,
           control_tracker$both)
  })
  
  output$reactive_output <- renderUI({
    wellPanel(if (control_tracker$destructive_inputs == 1) {
      if (is.null(input$current_node_id)) {
        "just loaded, nothing clicked"
      } else {
        "just loaded, something clicked"
      }
      
    } else {
      if (control_tracker$destructive_inputs > control_tracker$check[1]) {
        "variable changed, nothing clicked"
      } else {
        "variable changed, something clicked"
      }
    })
  })
  
  ## =========================== Visualisation ====================================
  ## ==============================================================================
  
  
  visN_edges <- reactive({
    data.frame(
      "from" = c(1, 5, 7, 6, 5, 4, 2, 8, 2, 4),
      "to" = c(3, 6, 1, 6, 7, 8, 3, 2, 7, 5),
      "color" = rep(input$colour_dontchange, 10)
    )
  })
  
  output$the_network <- renderVisNetwork({
    visN_edges <- visN_edges()
    
    visNetwork(node = visN_nodes,
               edges = visN_edges) %>% visNodes(shape = input$shape_do_change) %>%
      visEvents(selectNode = "function(nodes) {
                Shiny.onInputChange('current_node_id', nodes);
                ;}")
})
  
  observe({
    visNetworkProxy("the_network") %>%
      visFocus(id = input$focus_do_change, scale = 4)
  })
  
  
  output$selected_node <- renderText({
    if (control_tracker$destructive_inputs == 1) {
      if (is.null(input$current_node_id)) {
        return()
      } else {
        input$current_node_id$nodes[[1]]
      }
      
    } else {
      if (control_tracker$destructive_inputs > control_tracker$check[1]) {
        "Node selection reset - pleae select a new node"
      } else {
        input$current_node_id$nodes[[1]]
      }
    }
    
  })
  
})