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
  filter(year == c(1975,2010) & continent=="Americas" & !is.na(gdp)) %>%
  mutate(region = reorder(region, dollars_per_day, FUN = median)) %>%
  ggplot(aes(region,dollars_per_day,color=region)) +
  geom_boxplot() +
  theme(legend.position = "none") +
  scale_y_continuous(trans = "log2") +
  facet_wrap(~year) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


