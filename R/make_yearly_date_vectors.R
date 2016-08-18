date_format <- '%m/%d/%Y'
start <- as.Date('01/01/2000', format = date_format)
start_date <- seq(start, end_date(), by = 'year')
end_date <- c(start_date[-1] - 1, end_date())
