library(dslabs)
library(tidyverse)
library(gtools)

set.seed(16, sample.kind = "Rounding")

#ACT scores, random normal distribution 
# mean of 20.9
# standard deviation of 5.7
# generate 10000 scores in act_scores

act_scores <- rnorm(10000, 20.9, 5.7)

avg_act <- mean(act_scores)
sd_act <- sd(act_scores)

1-pnorm(30, avg_act, sd_act)

pnorm(10, avg_act, sd_act)

x <- seq(1, 36, 1)

f_x <- dnorm(x, 20.9, 5.7)

plot(x,f_x)

(mean(act_scores>=36))*10000

z_act_scores <- scale(act_scores)
mean(z>=2)

avg_act+(2*sd_act)

qnorm(0.975, avg_act, sd_act)



act_cdf <- sapply(1:36, function (x){
  mean(act_scores <= x)
})
min(which(act_cdf >= .95))

plot(act_cdf)

qnorm(.95, 20.9, 5.7)

p <- seq(0.01, 0.99, 0.01)
sample_quantiles <- quantile(act_scores, p)

sample_quantiles

theoretical_percentiles <- qnorm(p, avg_act, sd_act)

qqplot(theoretical_percentiles, sample_quantiles)



names(sample_quantiles)
names(sample_quantiles[max(which(sample_quantiles < 26))])
