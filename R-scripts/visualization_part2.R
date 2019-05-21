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
install.packages("sf")
library(sf)
#
# ## Turn off scientific notation
# options(scipen = 999)
#
# ## Graphical scales map data to aesthetics, and provide methods for automatically
# ## determining breaks and labels for axes and legends for visulization.
# install.packages("scales")
library(scales)
#
#
library(dplyr)
# to be able to use count and mod the columns in the data frame 
install.packages("plyr")
library(plyr)

getwd()
# Set Working Directory
setwd("~/Documents/spring2019/math301/project/")

#load the data set into the project 
load("nyc_collision_saved.Rda")

#view the table
View(nyc_collision_saved)


median(nyc_collision_saved$number_of_persons_killed)
mean(nyc_collision_saved$number_of_persons_injured)

sd(nyc_collision_saved$number_of_persons_killed)
#summary of the persons killed and injured 
summary(nyc_collision_saved$number_of_persons_killed)
summary(nyc_collision_saved$number_of_persons_injured)

#show the number of contributing facotors involed in the accidents reported 
(nyc_collision_saved$contributing_factor_vehicle_1)

# get the maximum number of perosn injured with in 1 accident
max(nyc_collision_saved$number_of_persons_injured)

#mydata <- nyc_collision_saved

#filter(nyc_collision_saved,

    #number of persons killed in March 2019   
    temp1<- nyc_collision_saved[nyc_collision_saved$date >= "2019-03-01" & nyc_collision_saved$date <= "2019-03-31",]
    temp2<- nyc_collision_saved[nyc_collision_saved$date >= "2018-03-01" & nyc_collision_saved$date <= "2018-03-31",]
    temp3<- nyc_collision_saved[nyc_collision_saved$date >= "2017-03-01" & nyc_collision_saved$date <= "2017-03-31",]
    temp4<- nyc_collision_saved[nyc_collision_saved$date >= "2016-03-01" & nyc_collision_saved$date <= "2016-03-31",]
    temp5<- nyc_collision_saved[nyc_collision_saved$date >= "2015-03-01" & nyc_collision_saved$date <= "2015-03-31",]
    
    table(temp1$number_of_persons_killed)
    
    March_2019<-sum(temp1$number_of_persons_killed)
    View(March_2019)
    sum(temp$number_of_persons_injured)
    
    
    sum(temp1$number_of_persons_killed)
    sum(temp2$number_of_persons_killed)
    sum(temp3$number_of_persons_killed)
    sum(temp4$number_of_persons_killed)
    sum(temp5$number_of_persons_killed)
    
    sum(temp1$number_of_persons_injured)
    sum(temp2$number_of_persons_injured)
    sum(temp3$number_of_persons_injured)
    sum(temp4$number_of_persons_injured)
    sum(temp5$number_of_persons_injured)
    
    
    #number of persons killed in March 2018
    temp2<- nyc_collision_saved[nyc_collision_saved$date >= "2018-03-01" & nyc_collision_saved$date <= "2018-03-31",]
    View(temp2)
    
    sum(temp2$number_of_persons_killed)

    sum(temp2$number_of_persons_injured)
    
    #total number of peple killed and injured in the data set from 2012-07-01 to 2019-04-01
    temp3<- nyc_collision_saved[nyc_collision_saved$date >= "2012-07-01" & nyc_collision_saved$date <= "2019-04-01",]
    View(temp3)
    
    sum(temp3$number_of_persons_killed)
    sum(temp3$number_of_persons_injured)
    
    
   #nyc_collision_saved %>% 
    # select(vehicle_type_code1, number_of_persons_killed, number_of_persons_injured, contributing_factor_vehicle_1, date,)
  #filter(vehicle )
    
    #nyc_collision_saved %>% 
     # select(vehicle_type_code1,)
    
    v %>% 
      select(vehicle_type_code1) %>% 
    count(vehicle_type_code1)
     
     v<-nyc_collision_saved
    
    # get the number of vehicles involes in accidents 
    t<- count(v$vehicle_type_code1)
   sort(t$x, decreasing = TRUE)
     
     
   
   View(t)
 
  # library(gmodels)
   #install.packages("gmodels")
   
   #w<-CrossTable(t$x,t$freq, max.width = 10)
   #View(w)
   
 
   #Passageercar
   res<-((609173/1279740)*100)
   #ambulance
   res2<-((3243/1279740)*100)
   #taxi 
   res3<-((56381/1279740)*100)
   
   q<-(276128+69935)
   
   #SUV
   res4<-(q/1279740)*100
   
   con<-count(v$contributing_factor_vehicle_1)

  new <- data.frame("x" = "Ambulance_Combined", "freq" = 3243)
   t <- rbind(t, new)
new_t <- t[-c(23:35),]   


t2<-nyc_collision_saved

tt<-t2$contributing_factor_vehicle_1

str(tt)
str(t2)

t2 %>% 
  group_by(contributing_factor_vehicle_1)
dplyr::summarise(mean = mean())
##
tt<-plyr::count(t2$contributing_factor_vehicle_1)
View(tt)

(12130/1279740)*100


hist(nyc_collision_saved$number_of_persons_killed)
hist(nyc_collision_saved$number_of_persons_injured)

library(expss)
install.packages("expss")

nyc_collision_saved %>% 
  tab_cells(nyc_collision_saved$date >= "2019-03-01" & nyc_collision_saved$date <= "2019-03-31", )

levels(nyc_collision_saved$number_of_persons_killed)

str(nyc_collision_saved)

hist(nyc_collision_saved$contributing_factor_vehicle_1)



