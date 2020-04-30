library(dslabs)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(gridExtra)
data("gapminder")

gapminder <- gapminder %>%
  mutate(dollars_per_day=gdp/population/365)

d1 <- gapminder %>%
  filter(year == 1970 & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  ggtitle("D1 no scale transformation")

d2 <- gapminder %>%
  filter(year == 1970 & !is.na(gdp)) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1, color = "black") +
  scale_x_continuous(trans = "log2") +
  ggtitle("D2 log2 scale")

grid.arrange(d1,d2,nrow=1)


  