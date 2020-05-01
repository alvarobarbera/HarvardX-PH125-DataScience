n <- 1000
loss_per_foreclosure <- -200000
p <- 0.02 
defaults <- sample( c(0,1), n, prob=c(1-p, p), replace = TRUE)
sum(defaults * loss_per_foreclosure)

# The sum above is random
# Monte Carlo for distribution of losses

B <- 10000

losses <- replicate(B,{
  defaults <- sample(c(0,1),n,replace=TRUE,prob=c(1-p,p))
  sum(defaults*loss_per_foreclosure)
})

mean(losses)
sd(losses)


# With CLT

n*(p*loss_per_foreclosure+(1-p)*0)
sqrt(n)*abs(loss_per_foreclosure)*sqrt(p*(1-p))


# adding an amount to laons (that are re-paid) so that losses are CERO
# losses*p + x (1-p) = 0
# x (1-p) ; x is the amount added
# x = -losses / (1-p)

-loss_per_foreclosure*p/(1-p)/200000

qnorm(0.01)

# Quantity to make sure the bank losses money 1 in 100

l <- loss_per_foreclosure
z <- qnorm(0.01)
x <- -l*( n*p - z*sqrt(n*p*(1-p)))/ ( n*(1-p) + z*sqrt(n*p*(1-p)))

x/180000

#Interest rate is 0.035 or 3.5%

# Expected profit per loan

EP <- loss_per_foreclosure*p + x*(1-p)


# Total expected profit

TEP <- n*(l*p + x*(1-p))


# Monte Carlo for total expected profit

B <- 10000

profit <- replicate(B,{
  draws <- sample(c(x,l),n,replace = TRUE, prob=c(1-p,p))
  sum(draws)
})


# Employee suggests increasing n even if p doubles from 2% defaults to 4%

p <- 0.04

# new interest rate l*p + x*(1-p)=0
# x=l*p/(1-p)
# r = x / 180000

r <- -l*p/(1-p)/180000
r

# r is 0.04629
# If we set r to 5% the expected profit

r <- 0.05
x <- r*180000
NewEP <- l*p+(r*180000)*(1-p)
NewEP


# what n do we need for our probability of losing money of 1%

z <- qnorm(0.01)
n <- ceiling((z^2*(x-l)^2*p*(1-p))/(l*p + x*(1-p))^2)
n

# 22163 loans will reduce P of losing money to 1%, 
# and total expected profit would be 14,184,320

n*(l*p+x*(1-p))


# Now we don't wrongly assume that the probability of defaulting by borrowers
# is independent. We keep p of defaulting to 4% but now We will assume that
# with 50-50 chance, all the probabilities go up or down slightly to somewhere 
# between 0.03 and 0.05. But it happens to everybody at once, not just one person


p <- 0.04

x <- 0.05*180000

profit <- replicate(B, {
  new_p <- 0.04 + sample(seq(-0.01, 0.01, length = 100), 1)
  draws <- sample( c(x, loss_per_foreclosure), n, prob=c(1-new_p, new_p), replace = TRUE) 
  sum(draws)
})

mean(profit)

# continues to be very large, but now the probability to lose money is 34.6%

mean(profit<-10000000)




data.frame(profit_in_millions=profit/10^6) %>% 
  ggplot(aes(profit_in_millions)) + 
  geom_histogram(color="black", binwidth = 5)
