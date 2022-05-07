#############################################################################
# Created 2-28-2022
# Author Jessica Hunter
# This Tidy Tuesday is about Freedom
# this data is from 195 countries and their civil rights and liberties
#############################################################################

library(tidyverse)
library(here)
library(ggplot2)
library(gganimate)

#############################################################################

# install.packages("gganimate")
# install.packages("tidytuesdayR")
# tuesdata <- tidytuesdayR::tt_load('2022-02-22')
free_filter <- read_csv(here("2.22.22","data", "freedom.csv")) %>% 
  filter(Status == "PF" | Status == "NF") %>% 
  select(Region_Name, country, year, Status)
#view(free_filter)
  

freeformat <- free_filter %>% 
  group_by(year,Status, Region_Name) %>% 
  count()



staticplot <- ggplot(freeformat,
       mapping = aes(y = Region_Name,
                     x = n,
                     fill = Status))+
  geom_col()

anim = staticplot +
  transition_states(year,
                    transition_length = 4,
                    state_length = 1)+
  labs(title = "Number of Countries not fully free by Region {closest_state}")

animate(anim, 20, fps = 2,
        width = 1000, # in pixels
        height = 800,
        renderer = gifski_renderer("gganim.gif"))




