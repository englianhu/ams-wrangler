# Hay helper functions ----------------------------------------------------
init_hay <- function() {
  remDr$navigate('https://marketnews.usda.gov/mnp/ls-report-config')
  wait_select('category', 'Hay')
  wait_select('commodity', 'Hay Weighted Average')
}
