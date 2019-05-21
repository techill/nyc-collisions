# install.packages("tidyverse")
# ## Core tidyverse packages automatically load ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, forcats.
library(tidyverse)
# 
# ## The lubridate package comes with tidyverse but the library needs to be load separately.
library(lubridate)
# 
# ## Intall the package to read large local CSV file through fread() function:
# install.packages("data.table")
library(data.table)
# 
# ## Install the package to geocode locations between longitude & latitiude <> zip code & neighborhood, 
# ## and visualize spatial data and models on top of static maps from various online sources (e.g Google Maps and Stamen Maps).
# install.packages("ggmap")
library(ggmap)
# 
# install.packages("zipcode")
library(zipcode)
# 
# install.packages("sf")
library(sf)
# 
# ## Turn off scientific notation
options(scipen = 999)
# 
# ## Graphical scales map data to aesthetics, and provide methods for automatically 
# ## determining breaks and labels for axes and legends for visulization.
# install.packages("scales")
library(scales)

getwd()
setwd("./src")
getwd()
load("nyc_collision_saved.Rda")

## ------ Data Visualization ------


## ------ Interactive Maps with Leaflet ------
## Install the open-source JavaScript libraries leaflet for interactive maps:
# install.packages("leaflet")
library(leaflet)

collisons_2019_newyear <- nyc_collision_saved %>% 
  filter(date == "2019-01-01")

collisons_2019_newyear

collision_map <- leaflet(collisons_2019_newyear) %>% 
  addTiles() %>% 
  addCircleMarkers(lng = ~longitude, lat = ~latitude, popup = "NYC Collisions")

collision_map


glimpse(nyc_collision_saved)

################################

## ------ Count Function ------
# install.packages("plyr")
library(plyr)

count(nyc_collision_saved$contributing_factor_vehicle_1)
count(nyc_collision_saved$vehicle_type_code1)

glimpse(nyc_collision_saved)

factor1 <- nyc_collision_saved %>% 
  # filter(`contributing_factor_vehicle_1` == "Listening/Using Headphones") %>% 
  filter(`contributing_factor_vehicle_1` == "1")

View(factor1[,c("contributing_factor_vehicle_1", "date", "location.coordinates", "number_of_persons_injured", 
                "number_of_persons_killed", "time", "vehicle_type_code1")])


################################
# require(tigris)
# library(dplyr)
# library(leaflet)
# library(sp)
# library(ggmap)
# library(maptools)
# library(broom)
# library(httr)
# library(rgdal)
# 
# 
# 
# # ## Google Map API requires registration with billing info:
# # textAddress <- mapply(FUN = function(longitude, latitude) revgeocode(c(longitude, latitude)), nyc_collision_saved$longitude, nyc_collision_saved$latitude)
# 
# # nyc_map <- get_map(location = c(lon = -74.00, lat = 40.71), maptype = "terrain", zoom = 11)
# # 
# r <- GET('http://data.beta.nyc//dataset/0ff93d2d-90ba-457c-9f7e-39e47bf2ac5f/resource/35dd04fb-81b3-479b-a074-a27a37888ce7/download/d085e2f8d0b54d4590b1e7d1f35594c1pediacitiesnycneighborhoods.geojson')
# nyc_neighborhoods <- readOGR(content(r,'text'), 'OGRGeoJSON', verbose = F)
# 
# summary(nyc_neighborhoods)
# View(nyc_neighborhoods)
# glimpse(nyc_neighborhoods)
# # 
# # nyc_neighborhoods_df <- tidy(nyc_neighborhoods)
# # 
# # ggplot() + 
# #   geom_polygon(data=nyc_neighborhoods_df, aes(x=long, y=lat, group=group))
# # 
# # ggmap(nyc_map) + 
# #   geom_polygon(data=nyc_neighborhoods_df, aes(x=long, y=lat, group=group), color="blue", fill=NA)
# 
# 
# ## Install the package that provides functions to very quickly and conveniently create interactive visualisations of spatial data
# install.packages("mapview")
# library(mapview)
# 
# mapview(breweries)
# View(breweries)
# str(breweries$geometry)
# 
# ## make the UTM cols spatial (X/Easting/lon, Y/Northing/lat)
# nyc_collision_saved.sp <- st_as_sf(nyc_collision_saved, coords = c("longitude", "latitude"), crs = 4326)
# st_crs(32610) ## more detailed def (UTMs)
# st_crs(nyc_collision_saved.sp)
# 
# ## transform to UTM
# nyc_collision_saved.sp <- st_transform(x = nyc_collision_saved.sp, crs = 32610)
# 
# # get coordinates and add back to dataframe
# nyc_collision_saved.sp$utm_E <- st_coordinates(nyc_collision_saved.sp)[, 1] # get coordinates
# nyc_collision_saved.sp$utm_N <- st_coordinates(nyc_collision_saved.sp)[, 2] # get coordinates
# 
# View(nyc_collision_saved.sp)
# # now switch back to lat-long
# nyc_collision_saved.sp<-st_transform(x = nyc_collision_saved.sp, crs = 4326)
# 
# glimpse(nyc_collision_saved.sp)
# ################
# 
# # # add coordinates to dataframe
# # nyc_collision_saved.sp$lon<-st_coordinates(df.SP)[,1] # get coordinates
# # df.SP$lat<-st_coordinates(df.SP)[,2] # get coordinates
# 
# 
# str(nyc_collision_saved$location.coordinates)
# 
# mapview(nyc_collision_saved.sp)






################################

