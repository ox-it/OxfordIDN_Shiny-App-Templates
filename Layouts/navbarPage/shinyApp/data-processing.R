## =============================== License ========================================
## ================================================================================
## This work is distributed under the CC0 1.0 Universal (CC0 1.0) license, included in the parent directory
## Copyright Owner: University of Oxford
## Date of Authorship: 2016
## Author: Martin John Hadley (orcid.org/0000-0002-3039-6849)
## ================================================================================

## ==== Packages to load for data processing
library(tidyverse) # tidyverse imports data processing/importing tools, see https://github.com/hadley/tidyverse

## Load data from figshare
locations <- read_csv("https://ndownloader.figshare.com/files/5449670")

## Assign (meaningless) categories
locations$type <- rep(c("A","B","C"), each = 5, len = 15)




