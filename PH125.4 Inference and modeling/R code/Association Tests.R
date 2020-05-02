library(dslabs)
library(dplyr)
library(tidyverse)
data("research_funding_rates")

head(research_funding_rates)
# results reveal gender bias favoring male applicants over female applicants

research_funding_rates %>% 
  select(discipline, applications_total, success_rates_total) %>%
  head()

totals <- research_funding_rates %>%
  select(-discipline) %>%
  summarise_all(sum) %>%
  summarise(yes_men = awards_men,
            no_men = applications_men - awards_men,
            yes_women = awards_women,
            no_women = applications_women - awards_women)

# success rates are higher for men

totals %>% summarise(percent_men = yes_men/(yes_men+no_men),
                     percent_women = yes_women/(yes_women+no_women))

# But could this be due just to random variability? 
# Here we learn how to perform inference for this type of data.

