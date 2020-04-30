library(dslabs)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(gridExtra)
data("gapminder")

gapminder <- gapminder %>%
  mutate(dollars_per_day=gdp/population/365)

gapminder %>%
  filter(year==1970) %>%
  ggplot(aes(region,dollars_per_day)) +
  geom_boxplot() +
  theme(axis.text.x = element_text(angle = 90,hjust = 1))
