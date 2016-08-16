## Get retail beef data from USDA
library(RSelenium)
library(dplyr)
source('R/help_all.R')
source('R/help_beef.R')
source('R/make_yearly_date_vectors.R')

remDr <- initialize_browser()
init_beef()
report_types <- get_options('repTypeRow select')

for (i in seq_along(report_types)) {
  for (j in seq_along(start_vec)) {
    nav_beef(report_types[i])
    wait(2)
    wait_select('repDate', format(start_vec[j], format = date_format), clear = TRUE)
    wait_select('endDate',  format(end_vec[j], format = date_format), clear = TRUE)
    query_beef()
    html <- get_html()
    if (has_results(html)) {
      download_data('beef')
    }
    check_for_missed_data()
  }
}
