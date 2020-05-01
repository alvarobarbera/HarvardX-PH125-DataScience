library(gtools)
library(dslabs)
library(tidyverse)

# birthdays can be represented as a number from 1 to 365 (we exclude 29th Feb)

n <- 50
sample(1:365,n,replace=TRUE)

# Montecarlo

B <- 10000

same_birthday <- function (n) {
  bdays <- sample(1:365,n,replace=TRUE)
  any(duplicated(bdays))
}

results <- replicate(B, same_birthday(50))

mean(results)




compute_prob <- function(n, B=10000){
  results <- replicate(B, same_birthday(n))
  mean(results)
}

# Using the function sapply, we can perform element-wise 
# operations on any function:
  
n <- seq(1,60)
prob <- sapply(n, compute_prob)

# We can now make a plot of the estimated probabilities of two people 
# having the same birthday in a group of size n:
  
library(tidyverse)
prob <- sapply(n, compute_prob)
qplot(n, prob)


exact_prob <- function(n){
  prob_unique <- seq(365,365-n+1)/365 
  1 - prod( prob_unique)
}
eprob <- sapply(n, exact_prob)
qplot(n, prob) + geom_line(aes(n, eprob), col = "red")
