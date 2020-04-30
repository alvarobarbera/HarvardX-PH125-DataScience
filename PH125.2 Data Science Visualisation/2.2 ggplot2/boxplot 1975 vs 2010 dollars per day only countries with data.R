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

country_list1 <- gapminder %>%
  filter(year==1975 & !is.na(dollars_per_day)) %>%
  .$country

country_list2 <- gapminder %>%
  filter(year==2010 & !is.na(dollars_per_day)) %>%
  .$country

country_list <- intersect(country_list1, country_list2)

gapminder %>%
  filter(year==c(1975,2010) & country %in% country_list) %>%
  mutate(region=reorder(region,dollars_per_day,FUN=median)) %>%
  ggplot(aes(region,dollars_per_day,fill=factor(year))) +
  geom_boxplot() +
  scale_y_continuous(trans = "log2") +
  theme(axis.text.x = element_text(angle=90,hjust=1))
