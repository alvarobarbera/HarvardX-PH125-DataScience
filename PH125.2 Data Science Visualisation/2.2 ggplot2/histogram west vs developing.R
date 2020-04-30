library(dslabs)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
library(gridExtra)
data("gapminder")

gapminder <- gapminder%>%
  mutate(dollars_per_day=gdp/population/365)

west <- c("Northern Europe", "Western Europe", "Southern Europe", "Northern America", "Australia and New Zealand")



gapminder %>%
  filter(year==c(1975,2010) & !is.na(gdp)) %>%
  mutate(group=ifelse(region %in% west, "West", "Developing")) %>%
  ggplot(aes(dollars_per_day)) +
  geom_histogram(binwidth = 1,color="black") +
  scale_x_continuous(trans = "log2") +
  facet_grid(year~group)

