library(dslabs)
library(tidyverse)
library(ggplot2)

data(death_prob)
head(death_prob)

p_death <- death_prob %>% filter(age==50 & sex=="Female") %>% .$prob

loss <- -150000
premium <- 1150

EX <- p_death*loss+(1-p_death)*premium
SEX <- abs(loss-premium)*sqrt(p_death*(1-p_death))
SEX

n <- 1000

EX1000 <- n*EX
EX1000

SEX1000 <- sqrt(n)*abs(loss-premium)*sqrt(p_death*(1-p_death))
SEX1000

pnorm(0,EX1000,SEX1000)


# 50 year old males

p_death_male50 <- death_prob %>% filter(age==50 & sex=="Male") %>% .$prob
p_death_male50

# what premium to charge to make 700000 profit on 1000 policies

n <- 1000
loss <- -150000

# 700000 = n(loss*p_death_male50+premium*(1-p_death_male50))

premium <- 700-(loss*p_death_male50)/(1-p_death_male50)
premium


SEX1000male50 <- sqrt(n)*abs(loss-premium)*sqrt(p_death_male50*(1 - p_death_male50))
SEX1000male50

EX1000male50 <- n*(loss*p_death_male50+premium*(1-p_death_male50))
EX1000male50

pnorm(0, EX1000male50, SEX1000male50)


# probability of death changes due to a pandemic

new_p_death <- .015

new_loss <- -150000
new_premium <- 1150
new_n <- 1000

EX1000new <- new_n*(new_loss*new_p_death+new_premium*(1-new_p_death))
EX1000new

SEX1000new <- sqrt(n)*abs(new_loss-new_premium)*sqrt(new_p_death*(1-new_p_death))
SEX1000new

pnorm(0, EX1000new, SEX1000new)

pnorm(-1000000, EX1000new, SEX1000new)


p <- seq(.01, .03, .001)
x <- 0.015
a <- -150000
b <- 1150
n <- 1000

exp_loss <- sapply(p, function(x){
  mu <- n * a*x + b*(1-x)
  sigma <- sqrt(n) * abs(b-a) * sqrt(x*(1-x))
  pnorm(0, mu, sigma)
})

min(p[which(exp_loss > 0.9)])


p <- seq(.01, .03, .0025)

p_lose_million <- sapply(p, function(p){
  exp_val <- n*(a*p + b*(1-p))
  se <- sqrt(n) * abs(b-a) * sqrt(p*(1-p))
  pnorm(-1*10^6, exp_val, se)
})

data.frame(p, p_lose_million) %>%
  filter(p_lose_million > 0.9) %>%
  pull(p) %>%
  min()



# Sampling

p_loss = .015
n <- 1000
set.seed(25)

loans <- sample(c(-150000,1150), n, replace=TRUE, prob=c(p_loss,(1-p_loss)))

sum(loans)
sum(loans)/10^6


# Monte Carlo

p_loss = .015
n <- 1000

set.seed(27)
B <- 10000

profits <- replicate(B, {
  outcomes <- sample(c(-150000, 1150), n, prob = c(p_loss, 1-p_loss), replace = TRUE)
  sum(outcomes)/10^6
})

mean(profits < -1)


# Premium required to lose money with a 5% change, given p=0.015, l=-150000 and n=1000

p <- .015
l <- -150000
n <- 1000
z <- qnorm(0.05)

x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))
x

Ep <- (l*p+x*(1-p))
Ep

# Monte Carlo
set.seed(28)
B <- 10000
expected_profit <- replicate(B,{
  profits <- sample(c(l,x),n,replace=TRUE,prob=c(p,(1-p)))
  sum(profits)
})
mean(expected_profit<0)



# Unstable p_death

set.seed(29)
B <- 10000
l <- -150000
n <- 1000

newprofit <- replicate(10000, {
  new_p <- 0.015 + sample(seq(-0.01, 0.01, length = 100), 1)
  profits <- sample(c(-150000,x), n, prob=c(new_p, 1-new_p), replace = TRUE) 
  sum(profits)
})

mean(newprofit)

mean(newprofit < -1000000)
