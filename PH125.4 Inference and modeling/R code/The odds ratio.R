?with

# Get yes/no by gender

totals <- research_funding_rates %>%
  select(-discipline) %>%
  summarise_all(sum) %>%
  mutate(yes_men = awards_men,
         no_men = applications_men-awards_men,
         yes_women = awards_women,
         no_women = applications_women-awards_women)

# total success rate

rate <- totals$awards_total / totals$applications_total

# two by two by gender, with data from dataset

two_by_two <- data.frame(awarded = c("no", "yes"), 
                         men = c(totals$no_men, totals$yes_men),
                         women = c(totals$no_women, totals$yes_women))

# odds of receiving funding for men

odds_men <- with(two_by_two, (men[2]/sum(men)) / (men[1]/sum(men)))                       
odds_men

odds_women <- with(two_by_two, (women[2]/sum(women)) / (women[1]/sum(women)))
odds_women

# how many times larger for men than women

odds_men/odds_women

# confidence intervals for the odds ratio (work with log)

log_or <- log(odds_men / odds_women)
se <- two_by_two %>% select(-awarded) %>%
  summarize(se = sqrt(sum(1/men) + sum(1/women))) %>%
  pull(se)
ci <- log_or + c(-1,1) * qnorm(0.975) * se

exp(ci)


