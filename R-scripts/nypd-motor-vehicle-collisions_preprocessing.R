install.packages("tidyverse")
## Core tidyverse packages automatically load ggplot2, dplyr, tidyr, readr, purrr, tibble, stringr, forcats.
library(tidyverse)

## The lubridate package comes with tidyverse but the library needs to be load separately.
library(lubridate)

## Intall the package to read large local CSV file through fread() function:
install.packages("data.table")
library(data.table)

## Install the package to geocode locations between longitude & latitiude <> zip code & neighborhood, 
## and visualize spatial data and models on top of static maps from various online sources (e.g Google Maps and Stamen Maps).
install.packages("ggmap")
library(ggmap)

install.packages("zipcode")
library(zipcode)

install.packages("sf")
library(sf)

## Turn off scientific notation
options(scipen = 999)

## Graphical scales map data to aesthetics, and provide methods for automatically 
## determining breaks and labels for axes and legends for visulization.
install.packages("scales")
library(scales)


## Install the package for Classification using Decison Tree:
install.packages("party")
library(party)


## ------ Data Import ------

## Install the required package of NYC Open Data SODA API to access the data online:
install.packages("RSocrata")
library(RSocrata)

## Data Import Method 1: Access data via NYC Open Data SODA API:
nyc_collision <- read.socrata("https://data.cityofnewyork.us/resource/qiz3-axqb.json", 
                              app_token = "2vFix7G27Pze1rkNxoSIVY2TJ")


View(nyc_collision)
dim(nyc_collision)
glimpse(nyc_collision)

# ## Data Import Method 2: Read raw data from CSV file:
# getwd()
# nyc_collision_raw <- fread("./NYPD_Motor_Vehicle_Collisions.csv")
# glimpse(nyc_collision_raw)

## Note 1: the data fetched from NYC Open Data SODA API has one extra column "location.type" than waht listed on the website or CSV file.
## Note 2: the field/column name in CSV file and from SODA API are formated differently.

nyc_collision <- as_tibble(nyc_collision)
str(nyc_collision)
nyc_collision

## Overview the total number of NA in each column:
map(nyc_collision, ~sum(is.na(.)))   ## Display the total number of NA of each variable by 1 object per row.

colSums(is.na(nyc_collision))   ## Display the total number of NA of each variable by by showing multiple object per row.

## Get the percentage of NA (missing value in each colum):
filter_vars <- nyc_collision %>% 
  map_dbl(~sum(is.na(.)) / length(.))
filter_vars %>% str()
str(filter_vars)


nyc_collision %>%
  filter(is.na(longitude)) %>%
  View()

## Display the columns that have Miss Value rate less or equal than 15%, which should be keep for analysis:
filter_vars <- nyc_collision %>%
  map_dbl(~sum(is.na(.))/length(.))
filter_vars[filter_vars > 0.15]

str(nyc_collision)

# clean_collision <- sapply(nyc_collision, function(nyc_collision) ~sum(is.na(.)) / length(.) <= 0.15)
# clean_collision
# rm(clean_collision)
# gc()

## Display columns which contain over 15% missing values:
filter_vars[filter_vars > 0.15]
# deleteCol <- c("off_street_name", "on_street_name", "vehicle_type_code2", "contributing_factor_vehicle_3", 
#                "vehicle_type_code_3", "cross_street_name", "contributing_factor_vehicle_4", "vehicle_type_code_4", 
#                "contributing_factor_vehicle_5", "vehicle_type_code_5")

# ## Drop columns which contain over 15% missing values except `borough` & `zip_code`:
# nyc_collision_saved <- subset(nyc_collision, select = -c(`off_street_name`, `on_street_name`, `vehicle_type_code2`, `contributing_factor_vehicle_3`, 
#                                                          `vehicle_type_code_3`, `cross_street_name`, `contributing_factor_vehicle_4`, `vehicle_type_code_4`, 
#                                                          `contributing_factor_vehicle_5`, `vehicle_type_code_5`))


## Save columns which contain less or equal 15% missing values:
nyc_collision_saved <- nyc_collision %>% 
  select(names(filter_vars[filter_vars <= 0.15]))
# nyc_collision[names(filter_vars[filter_vars <= 0.15])]

str(nyc_collision_saved)
glimpse(nyc_collision_saved)

## Keep only rows which have both valid latitude and longitude values:
nyc_collision_saved <- subset(nyc_collision_saved, !(is.na(`latitude`)) & !(is.na(`longitude`)))

## Convert `latitude` and `longitude` from character to double:
# nyc_collision_saved$latitude <- as.double(nyc_collision_saved$latitude)
# str(nyc_collision_saved$latitude)
# 
# nyc_collision_saved$longitude <- as.double(nyc_collision_saved$longitude)
# str(nyc_collision_saved$longitude)

# 
# nyc_collision_saved[,10:12] %>% 
#   modify(as.numeric)
# 
# nyc_collision_saved %>% 
#   modify_at(10:12,~as.numeric(.))

## Convert columns `latitude`, `longitude`, `number_of_cyclist_injured`:`number_of_persons_killed` from character to numeric values by column index:
nyc_collision_saved <- nyc_collision_saved %>%
  modify_at(c(4, 7:15), ~as.numeric(.))

glimpse(nyc_collision_saved)

# nyc_collision_saved <- nyc_collision_saved %>%
#   select(`latitude`, `longitude`, `number_of_cyclist_injured`:`number_of_persons_killed`) %>%
#   transmute_if(is.character, as.numeric)


# ## Select/Subset and convert some other columns from character to integer:
# nyc_collision_saved <- nyc_collision_saved %>%
#   select(`number_of_cyclist_injured`:`number_of_persons_killed`) %>%
#   transmute_if(is.character, as.integer)

str(nyc_collision_saved)
glimpse(nyc_collision_saved)

View(nyc_collision_saved)


colSums(is.na(nyc_collision_saved))

nyc_collision_saved %>%
  filter(is.na(`contributing_factor_vehicle_1`)) %>%
  View()

## Keep only rows which have both valid `contributing_factor_vehicle_1` and `vehicle_type_code1`:
nyc_collision_saved <- subset(nyc_collision_saved, !(is.na(`contributing_factor_vehicle_1`)) & !(is.na(`vehicle_type_code1`)))

View(nyc_collision_saved)

colSums(is.na(nyc_collision_saved))

## Replacing missing value with "None" in column `contributing_factor_vehicle_2`:
nyc_collision_saved[, 2][is.na(nyc_collision_saved[, 2])] <- c("None")
colSums(is.na(nyc_collision_saved))

## Replacing missing value with 0 in columns `number_of_persons_injured` and `number_of_persons_killed`:
nyc_collision_saved[, 14:15][is.na(nyc_collision_saved[, 14:15])] <- 0
colSums(is.na(nyc_collision_saved))

##Save the final cleaned data as Rda file for future use:
getwd()
setwd("./data")
getwd()
save(nyc_collision_saved, file = "nyc_collision_saved.Rda")
