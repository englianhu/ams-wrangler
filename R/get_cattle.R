# Get cattle data ------------------------------------------------------------
library(RSelenium)
library(dplyr)
source('R/help_all.R')
source('R/help_cattle.R')

start_date <- as.Date('01/01/2000', format = date_format)
remDr <- initialize_browser()
init_cattle()
subcommodities <- get_options('subComm')

for (i in seq_along(subcommodities)) {
  nav_cattle(subComm = subcommodities[i])
  fsizes <- get_options('fsize')
  for (j in seq_along(fsizes)) {
    nav_cattle(subComm = subcommodities[i],
               fsize = fsizes[j])
    muscle_scores <- get_options('mscore')
    for (k in seq_along(muscle_scores)) {
      nav_cattle(subComm = subcommodities[i],
                 fsize = fsizes[j],
                 mscore = muscle_scores[k])
      wranges <- get_options('wrange')
      for (l in seq_along(wranges)) {
        output_file <- name_data('cattle')
        if (!file.exists(output_file)) {
          nav_cattle(subComm = subcommodities[i],
                     fsize = fsizes[j],
                     mscore = muscle_scores[k],
                     wrange = wranges[l])
          wait_select('repDate', start_date)
          wait_select('endDate', end_date())
          query_rButtonRow()
          html <- get_html()
          if (has_results(html)) {
            download_data('cattle')
          }
        }
      check_for_missed_data()
      }
    }
  }
}
