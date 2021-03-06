# Define `Pr_1` as the probability of the first son dying of SIDS
Pr_1 <- 1/8500

# Define `Pr_2` as the probability of the second son dying of SIDS
Pr_2 <- 1/100

# Define `Pr_B` as the probability of both sons dying of SIDS
Pr_B <- Pr_1*Pr_2

# Define Pr_A as the rate of mothers that are murderers
Pr_A <- 1/1000000

# Define Pr_BA as the probability that two children die without evidence of harm, 
# given that their mother is a murderer
Pr_BA <- 0.50

# Define Pr_AB as the probability that a mother is a murderer, given that her two 
# children died with no evidence of physical harm. Print this value to the console.
Pr_AB <- (Pr_BA*Pr_A)/Pr_B
Pr_AB


# Load the libraries and poll data
library(dplyr)
library(dslabs)
data(polls_us_election_2016)

# Create an object `polls` that contains the spread of predictions for each candidate 
# in Florida during the last polling days

head(polls_us_election_2016)

polls <- polls_us_election_2016 %>%
  filter(state=="Florida" & enddate >= "2016-11-04") %>%
  mutate(spread=rawpoll_clinton/100 - rawpoll_trump/100)

# Examine the `polls` object using the `head` function
head(polls)

# Create an object called `results` that has two columns containing the average spread 
# (`avg`) and the standard error (`se`). Print the results to the console.

results <- polls %>%
  summarise(avg=mean(spread), se=sd(spread)/sqrt(n()))
results


# Define `mu` and `tau`
mu <- 0
tau <- 0.01

# Define a variable called `sigma` that contains the standard error in the object `results`
sigma <- results$se

# Define a variable called `Y` that contains the average in the object `results`
Y <- results$avg

# Define a variable `B` using `sigma` and `tau`. Print this value to the console.
B <- (sigma^2)/(sigma^2 + tau^2)

# Calculate the expected value of the posterior distribution

mu + (1-B)*Y

# Here are the variables we have defined
mu <- 0
tau <- 0.01
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)

# Compute the standard error of the posterior distribution. 
# Print this value to the console.

sqrt(1/((1/sigma^2)+(1/tau^2)))

# Construct the 95% credible interval. Save the lower and then the upper 
# confidence interval to a variable called `ci`.

mu <- 0
tau <- 0.01
sigma <- results$se
Y <- results$avg
B <- sigma^2 / (sigma^2 + tau^2)
se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))


est <- B * mu +(1-B)*Y
est
ci <- c(est-qnorm(.975)*se,est+qnorm(.975)*se)
ci


# Assign the expected value of the posterior distribution to the variable `exp_value`
exp_value <- B*mu + (1-B)*Y 

# Assign the standard error of the posterior distribution to the variable `se`
se <- sqrt( 1/ (1/sigma^2 + 1/tau^2))

# Using the `pnorm` function, calculate the probability that the actual spread was 
# less than 0 (in Trump's favor). Print this value to the console.

pnorm(0, exp_value,se)


# We had set the prior variance τ to 0.01, reflecting that these races are often close.
# Change the prior variance to include values ranging from 0.005 to 0.05 and observe 
# how the probability of Trump winning Florida changes by making a plot.

# Define the variables from previous exercises
mu <- 0
sigma <- results$se
Y <- results$avg

# Define a variable `taus` as different values of tau
taus <- seq(0.005, 0.05, len = 100)

# Create a function called `p_calc` that generates `B` and calculates the probability 
# of the spread being less than 0

p_calc <- function(tau) {
  B <- sigma^2/(sigma^2+tau^2)
  exp_value <- B * mu + (1-B) * Y
  se <- sqrt(1/(1/sigma^2+1/tau^2))
  pnorm(0, exp_value, se)
}

ps <- p_calc(taus)

plot(taus,ps)
