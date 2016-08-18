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
    output_file <- file.path('data', paste0(name_data('beef'), '.txt'))
    if (!file.exists(output_file)) {
      nav_beef(report_types[i])
      wait(2)
      wait_select('repDate', start_date[j], clear = TRUE)
      wait_select('endDate',  end_date[j], clear = TRUE)
      query_beef()
      html <- get_html()
      if (has_results(html)) {
        download_data('beef')
      }
    }
    check_for_missed_data()
  }
}
