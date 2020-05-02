library(dslabs)

N <- 25

p <- seq(0, 1, length.out = 100)

se <- sqrt(p*(1-p)/N)

plot(p, se)



