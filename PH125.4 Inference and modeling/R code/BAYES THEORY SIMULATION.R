library(tidyverse)

# STATEMENT: the probability of having the disease given a positive test is only 0.02

# The following simulation is meant to help you visualize Bayes theorem. 
# We start by randomly selecting 100,000 people from a population in which the 
# disease in question has a 1 in 4,000 prevalence.

prev <- 0.00025
N <- 100000

set.seed(1)

outcome <- sample(c("Disease","Healthy"),size = N, replace = TRUE, prob=c(prev, 1-prev))

N_D <- sum(outcome=="Disease")
N_D
N_H <- sum(outcome=="Healthy")
N_H

# We have built a random population of 100000 that are either healthy or have the disease
# Now we create a vector with random test results

accuracy <- 0.99

# Character vector of length N

test <- vector("character", N)

# For each category of D/H, we asssign a test result of accuracy 99% defined above

test[outcome=="Disease"] <- sample(c("+","-"),size=N_D,replace=TRUE,prob=c(accuracy,1-accuracy))
test[outcome=="Healthy"] <- sample(c("-","+"),size=N_H,replace=TRUE,prob=c(accuracy,1-accuracy))

table(outcome,test)

# because we have so many more control (healthy) than cases, even with a low error test
# we get more controls than cases in the group that tested positive

19/(19+956)

# We can run this over and over again to see that the probability converges to 0.02
