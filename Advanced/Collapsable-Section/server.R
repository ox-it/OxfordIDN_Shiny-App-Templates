library(shiny)
library(visNetwork)

colour_list <- c("#1b9e77","#d95f02","#7570b3")
category_list <- c("Type A","Type B", "Type C")

visN_nodes <- data.frame("id" = 1:8,
                         "color" = rep(colour_list,4)[1:8])

source("legend.R", local = T)


shinyServer(function(input, output, session) {
  
  output$some_svg <- renderUI({
    some_svg
  })
  
  
  output$colour_legend_ui <- renderUI({
    HTML(colour_legend)
  })

  visN_edges <- reactive({
    data.frame(
      "from" = c(1, 5, 7, 6, 5, 4, 2, 8, 2, 4),
      "to" = c(3, 6, 1, 6, 7, 8, 3, 2, 7, 5)
    )
  })
  
  output$the_network <- renderVisNetwork({
    visN_edges <- visN_edges()
    
    visNetwork(node = visN_nodes,
               edges = visN_edges) %>% visNodes(shape = input$shape) %>%
      visEvents(selectNode = "function(nodes) {
                Shiny.onInputChange('current_node_id', nodes);
                ;}")
})
  
  output$selected_node <- renderText({
    
    if(is.null(input$current_node_id)){
      return()
    }
    
    input$current_node_id$nodes[[1]]
    
    
  })
  
})