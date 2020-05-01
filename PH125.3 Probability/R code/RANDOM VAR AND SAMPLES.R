library(tidyverse)
library(dslabs)
library(ggplot2)

beads <- rep( c("red", "blue"), times = c(2,3))
X <- ifelse(sample(beads, 1) == "blue", 1, 0)

# casino roulette betting on color only

color <- rep(c("Black","Red","Green"), c(18, 18, 2))

#If red comes up gambler wins and the casino loses $1

n <- 1000

X <- sample(ifelse(color=="Red",-1,1),n,replace=TRUE)

# Because we know the proportions of 1 and -1  we could also code it as:

X <- sample(c(-1,1), n, replace = TRUE, prob=c(9/19, 10/19))

# winnings for the casino:

sum(X)

# Value of X changes as it is a random variable
# So how can we calculate the probability of losing/winning?

n <- 1000
B <- 10000

roulette_winnings <- function(n) {
  X <- sample(c(-1,1),n,replace=TRUE,prob=c(9/19,10/19))
  sum(X)
}

S <- replicate(B,roulette_winnings(n)) 

# Probability of losing money

mean(S<0)

hist(S,breaks = 25)

s <- seq(min(S), max(S), length = 100)    # sequence of 100 values across range of S
normal_density <- data.frame(s = s, f = dnorm(s, mean(S), sd(S))) # generate normal density for S
data.frame (S = S) %>%    # make data frame of S for histogram
  ggplot(aes(S, ..density..)) +
  geom_histogram(color = "black", binwidth = 10) +
  ylab("Probability") +
  geom_line(data = normal_density, mapping = aes(s, f), color = "blue")


# Using the CLT, we can skip the Monte Carlo simulation and instead 
# compute the probability of the casino losing money using this approximation:

mu <- n * (20-18)/38
se <-  sqrt(n) * 2 * sqrt(90)/19 
pnorm(0, mu, se)

