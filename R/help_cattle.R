## Helper function to set up cattle data extractions ---------------------------
init_cattle <- function() {
  remDr$navigate('https://marketnews.usda.gov/mnp/ls-report-config')
  wait(3)
  wait_select('category', 'Cattle')
  wait_select('commodity', 'Feeder & Replacement')
  wait_select('rtype', 'Weighted Average')
  wait_select('repType', 'Daily')
}



nav_cattle <- function(subComm = NULL, fsize = NULL, mscore = NULL,
                       wrange = NULL) {
  init_cattle()
  if (!is.null(subComm)) {
    wait_select('subComm', subComm)
  }
  if (!is.null(fsize)) {
    wait_select('fsize', fsize)
  }
  if (!is.null(mscore)) {
    if (mscore != muscle_scores[1]) {
      wait_select('mscore', mscore)
    } # otherwise, leave as first option
  }
  if (!is.null(wrange)) {
    wait_select('wrange', wrange)
  }
}



