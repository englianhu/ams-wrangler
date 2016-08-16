date_format <- '%m/%d/%Y'
start_date <- as.Date('01/01/2000', format = date_format)
end_date <- as.Date(Sys.time(), format = date_format)
start_vec <- seq(start_date, end_date, by = 'year')
end_vec <- c(start_vec[-1] - 1, end_date)
