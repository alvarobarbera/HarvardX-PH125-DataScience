N <- 1000
B <- 10000
set.seed(1)

inside <- replicate(B,{
  x <- sample(c(0,1),size = N, replace = TRUE, prob=c(1-p,p))
  x_hat <- mean(x)
  se_hat <- sqrt(x_hat*(1-x_hat)/N)
  between(p, x_hat-1.96*se_hat, x_hat+1.96*se_hat)
})

# function between assess if p (1st argument) falls between the 2 next arguments
# in this case is p falling between +- 1.96 * se?

mean(inside)

# mean(inside) ~ 0.9482

