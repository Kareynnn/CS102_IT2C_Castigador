library(rvest)
library(polite)
library(httr)


# Read the HTML file
url <- "https://www.amazon.com/s?i=specialty-aps&bbn=16225009011&rh=n%3A%2116225009011%2Cn%3A541966&ref=nav_em__nav_desktop_sa_intl_computers_and_accessories_0_2_5_6"

session <- bow(url,
               user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3")
session
session_page <- scrape(session)

# Find all div elements with the specified class
div_elements <- html_nodes(session_page, 'div.sg-col-4-of-24.sg-col-4-of-12.s-result-item.s-asin.sg-col-4-of-16.sg-col.s-widget-spacing-small.sg-col-4-of-20')

# Create empty vectors to store data
titles <- character()
prices <- character()
prices1 <- character()
ratings <- character()
rate_total <- character()

# Iterate over each div element
for (div_element in div_elements) {
  
  # Find the span element with class="a-size-base-plus a-color-base a-text-normal" and get the title
  title_element <- html_nodes(div_element, 'span.a-size-base-plus.a-color-base.a-text-normal')
  title <- ifelse(!is.na(title_element), html_text(title_element), '')
  
  # Find the span element with class="a-price-whole" and get the price
  price_element <- html_nodes(div_element, 'span.a-price-whole')
  price <- ifelse(!is.na(price_element), html_text(price_element), '')
  
}
  
  # Find the span element with class="a-price-fraction" and get the fraction number of price
  price1_element <- html_nodes(div_element, 'span.a-price-fraction')
  price1 <- ifelse(!is.na(price1_element), html_text(price1_element), '') 
  
  
  # Find the span element with class="a-icon-alt" and get the ratings
  rating_element <- html_nodes(div_element, 'span.a-icon-alt')
  rating <- ifelse(!is.na(rating_element), html_text(rating_element), '')
  
  # Find the span element with class="a-size-base s-underline-text" and get the number of raters
  rate_element <- html_nodes(div_element, 'span.a-size-base.s-underline-text')
  rate_num <- ifelse(!is.na(rating_element), html_text(rate_element), '')
  
    # Append data to vectors
  images <- c(images, image)
  titles <- c(titles, title)
  prices <- c(prices, price)
  prices1 <- c(prices1, price1)
  ratings <- c(ratings, rating)
  rate_total <- c(rate_total, rate_num)


# Create a data frame
product_df <- data.frame(Products = titles, Price = prices, PriceDecimal = prices1, Rating = ratings, Total_Rater = rate_total)

#saving as csv
write.csv(product_df, "product.csv")

#saving as RData 
save(product_df, file = "products.RData")

