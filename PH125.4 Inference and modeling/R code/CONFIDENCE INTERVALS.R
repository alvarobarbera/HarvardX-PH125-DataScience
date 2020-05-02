data("nhtemp")
data.frame(year = as.numeric(time(nhtemp)), temperature = as.numeric(nhtemp)) %>%
  ggplot(aes(year, temperature)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Average Yearly Temperatures in New Haven")



p <- 0.45
N <- 1000
set.seed(1)

x <- sample(c(0,1), size=N, replace=TRUE, prob=c(1-p,p))
x_hat <- mean(x)
se_hat <- sqrt(x_hat*(1-x_hat)/N)
serror <- 1.96*se_hat

# the interval would be

c(x_hat-serror,x_hat+serror)

# to determine the probability that the interval contains p 0.45

pnorm(1.96) - pnorm(-1.96)

#if we want a larger probability we need to multiply by whatever z satisfies
# the probability we are after

z <- qnorm(.995)
z

# z = 2.5758 ; using the resulting interval we would include p 
# with a 99.5% confidence

pnorm(z) - pnorm(-z)
