# Load the 'dslabs' package and data contained in 'heights'
library(dslabs)
data(heights)

# Make a vector of heights from all males in the population
x <- heights %>% filter(sex == "Male") %>%
  .$height

# Calculate the population average. Print this value to the console.
μ <- mean(x)

# Calculate the population standard deviation. Print this value to the console.
sd(x)

# The vector of all male heights in our population `x` has already been loaded for you. You can examine the first six elements using `head`.
head(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `X` as a random sample from our population `x`
X <- sample(x,size=N,replace=TRUE)

# Calculate the sample average. Print this value to the console.
sample_average <- mean(X)
sample_average

# Calculate the sample standard deviation. Print this value to the console.
sample_deviation <- sd(X)
sample_deviation

# The sample average is a random variable with 
# expected value μ and standard error σ/sqrt(N)

# We will use X¯ as our estimate of the heights in the population from 
# our sample size N. We know from previous exercises that the standard 
# estimate of our error X¯−μ is σ/sqrt(N)

# Construct a 95% confidence interval for μ.

# Define `se` as the standard error of the estimate. 
# Print this value to the console.

se <- sample_deviation/sqrt(N)
se

# Construct a 95% confidence interval for the population average based on our sample. Save the lower and then the upper confidence interval to a variable called `ci`.

ci <- c(sample_average-qnorm(.975)*se, sample_average+qnorm(.975)*se)
ci


# Define `mu` as the population average
mu <- mean(x)

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `N` as the number of people measured
N <- 50

# Define `B` as the number of times to run the model
B <- 10000

# Define an object `res` that contains a logical vector for simulated 
# intervals that contain mu

res <- replicate(B,{
  X <- sample(x,size=N,replace=TRUE)
  X_hat = mean(X)
  se_hat = sd(X)
  se = se_hat/sqrt(N)
  interval <- c(X_hat-qnorm(.975)*se, X_hat+qnorm(.975)*se)
  between(mu,interval[1],interval[2])})


# Calculate the proportion of results in `res` that include mu. 
# Print this value to the console.

mean(res)


# Load the libraries and data you need for the following exercises
library(dslabs)
library(dplyr)
library(ggplot2)
data("polls_us_election_2016")

# These lines of code filter for the polls we want and calculate the spreads
polls <- polls_us_election_2016 %>% 
  filter(pollster %in% c("Rasmussen Reports/Pulse Opinion Research","The Times-Picayune/Lucid") &
           enddate >= "2016-10-15" &
           state == "U.S.") %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) 

# Make a boxplot with points of the spread for each pollster

polls %>% ggplot(aes(pollster, spread)) + geom_boxplot() + geom_point()


# We will model the observed data Yij in the following way:
# Yij = d + bi + εij
# with i=1,2 indexing the two pollsters, bi the bias for pollster i, and 
# εij poll to poll chance variability. We assume the ε are independent from
# each other, have expected value 0 and standard deviation σi regardless of j.



# Create an object called `sigma` that contains a column for `pollster` and 
# a column for `s`, the standard deviation of the spread

sigma <- polls %>% group_by(pollster) %>% summarize(s = sd(spread))

# Print the contents of sigma to the console

sigma


# Exercise 15 - Calculate the 95% Confidence Interval of the Spreads
# We have constructed a random variable that has expected value b2−b1, 
# the pollster bias difference. If our model holds, then this random variable 
# has an approximately normal distribution. The standard error of this random 
# variable depends on σ1 and σ2, but we can use the sample standard deviations 
# we computed earlier. We have everything we need to answer our initial question: 
# is b2−b1 different from 0?
  
# Construct a 95% confidence interval for the difference b2 and b1. Does this 
# interval contain zero?

# Create an object called `res` that summarizes the average, standard deviation, 
# and number of polls for the two pollsters.

res <- polls %>%
  group_by(pollster) %>% 
  summarise(avg=mean(spread), se=sd(spread), n=n())

res 


# Store the difference between the larger average and the smaller in a 
# variable called `estimate`. Print this value to the console.

estimate <- res$avg[2] - res$avg[1]
estimate

# Store the standard error of the estimates as a variable called `se_hat`. 
# Print this value to the console.

se_hat <- sqrt(res$se[2]^2/res$n[2] + res$se[1]^2/res$n[1])
se_hat


# Calculate the 95% confidence interval of the spreads. Save the lower and 
# then the upper confidence interval to a variable called `ci`.

ci <- c(estimate-qnorm(.975)*se_hat, estimate+qnorm(.975)*se_hat)
ci

# Calculate the p-value
2 * (1 - pnorm(estimate / se_hat, 0, 1))


# Execute the following lines of code to filter the polling data and calculate 
# the spread
polls <- polls_us_election_2016 %>% 
  filter(enddate >= "2016-10-15" &
           state == "U.S.") %>%
  group_by(pollster) %>%
  filter(n() >= 5) %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100) %>%
  ungroup()

# Create an object called `var` that contains columns for the pollster, 
# mean spread, and standard deviation. Print the contents of this object to 
# the console.

var <- polls %>% group_by(pollster) %>% summarise(avg=mean(spread),s=sd(spread))
var


