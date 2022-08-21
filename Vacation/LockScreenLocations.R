
# Lock Screen Locations
# Web-searching List
# Published via Glink

file <- "https://docs.google.com/document/d/e/2PACX-1vSrVkVvQBE75wh9Pb095eY5WphbaclpuS5dzwfqII8Ht4e9hY_Pu5NHc_6P3xJI7qBqjzmLmfmBAmm8/pub"
locations <- read.delim2(file = file, header = F, sep = "\t")
print(locations)


##### Example text

# Travel Â List</span></p><p class=c1 c2><span class=c0></span>
# </p><p class=c1><span class=c0>Lake Mezzola, Italy</span>
# </p><p class=c1><span class=c0>Serengeti, Tanzania</span>
# </p><p class=c1><span class=c0>himalaya, Gokyo Ri, Sagarmatha National</span>
# </p><p class=c1><span class=c0>Catalina, California</span>
# </p><p class=c1><span class=c0>High Coast, Sweden</span>
# </p><p class=c1><span class=c0>Anhui, China</span>

##### 


library(stringr)

# Extract the characters that contains our locations

# Attempts to reach 5e
# str1 <- stringr::str_extract_all(locations, "class=c0>(.*?)</span>")
# str2 <- stringr::str_extract_all(locations, "c0>(.*?)</")
# pattern <- "class=c0>(.*?)</span>"
# str3 <- regmatches(locations, regexec(pattern, locations)) # Nothing good
# str4 <- stringr::str_extract_all(locations, ">(.*?)<")

# Functioning Below: 
str5 <- data.frame(stringr::str_extract_all(locations, ">(.*?)<"))
str5a <- data.frame(stringr::str_remove_all(str5[1], ">"))
str5b <- stringr::str_remove_all(str5[,1], ">")
str5c <- stringr::str_remove_all(str5b, "<")
str5d <- data.frame(str5c)
# head(str5d, na.rm = T)
str5d$str5c[which(str5d$str5c == "")] <- NA
# sum(is.na(str5d$str5c))
str5e <- na.omit(str5d)




# Image Collection
require(rvest)
# require(purrr)
require(httr)

# To see an image of "london" in the url:
# https://www.google.com/search?tbm=isch&q=london
image_query_base <- "https://www.google.com/search?tbm=isch&q=" 
str5e$str5c[[9]] # Where locations begin
url <- paste0(image_query_base, str5e$str5c[[9]])
res1 <- GET(url = url)

# *Consider using selector gadget to select in CSS first 3 images using london example
# then read in html nodes and collect image? 
# from selector gadget: .Q4LuWd (gives all images on the page)

html_res1 <- read_html(res1$content)

read_html(sprintf(url, 1))

images <- str5e(1:10, function(i) {
  
  # simple but effective progress indicator
  cat(".")
  
  pg <- read_html(sprintf(url_base, i))
  
  data.frame(wine=html_text(html_nodes(pg, ".review-listing .title")),
             excerpt=html_text(html_nodes(pg, "div.excerpt")),
             rating=gsub(" Points", "", html_text(html_nodes(pg, "span.rating"))),
             appellation=html_text(html_nodes(pg, "span.appellation")),
             price=gsub("\\$", "", html_text(html_nodes(pg, "span.price"))),
             stringsAsFactors=FALSE)
  
})

dplyr::glimpse(wines)




