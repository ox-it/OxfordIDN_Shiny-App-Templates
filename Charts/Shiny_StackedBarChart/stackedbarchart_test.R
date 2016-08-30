library(highcharter)
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

ethopia_schooling_youngOld <- read.csv(file = "data/ethopia_education_schooling.csv", stringsAsFactors = F)
ethopia_schooling_region <- ethopia_schooling_youngOld[ethopia_schooling_youngOld$Property.Type == "schooling region",]

measure_list <- c("percentage.in.school", 
                  "highest.grade.completed.2006", "Percentage.children.over.age.for.grade", 
                  "percentage.attending.private.schools..", "Sample.Size")

measure_list <- setNames(measure_list, trimws(gsub("\\.", " ", measure_list)))


library(dplyr)
library(tidyr)

data_to_viz <- filter(ethopia_schooling_youngOld, Property.Type == "caregiver education") %>%
  select_("Property", "Cohort", "percentage.in.school") %>%
  spread_("Cohort", "percentage.in.school")

stacked_bar_chart(
  data = data_to_viz,
  categories_column = "Property",
  measure_columns = c("Older Round 2", "Young Round 4")
)


