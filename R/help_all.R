# Generalized helper functions --------------------------------------------
initialize_browser <- function() {
  checkForServer()
  startServer()
  fprof <- makeFirefoxProfile(
    list(browser.download.manager.showWhenStarting = FALSE,
         browser.helperApps.neverAsk.saveToDisk = 'text/plain')
    )
  remDr <- remoteDriver(remoteServerAddr = "localhost",
                        port = 4444,
                        browserName = "firefox",
                        extraCapabilities = fprof
  )
  remDr$open()
  remDr
}


wait_select <- function(css, input, clear = FALSE) {
  element <- remDr$findElement(using = 'css selector', value = paste0('#', css))
  wait()
  if (clear) {
    element$clearElement()
  }
  if (class(input) == 'Date') {
    input <- format(input, format = date_format)
  }
  element$sendKeysToElement(list(input, key = 'enter'))
}



get_options <- function(css) {
  webElement <- remDr$findElement(using = 'css selector',
                                  value = paste0('#', css))
  wait()
  stopifnot(class(webElement) == 'webElement')
  webElement$getElementText() %>%
    unlist() %>%
    strsplit(split = '\n') %>%
    unlist()
}



wait <- function(sec = 1) {
  Sys.sleep(sec)
}


end_date <- function() {
  as.Date(Sys.time(), format = date_format)
}



is_loading <- function(html) {
  stopifnot(length(html) > 0)
  any(grepl('Your Request is being processed', html))
}



has_results <- function(html) {
  stopifnot(length(html) > 0)
  any(grepl('Download as:', html)) &
    !any(grepl('No results found', html))
}



download_data <- function(type = NULL, wait_time = 1) {
  txt_link <- remDr$findElement(using = 'css selector',
                                value = '.BodyTextBlack a:nth-child(2) img')
  txt_link$clickElement()
  wait(wait_time)

  new_file <- name_data(type)
  orig_name <- file.path('~', 'Downloads', 'report.txt')

  n_tries <- 30
  while (n_tries > 0 & (!file.exists(orig_name) | file.info(orig_name)$size == 0)) {
    wait(2)
    n_tries <- n_tries - 1
  }
  file.rename(orig_name, new_file)
  if (!file.exists(new_file)) {
    stop(paste('File:', new_file, 'should exist, but does not!'))
  }
  if (file.info(new_file)$size == 0) {
    stop('Destination data file has size 0!')
  }
}



name_data <- function(type) {
  if (type == 'cattle') {
    name <- tolower(paste('cattle',
                          subcommodities[i],
                          fsizes[j],
                          muscle_scores[k],
                          wranges[l],
                          sep = '-'))
  } else if (type == 'beef') {
    name <- tolower(paste('beef', report_types[i], start_date[j], sep = '-'))
  } else if (type == 'hay') {
    name <- tolower(paste('hay', start_date[i], sep = '-'))
  } else {
    stop('Unsupported data type! Should be beef, hay or cattle.')
  }
  new_file_name <- file.path('data', paste0(name, '.txt')) %>%
    gsub(pattern = ' ', replacement = '_')
  new_file_name
}



get_html <- function() {
  html_code <- htmlParse(remDr$getPageSource()[[1]], asText = TRUE)
  html <- capture.output(html_code)
  tot_wait <- 10
  wait_times <- tot_wait
  t_wait <- 2
  while (is_loading(html) & wait_times > 0) {
    wait(t_wait)
    wait_times <- wait_times - 1
    html_code <- htmlParse(remDr$getPageSource()[[1]], asText = TRUE)
    html <- capture.output(html_code)
  }
  if (is_loading(html)) {
    stop(paste('HTML page has not loaded after', tot_wait * t_wait, 'seconds'))
  }
  html
}


query_rButtonRow <- function() {
  run <- remDr$findElement(using = 'css selector', value = '.runButtonRow input')
  run$clickElement()
  wait(10)
}



check_for_missed_data <- function() {
  missed <- list.files(path = file.path('~', 'Downloads'), pattern = 'report')
  if (length(missed > 0)) {
    stop("A file with 'report' in the filename exists in the Downloads folder. This should have been copied to the data folder!")
  }
}


date_format <- '%m/%d/%Y'
