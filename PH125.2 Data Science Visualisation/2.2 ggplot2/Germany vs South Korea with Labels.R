library(dslabs)
library(tidyverse)
library(ggplot2)
library(ggrepel)
library(dplyr)
data("gapminder")

countries <- c( "South Korea", "Germany")

labels <- data.frame(country=countries, x=c(1978,1965),y=c(60,68))

#position of labels in graph

gapminder %>%
  filter(country %in% countries) %>%
  ggplot(aes(year,life_expectancy,color=country)) +
  geom_line() +
  geom_text(data=labels, aes(x,y,label=country),size=5)
