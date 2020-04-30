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
    .$region %in% west ~ "The West",
    .$region %in% "Northern Africa" ~ "Northern Africa",
    .$region %in% c("Eastern Asia", "South-Eastern Asia") ~ "East Asia",
    .$region == "Southern Asia" ~ "Southern Asia",
    .$region %in% c("Central America", "South America", "Caribbean") ~ "Latin America",
    .$continent == "Africa" & .$region != "Northern Africa" ~ "Sub-Saharan Africa",
    .$region %in% c("Melanesia", "Micronesia", "Polynesia") ~ "Pacific Islands"))



# define a data frame with group average income and average
# infant survival rate

surv_income <- gapminder %>%
  filter(year == 2010 & !is.na(gdp) & !is.na(infant_mortality) & !is.na(group)) %>%
  group_by(group) %>%
  summarise(income=sum(gdp)/sum(population)/365,
infant_survival_rate = 1 - sum(infant_mortality/1000*population)/sum(population))

surv_income %>% arrange(income)

GROUP <- surv_income %>% ggplot(aes(income, infant_survival_rate, label = group, color = group)) +
  scale_x_continuous(trans = "log2", limit = c(0.25, 150)) +
  scale_y_continuous(trans = "logit", limit = c(0.875, .9981),
                     breaks = c(.85, .90, .95, .99, .995, .998)) +
  geom_label(size = 3, show.legend = FALSE) 


COUNTRY <- gapminder %>% 
  filter(year == 2010 & !is.na(gdp) & !is.na(infant_mortality) & !is.na(group)) %>%
  group_by(group) %>%
  ggplot(aes(dollars_per_day,1-infant_mortality/1000,color=group)) +
  geom_point(size=3,alpha=0.5,show.legend = FALSE) +
  scale_x_continuous(trans = "log2", limit=c(.25,150)) +
  scale_y_continuous(trans = "logit",limit=c(0.875,.9981), breaks = c(.85, .90, .95, .99, .995, .998))

grid.arrange(GROUP,COUNTRY,nrow=1)





