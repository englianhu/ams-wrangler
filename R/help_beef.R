## Helper function to set up beef data extractions ---------------------------
init_beef <- function() {
  remDr$navigate('https://marketnews.usda.gov/mnp/ls-report-config')
  wait(1)
  wait_select('category', 'Retail')
}

nav_beef <- function(report_type = NULL) {
  init_beef()
  wait(2)
  if (!is.null(report_type)) {
    wait_select('repTypeRow select', report_type)
  }
}

query_beef <- function() {
  run <- remDr$findElement(using = 'css selector', value = '.centerAlignOverride input')
  run$clickElement()
  wait(10)
}
