library(dslabs)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(gridExtra)
data("gapminder")

west <- c("Northern Europe", "Western Europe", "Southern Europe", "Northern America", "Australia and New Zealand")


gapminder <- gapminder %>%
  mutate(dollars_per_day=gdp/population/365)

country_list1 <- gapminder %>%
  filter(year==1970 & !is.na(dollars_per_day)) %>%
  .$country

country_list2 <- gapminder %>%
  filter(year==2010 & !is.na(dollars_per_day)) %>%
  .$country

country_list <- intersect(country_list_1,country_list2)

gapminder %>%
  filter(year == c(1975,2010) & country %in% country_list) %>%
  mutate(group=ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day,y=..count..,fill=group)) +
  geom_density(alpha=0.2,bw=0.65) +
  scale_x_continuous(trans = "log2", limit= c(0.125,300)) +
  facet_grid(year~.)

