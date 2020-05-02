library(tidyverse)

N <- 1000
B <- 10000
set.seed(1)


x_hat <- replicate(B,{
  x <- sample(c(0,1),size = N, replace = TRUE, prob = c(1-p,p))
  mean(x)
})


#with p 0.45

p <- 0.45

x_hat <- replicate(B,{
  x <- sample(c(0,1),size = N, replace = TRUE, prob = c(1-p,p))
  mean(x)
})

# according to CLT X=0.45 and SE= sqrt(p*(1-p)/N)
# we check values in Monte Carlo

mean(x_hat)
sd(x_hat)

sd(x_hat) - sqrt(p*(1-p)/N)

x_hat_df <- data.frame(x=x_hat)

# Histogram and QQ plot

p1 <- data.frame(x_hat = x_hat) %>%
  ggplot(aes(x_hat)) +
  geom_histogram(binwidth = 0.005, color = "black")
p2 <- data.frame(x_hat = x_hat) %>%
  ggplot(aes(sample = x_hat)) +
  stat_qq(dparams = list(mean = mean(x_hat), sd = sd(x_hat))) +
  geom_abline() +
  ylab("X_hat") +
  xlab("Theoretical normal")
grid.arrange(p1, p2, nrow=1)

1.96*sqrt(0.45*(1-0.45)/25)

(2*0.48)-1


