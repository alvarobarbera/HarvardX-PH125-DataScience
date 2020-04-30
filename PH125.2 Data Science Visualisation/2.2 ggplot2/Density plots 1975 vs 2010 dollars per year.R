library(dslabs)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(gridExtra)
library(ggridges)
data("gapminder")

gapminder <- gapminder %>%
  mutate(dollars_per_day=gdp/population/365)

gapminder <- gapminder %>% 
  mutate(group = case_when(
    region %in% c("Western Europe", "Northern Europe","Southern Europe", 
                  "Northern America", 
                  "Australia and New Zealand") ~ "West",
    region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    region %in% c("Caribbean", "Central America", 
                  "South America") ~ "Latin America",
    continent == "Africa" & 
      region != "Northern Africa" ~ "Sub-Saharan",
    TRUE ~ "Others"))

#density ridges

gapminder %>%
  filter(year %in% c(1975,2010) & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day,group,fill=group)) +
  geom_density_ridges(adjust=1.5,alpha=0.5) +
  scale_x_continuous(trans = "log2") +
  facet_grid(.~year)

#stacked density

gapminder %>% 
  filter(year %in% c(1975,2010) & country %in% country_list) %>%
  group_by(year) %>%
  mutate(weight = population/sum(population)*2) %>%
  ungroup() %>%
  ggplot(aes(dollars_per_day, fill = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.125, 300)) + 
  geom_density(alpha = 0.2, bw = 0.75, position = "stack") + 
  facet_grid(year ~ .) 

# stacked weighted density

gapminder %>%
  filter(year %in% c(1975, 2010) & country %in% country_list) %>%
  mutate(weight=population/sum(population)*2) %>%
  ggplot(aes(dollars_per_day,fill=group,weight=weight)) +
  geom_density(alpha = 0.2, bw = 0.75, position = "stack") +
  scale_x_continuous(trans = "log2",limit=c(0.125,300)) +
  facet_grid(year~.)
  


