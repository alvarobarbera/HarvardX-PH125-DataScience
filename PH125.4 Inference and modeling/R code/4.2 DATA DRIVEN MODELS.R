library(tidyverse)
library(dslabs)
data("polls_us_election_2016")


# Filter out US, data after 31 Oct and upper grades or no grade

polls <- polls_us_election_2016 %>% 
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+","A","A-","B+") | is.na(grade)))

# include a column for spread

polls <- polls %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# filter the last poll for each pollster
one_poll_per_pollster <- polls %>%
  group_by(pollster) %>%
  filter(enddate==max(enddate)) %>%
  ungroup()

# histogram of spread

qplot(spread, data = one_poll_per_pollster, binwidth = 0.01 )
# or
one_poll_per_pollster %>% ggplot(aes(spread)) + geom_histogram(binwidth = .01)


# The urn model with 0 or 1 is no longer valid, we need to build a new model, 
# where expected value d and standard deviation are unknown parameters
# The sd function in R computes the sample standard deviation:

sd(one_poll_per_pollster$spread)

# We are now ready to form a new confidence interval based on our 
# new data-driven model:  

results <- one_poll_per_pollster %>%
  summarise(avg = mean(spread), 
            se = sd(spread) / sqrt(length(spread))) %>%
  mutate(start=avg-1.96*se, end=avg+1.96*se)

round(results*100,1)

# Our confidence interval is wider now since it incorporates the pollster 
# variability. It does include the election night result of 2.1%. Also, note 
# that it was small enough not to include 0, which means we were confident 
# Clinton would win the popular vote.
