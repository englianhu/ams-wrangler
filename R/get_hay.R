# Acquiring hay data ------------------------------------------------------
library(RSelenium)
library(dplyr)
source('R/help_all.R')
source('R/help_hay.R')
source('R/make_yearly_date_vectors.R')

remDr <- initialize_browser()
init_hay()

for (i in seq_along(start_vec)) {
  init_hay()
  wait(2)
  wait_select('repDate', format(start_vec[i], format = date_format))
  wait_select('endDate',  format(end_vec[i], format = date_format))
  query_rButtonRow()
  html <- get_html()
  if (has_results(html)) {
    download_data('hay')
  }
  check_for_missed_data()
}
