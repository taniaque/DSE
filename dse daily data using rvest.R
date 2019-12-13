# This pulls the latest price and volume data of all the dse tickers from dse website and exports the data as csv file in your
# working diretory. This code is written in R using the underrated library, rvest.

#Import rvest library first
library(rvest)

#Read DSE url and data
dse_url <- xml2::read_html("https://www.dsebd.org/latest_share_price_all_by_ltp.php")
dse_data <- dse_url %>%
        html_nodes(xpath = "//table") %>%
        html_table(header = TRUE)



#Add date and time 
dse_data$time <- Sys.time()

#Just for demonstration purpose, the extracted data:
str(dse_data)

#The End
