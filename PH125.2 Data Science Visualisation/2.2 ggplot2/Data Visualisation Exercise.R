library(dplyr)
library(dslabs)
library(ggrepel)
data(gapminder)

tab <- gapminder %>%
  filter(country %in% c("United States","Vietnam") & year %in% c(1960:2010))

p <- tab %>%
  ggplot(aes(year,life_expectancy,color=country)) +
  geom_line()

p

#dictator in Cambodia 1975 - 1979

library(dplyr)
library(ggplot2)
library(dslabs)
data(gapminder)


gapminder %>%
  filter(country=="Cambodia" & year %in% c(1960:2010)) %>%
  ggplot(aes(year,life_expectancy)) +
  geom_line(size=1,color="red") +
  geom_vline(xintercept =c(1975,1979),alpha=0.5,lty=2)


#dollars per day

daydollars <- 
  gapminder %>% 
  mutate(dollars_per_day=gdp/population/365) %>% 
  filter(year==2010 & continent=="Africa" & !is.na(dollars_per_day))


daydollars %>%
  ggplot(aes(dollars_per_day,fill=continent)) +
  geom_density() +
  scale_x_continuous(trans="log2")

# density plot

gapminder <- gapminder %>%
  mutate(dollars_per_day=gdp/population/365)

gapminder %>%  
  filter(year %in% c(1970,2010) & continent =="Africa" & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day,fill
             =year)) +
  geom_density() +
  scale_x_continuous(trans="log2") +
  facet_grid(year~.)

#stacked density plot

gapminder <- gapminder %>%
  mutate(dollars_per_day=gdp/population/365)

gapminder %>%
  filter(continent=="Africa" & year %in% c(1970,2010) & !is.na(dollars_per_day))%>% ggplot(aes(dollars_per_day,fill=region)) +
  scale_x_continuous(trans="log2") +
  geom_density(bw=0.5,position="stack") +
  facet_grid(year~.)


#scattered plot

gapminder_Africa_2010 <- # create the mutated dataset
  gapminder %>%
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent=="Africa" & year == 2010 & !is.na(dollars_per_day) & !is.na(infant_mortality))
# now make the scatter plot

gapminder_Africa_2010 %>% 
  ggplot(aes(dollars_per_day,infant_mortality,color = region)) + geom_point()


# scattered plot log scale

gapminder_Africa_2010 %>% # your plotting code here
  ggplot(aes(dollars_per_day,infant_mortality,color=region)) +
  geom_point() +
  scale_x_continuous(trans="log2")

# scattered plot with labels

gapminder_Africa_2010 %>% # your plotting code here
  ggplot(aes(dollars_per_day,infant_mortality,color=region,label=country)) +
  geom_point() +
  scale_x_continuous(trans="log2") +
  geom_text()


gapminder %>%
  mutate(dollars_per_day=gdp/population/365) %>%
  filter(continent=="Africa" & year %in% c(1970,2010) & !is.na(infant_mortality) & !is.na(dollars_per_day)) %>%
  ggplot(aes(dollars_per_day,infant_mortality,color=region,label=country)) +
  geom_label() +
  scale_x_continuous(trans="log2") +
  facet_grid(year~.)
