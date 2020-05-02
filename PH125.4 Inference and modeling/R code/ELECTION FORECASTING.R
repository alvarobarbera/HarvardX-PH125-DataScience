library(tidyverse)
library(dslabs)

polls <- polls_us_election_2016 %>% 
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+","A","A-","B+") | is.na(grade))) %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)


one_poll_per_pollster <- polls %>% group_by(pollster) %>% 
  filter(enddate == max(enddate)) %>%
  ungroup()


results <- one_poll_per_pollster %>% 
  summarize(avg = mean(spread), se = sd(spread)/sqrt(length(spread))) %>% 
  mutate(start = avg - 1.96*se, end = avg + 1.96*se) 


mu <- 0
tau <- 0.035

Y <- results$avg
sigma <- results$se

B <- sigma^2/(sigma^2+tau^2)

posterior_mean <- mu*B+(1-B)*Y
posterior_se <- sqrt(1/(1/sigma^2+1/tau^2))

posterior_mean
posterior_se

# Interval of 95% confidence

ci <- posterior_mean + c(-1.96,+1.96)*posterior_se
ci  

# what's the probability that Clinton will win

1 - pnorm(0, posterior_mean, posterior_se)

# simulating J=6 polls

set.seed(3)
J <- 6
N <- 2000
d <- .021
p <- (d + 1)/2
X <- d + rnorm(J, 0, 2 * sqrt(p * (1 - p) / N))

# simulating 6 polls from I=5 different pollsters

I <- 5
J <- 6
N <- 2000
X <- sapply(1:I, function(i){
  d + rnorm(J, 0, 2 * sqrt(p * (1 - p) / N))
})

# we have generated a matrix of 5 pollsters with 6 polls each

# We need to introduce (h) pollster-to-pollster variability

I <- 5
J <- 6
N <- 2000
d <- .021
p <- (d + 1) / 2
h <- rnorm(I, 0, 0.025)
X <- sapply(1:I, function(i){
  d + h[i] + rnorm(J, 0, 2 * sqrt(p * (1 - p) / N))
})

# We still need to introduce general bias (b)
# One way to interpret b is as the difference between the average of all polls from 
# all pollsters and the actual result of the election. Because we don’t know the actual 
# result until after the election, we can’t estimate b until after the election. 
# However, we can estimate b from previous elections

# b is of expected value 0 and se 0.025


mu <- 0
tau <- 0.035
sigma <- sqrt(results$se^2 + .025^2)
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

posterior_mean <- B*mu + (1-B)*Y
posterior_se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))

1 - pnorm(0, posterior_mean, posterior_se)

# Now the probability of Clinton winning is a lot closer to what FiveThirtyEight predicted

# PREDICTING THE ELECTORAL COLLEGE

results_us_election_2016 %>% top_n(5, electoral_votes)

# We start by aggregating results from a poll taken during the last week before 
# the election. We use the str_detect, a function we introduce later in Section 24.1, 
# to remove polls that are not for entire states.

results <- polls_us_election_2016 %>%
  filter(state!="U.S." & 
           !str_detect(state, "CD") & 
           enddate >="2016-10-31" & 
           (grade %in% c("A+","A","A-","B+") | is.na(grade))) %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
  group_by(state) %>%
  summarize(avg = mean(spread), sd = sd(spread), n = n()) %>%
  mutate(state = as.character(state))

# The closest (lowest d) are:

results %>% arrange(abs(avg))

# we add electoral votes from the 2016 actuals data set

results <- left_join(results, results_us_election_2016, by = "state")

results


# Because we can’t estimate the standard deviation for states with just one poll, 
# we will estimate it as the median of the standard deviations estimated for 
# states with more than one poll:
  
results <- results %>%
  mutate(sd = ifelse(is.na(sd), median(results$sd, na.rm = TRUE), sd))

mu <- 0
tau <- 0.02
results %>% mutate(sigma = sd/sqrt(n),
                   B = sigma^2/ (sigma^2 + tau^2),
                   posterior_mean = B*mu + (1-B)*avg,
                   posterior_se = sqrt( 1 / (1/sigma^2 + 1/tau^2))) %>%
  arrange(abs(posterior_mean))


# MONTE CARLO SIMULATION 
# We account for 7 electoral votes in DC and RhodeIsland that are not in results 

B <- 10000
mu <- 0
tau <- 0.02

clinton_EV <- replicate(B, {
  results %>% 
    mutate(sigma = sd/sqrt(N),
           B = sigma^2/(sigma^2 + tau^2),
           posterior_mean = B*mu+(1-B)*avg,
           posterior_se = sqrt(1/((1/sigma^2)+(1/tau^2))),
           result=rnorm(length(posterior_mean), posterior_mean, posterior_se),
           clinton=ifelse(result>0, electoral_votes,0)) %>%
    summarise(clinton=sum(clinton)) %>%
    pull(clinton) + 7
})

mean(clinton_EV>269)



# The model above ignores the general bias and 
# assumes the results from different states are independent.

# We can simulate the results now with a bias term. For the state level, the general bias can 
# be larger so we set it at 0.03

tau <- 0.02
bias_sd <- 0.03
clinton_EV_2 <- replicate(1000, {
  results %>% mutate(sigma = sqrt(sd^2/n  + bias_sd^2),  #sigma with general bias 
                     B = sigma^2 / (sigma^2 + tau^2),
                     posterior_mean = B*mu + (1-B)*avg,
                     posterior_se = sqrt( 1/ (1/sigma^2 + 1/tau^2)),
                     result = rnorm(length(posterior_mean), 
                                    posterior_mean, posterior_se),
                     clinton = ifelse(result>0, electoral_votes, 0)) %>% 
    summarize(clinton = sum(clinton) + 7) %>% 
    pull(clinton)
})
mean(clinton_EV_2 > 269)

clinton_EV %>% ggplot(aes(result)) + geom_histogram()


## FORECASTING ##

# To make sure the variability we observe is not due to pollster effects, 
# let’s study data from one pollster

one_pollster <- polls_us_election_2016 %>%
  filter(pollster=="Ipsos" & state=="U.S.") %>%
  mutate(spread=rawpoll_clinton/100-rawpoll_trump/100)

se <- one_pollster %>% 
  summarize(empirical = sd(spread), 
            theoretical = 2 * sqrt(mean(spread) * (1 - mean(spread)) / min(samplesize)))
se

one_pollster %>% ggplot(aes(spread)) + geom_histogram(col="black")

polls_us_election_2016 %>%
  filter(state == "U.S." & enddate >= "2016-07-01") %>%
  group_by(pollster) %>%
  filter(n() >= 10) %>%
  ungroup() %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
  ggplot(aes(enddate, spread)) +
  geom_smooth(method = "loess", span = 0.1) +
  geom_point(aes(color = pollster), show.legend = FALSE, alpha = 0.6)

polls_us_election_2016 %>%
  filter(state == "U.S." & enddate >= "2016-07-01") %>%
  select(enddate, pollster, rawpoll_clinton, rawpoll_trump) %>%
  rename(Clinton = rawpoll_clinton, Trump = rawpoll_trump) %>%
  gather(candidate, percentage, -enddate, -pollster) %>%
  mutate(candidate = factor(candidate, levels = c("Trump", "Clinton"))) %>%
  group_by(pollster) %>%
  filter(n() >= 10) %>%
  ungroup() %>%
  ggplot(aes(enddate, percentage, color = candidate)) +
  geom_point(show.legend = FALSE, alpha = 0.4) +
  geom_smooth(method = "loess", span = 0.15) +
  scale_y_continuous(limits = c(30, 50))

