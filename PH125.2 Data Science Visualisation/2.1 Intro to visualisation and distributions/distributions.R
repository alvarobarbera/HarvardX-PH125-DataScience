library(dslabs)
data("heights")

table(heights$sex)

prop.table(table(heights$sex))

# cdf for the dataset of heights:
  
a <- seq(min(heights$height), max(heights$height), length = 100)    

cdf_function <- function (x) {    
  mean(heights$height <= x)
}
cdf_values <- sapply(a, cdf_function)
plot(a, cdf_values, type="l")


# calculating mean and sd in heights
average <- mean(heights$height)
SD <- sd(heights$height)
avg
sd

#standard units function


z <- function(x) {
  (x-average)/SD
}

#standard units for the smallest height in the dataset

z(min(x))

z(max(x))

z(average)

# You can compute the proportion of observations that are within 2 standard 
# deviations of the mean like this:

x <- heights$height
z <- scale(x)
mean(abs(z) < 2)


library(tidyverse)
library(dslabs)
data(heights)


x <- heights %>% filter(sex=="Male") %>% pull(height)


# We can estimate the probability that a male is taller than 70.5 inches with:

1 - pnorm(70.5, mean(x), sd(x))

# plot distribution of exact heights in data

plot(prop.table(table(x)), xlab = "a = Height in inches", ylab = "Pr(x = a)")

# Load the height data set and create a vector x with just the male heights:

library(dslabs)
data(heights)
x <- heights$height[heights$sex == "Male"]


# What proportion of the data is between 69 and 72 inches (taller than 69 but shorter or equal to 72)? A proportion is between 0 and 1.

mean(x>69&x<=72)

# Suppose you only have avg and stdev below, but no access to x, can you approximate the proportion of the data that is between 69 and 72 inches?

pnorm(72,avg,stdev)-pnorm(69,avg,stdev)

# not accurate when going to extreme, e.g. estimating proportion of heights between 79 and 81

x <- heights$height[heights$sex == "Male"]
exact <- mean(x > 79 & x <= 81)
avg <- mean(x)
sd <- sd(x)
approx <- pnorm(81,avg,sd)-pnorm(79,avg,sd)

exact/approx
