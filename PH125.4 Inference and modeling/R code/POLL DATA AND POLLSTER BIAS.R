data("polls_us_election_2016")

# Filter out US, data after 31 Oct and upper grades or no grade

polls <- polls_us_election_2016 %>% 
  filter(state == "U.S." & enddate >= "2016-10-31" &
           (grade %in% c("A+","A","A-","B+") | is.na(grade)))

# include a column for spread

polls <- polls %>%
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)


# we call p for Clinton and (1-p) for Trump
# we are interested in the difference d = 2p - 1
# there are 49 estimates of the spread
# we know they follow approx. a normal function with
# expected value d and standard error 2*sqrt(p*(1-p)/N)

d_hat <- polls %>%
  summarise(d_hat = sum(spread*samplesize)/sum(samplesize)) %>%
  pull(d_hat)


# to calculate the standard error, we know that p_hat is (d+1)/2
# and N is polls$samplesize

p_hat <- (d_hat+1)/2

moe <- 1.96 * 2 * sqrt(p_hat*(1-p_hat)/sum(polls$samplesize))


# We report an expected spread (difference) of d_hat ~ 1.42%
# and standard error moe ~ 0.66%

d_hat
moe

# So we report a spread of 1.43% with a margin of error of 0.66%. 
# On election night, we discover that the actual percentage was 2.1%, 
# which is outside a 95% confidence interval. What happened?
  
# A histogram of the reported spreads shows a problem:

polls %>% 
  ggplot(aes(spread)) + geom_histogram(binwidth = .01,col="black")


# The distribution does not appear to be normal, and the standard error 
# is larger than 0.0066


################################# POLLSTER BIAS #######################################

# Note that various pollster are involved are some are taking several polls a week

polls %>% group_by(pollster) %>% summarise(n())

polls %>% group_by(pollster) %>% 
  filter(n()>=6) %>%
  ggplot(aes(spread,pollster)) + geom_point()



