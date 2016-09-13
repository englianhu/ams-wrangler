# Acquiring hay data ------------------------------------------------------
library(RSelenium)
library(dplyr)
source('R/help_all.R')
source('R/help_hay.R')
source('R/make_yearly_date_vectors.R')

remDr <- initialize_browser()
init_hay()

for (i in seq_along(start_date)) {
  output_file <- name_data('hay')
  if (!file.exists(output_file)) {
    init_hay()
    wait(2)
    wait_select('repDate', start_date[i])
    wait_select('endDate',  end_date[i])
    query_rButtonRow()
    html <- get_html()
    if (has_results(html)) {
      download_data('hay')
    }
  }
  check_for_missed_data()
}
