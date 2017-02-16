## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

shinyServer(function(input, output, session) {
  
  ## this calls the contents of url_allowPopout.R as if it was copied and 
  ## pasted directly into the shinyServer function. This allows the 
  ## output$url_allow_popout_UI to be displayed in the client
  source("url_allowPopout.R", local = TRUE)
  
  output$chart <- renderPlot(
    hist(rnorm(100))
  )
  
})
