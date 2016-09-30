library(shiny)
app <- shinyApp(
  ui = shinyUI(
    fluidPage(
      
      navbarPage("Site Title",
                 tabPanel("v0.1"),
                 tabPanel("tab1"),
                 tabPanel("tab2")
      ),
      HTML("<script>var parent = document.getElementsByClassName('navbar-nav');
           parent[0].insertAdjacentHTML( 'afterend', '<ul class=\"nav navbar-nav navbar-right\"><li><a href=\"#\"><span class=\"glyphicon glyphicon-fullscreen\" aria-hidden=\"true\" style=\"color:black;padding:2px;border:1px solid;border-radius:3px;\"> POPOUT</span></a></li></ul>' );</script>")
      )
    ),
  
  server = function(input, output, session){}
  
  )

runApp(app)