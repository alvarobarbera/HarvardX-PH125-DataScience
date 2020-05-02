data("research_funding_rates")

totals <- research_funding_rates %>% 
  select(-discipline) %>% 
  summarize_all(sum) %>%
  summarize(yes_men = awards_men, 
            no_men = applications_men - awards_men, 
            yes_women = awards_women, 
            no_women = applications_women - awards_women) 

# Imagine we have 290, 1,345, 177, 1,011 applicants, some are men and some are women and 
# some get funded, whereas others don’t. We saw that the success rates for men and woman were:

# percent_men percent_women
#    0.17737     0.1489899

totals %>% summarize(percent_men = yes_men/(yes_men+no_men),
                     percent_women = yes_women/(yes_women+no_women))

# respectively. Would we see this again if we randomly assign funding at the overall rate:

rate <- totals %>%
  summarise(rate=(yes_men+yes_women)/(yes_men+yes_women+no_men+no_women)) %>%
  pull(rate)
rate

# The Chi-square test answers this question. The first step is to create the 
# two-by-two data table:

two_by_two <- data.frame(awarded=c("no","yes"),
                         men = c(totals$no_men,totals$yes_men),
                         women = c(totals$no_women,totals$yes_women))
two_by_two

# The general idea of the Chi-square test is to compare this two-by-two table 
# to what you expect to see. We build a 2x2 applying the total rate to total applications
# by gender


data.frame(awarded=c("no","yes"),
           men = (totals$no_men+totals$yes_men)*c(1-rate,rate),
           women = (totals$no_women+totals$yes_women)*c(1-rate,rate))

chisq_test <- two_by_two %>% select(-awarded) %>% chisq.test()
chisq_test
