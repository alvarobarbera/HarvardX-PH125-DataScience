take_sample <- function(p,N) {
  x <- sample(c(0,1),size=N,replace=TRUE,prob=c(1-p,p))
  mean(x)
}

take_sample(0.45,10000000)

p <- 0.45
N <- 100

take_sample(p,N)


# DISTRIBUTION OF ERRORS

B <- 10000
set.seed(1)
errors <- replicate(B,{
  x <- sample(c(0,1),size=N,replace=TRUE,prob=c(1-p,p))
  mean(x)
  error <- p - mean(x)
})

# it's the same as

errors <- replicate(B,p-take_sample(p,N))

mean(errors)

hist(errors)

# AVERAGE SIZE OF ERRORS

mean(abs(errors))

# Calculate the standard deviation of `errors`

sqrt(mean(errors^2))

# CALCULATING THE STANDARD ERROR OF THE ESTIMATE SEXest

# Define `p` as a proportion of Democratic voters to simulate
p <- 0.45

# Define `N` as the sample size
N <- 100

# Use the `set.seed` function to make sure your answer matches the expected result after random sampling
set.seed(1)

# Define `X` as a random sample of `N` voters with a probability of picking a Democrat ('1') equal to `p`
X <- sample(c(0,1),size=N,replace=TRUE,prob=c(1-p,p))

# Define `X_bar` as the average sampled proportion
X_bar <- mean(X)

# Calculate the standard error of the estimate. Print the result to the console.
sqrt(X_bar*(1-X_bar)/N)



# PLOTTING THE STANDARD ERROR

N <- seq(100, 5000, len = 100)
p <- 0.5
se <- sqrt(p*(1-p)/N)

plot(N,se)

# PLOTTING THE ERRORS

p <- 0.45
N <- 100
B <- 10000
set.seed(1)

errors <- replicate(B, p - take_sample(p, N))

qqnorm(errors)
qqline(errors)


# Calculate the probability that the estimated proportion of Democrats 
# in the population is greater than 0.5. 

p <- 0.45
N <- 100

1 - pnorm(0.5,p,sqrt(p*(1-p)/N))


# Estimating probability of error size
# Probability of error being greater than 0.01


N <-100
X_hat <- 0.51

# Define `se_hat` as the standard error of the sample average
se_hat <- sqrt(X_hat*(1-X_hat)/N)

# Calculate the probability that the error is 0.01 or larger
# probability that is lower than -0.01 and higher than +0.01
pnorm(-0.01,0,se_hat) + 1 - pnorm(0.01,0,se_hat)
