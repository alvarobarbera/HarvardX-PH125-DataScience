library(dslabs)
library(ggplot2)
library(gridExtra)

N <- 25

p <- seq(0, 1, length.out = 100)

se <- sqrt(p*(1-p)/N)

plot(p, se)



p <- seq(0, 1, length.out = 100)

sample_sizes <- c(10, 100, 1000)

for (N in sample_sizes) { 
    se <- sqrt(p * (1-p) / N) 
    plot(p, se, ylim=c(0,max(se)))
  }
