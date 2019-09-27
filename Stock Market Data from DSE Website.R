# This code fetches stock Name, Latest trade price, Last audited NAV, Current market cap and Dividend yield for the last audited year.
# Recommended to use this as barebone to build a larger, customized script.
#Good luck


#Import rvest library
library(rvest)
#insert your tickers
tickers <- c("GP","BRACBANK","SINGERBD", "ACMELAB", "BBSCABLES")
n <- length(tickers)

#The core function
basefunction <- function(ticker)
{
  #Read DSE url and data
  
  base <- "https://www.dsebd.org/displayCompany.php?name="
  url <- paste(base,ticker, sep="")
  url
  
  dse_url <- xml2::read_html(url)
  
  #Data extraction: t for text and v for value
  
  function_t <- function(value){
    content <- dse_url %>%
      html_node(value) %>%
      html_text()
  }
  function_v <- function(value){
    content <- dse_url %>%
      html_node(value) %>%
      html_text() %>%
      as.numeric()
  }
  #running the functions to get specific data
  name <- function_t("i")
  price <- function_v("td td td table:nth-child(7) td:nth-child(1) tr:nth-child(1) td+ td")
  nav <- function_v(".alt+ .shrink:nth-child(8) td:nth-child(8)")
  mcap <- as.numeric(gsub(",", "", function_t("td+ td tr:nth-child(7) td+ td")))
  yield <- function_v(".shrink:nth-child(9) td:nth-child(9)")
  
  #Final form of data we want
  datass = data.frame(name, price,nav,mcap, yield)
}

#First row of data frame
final <- basefunction(tickers[1])

#Running the rest of the tickers and adding them to dataframe
for(i in 2:n) {
  data <- basefunction(tickers[i])
  final <- rbind(final,data)
  final
}
#Print the final dataframe
final
#Save to csv
write.csv(final,"DSE.csv")
