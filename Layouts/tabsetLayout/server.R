## ==== Packages to load for server

library(shiny) # Some advanced functionality depends on the shiny package being loaded server-side, including plot.ly

## ==== Global Variables (server-side)

## ==== Tab selection variables (these are required to support anchor links, see within shinyServer)
url1 <- url2 <- ""

## ==== shinyServer

shinyServer(function(input, output, session) {
  source("server/data-processing.R",local = TRUE)
  source("server/visualisations-and-ui.R",local = TRUE)
  
  ## ===== Allow for linking to individual tabPanels, code provided by daattali here https://github.com/rstudio/shiny/issues/772#issuecomment-112919149
  ## ===== If you find this useful then consider upvoting his answer on SE http://stackoverflow.com/a/33025000/1659890
  
  values <- reactiveValues(myurl = c(), parent_tab = "")
  
  observe({
    # make sure this is called on pageload (to look at the query string)
    # and whenever any tab is successfully changed.
    # If you want to stop running this code after the initial load was
    # successful so that further manual tab changes don't run this,
    # maybe just have some boolean flag for that.
    
    input$someID
    input$tab_sub_tabs
    query <- parseQueryString(session$clientData$url_search)
    url <- query$url
    if (is.null(url)) {
      url <- ""
    }
    
    # "depth" is how many levels the url in the query string is
    depth <- function(x)
      length(unlist(strsplit(x,"/")))
    
    # if we reached the end, done!
    if (length(values$myurl) == depth(url)) {
      return()
    }
    # base case - need to tell it what the first main nav name is
    else if (length(values$myurl) == 0) {
      values$parent_tab <- "someID"
    }
    # if we're waiting for a tab switch but the UI hasn't updated yet
    else if (is.null(input[[values$parent_tab]])) {
      return()
    }
    # same - waiting for a tab switch
    else if (tail(values$myurl, 1) != input[[values$parent_tab]]) {
      return()
    }
    # the UI is on the tab that we last switched to, and there are more
    # tabs to switch inside the current tab
    # make sure the tabs follow the naming scheme
    else {
      values$parent_tab <- paste0(tail(values$myurl, 1), "_tabs")
    }
    
    # figure out the id/value of the next tab
    new_tab <- unlist(strsplit(url, "/"))[length(values$myurl) + 1]
    
    # easy peasy.
    updateTabsetPanel(session, values$parent_tab, new_tab)
    values$myurl <- c(values$myurl, new_tab)
  })
  
})