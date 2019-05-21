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
setwd("../R-scripts")
getwd()
load("../data/nyc_collision_saved.Rda")


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

