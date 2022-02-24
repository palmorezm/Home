
# Lock Screen Locations
# Web-searching List
# Published via Glink

file <- "https://docs.google.com/document/d/e/2PACX-1vSrVkVvQBE75wh9Pb095eY5WphbaclpuS5dzwfqII8Ht4e9hY_Pu5NHc_6P3xJI7qBqjzmLmfmBAmm8/pub"
locations <- read.delim2(file = file, header = F, sep = "\t")
print(locations)


#####

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

str1 <- stringr::str_extract(locations, )
