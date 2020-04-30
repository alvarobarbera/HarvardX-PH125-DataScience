#quantiles


# Percentiles are the quantiles that divide a dataset into 100 intervals each 
# with 1% probability. You can determine all percentiles of a dataset data like this:
  
# p <- seq(0.01, 0.99, 0.01)
# quantile(data=heights, p)

# The summary() function returns the minimum, quartiles and maximum of a vector.
summary(heights$height)


# Find the percentiles of heights$height:

p <- seq(0.01, 0.99, 0.01)
percentiles <- quantile(heights$height, p)

# Confirm that the 25th and 75th percentiles match the 1st and 3rd quartiles. 
# Note that quantile() returns a named vector. You can access the 25th and 75th 
# percentiles like this (adapt the code for other percentile values):
  
percentiles[names(percentiles) == "25%"]
percentiles[names(percentiles) == "75%"]

quantile(heights$height,0.999)
max(heights$height)

# qnorm function
qnorm(0.025)

# pnorm function
pnorm(-1.96)

# qnorm() and pnorm() are inverse functions:
pnorm(qnorm(0.025))  =0.025

# theoretical quantiles
p <- seq(0.01, 0.99, 0.01)
theoretical_quantiles <- qnorm(p, 69, 3)
head(theoretical_quantiles)

## qq plots

index <- heights$sex=="Male"
x <- heights$height[index]
z <- scale(x)

# proportion of data below 69.5
mean(x <= 69.5)

# calculate observed and theoretical quantiles
p <- seq(0.05, 0.95, 0.05)
observed_quantiles <- quantile(x, p)

observed_quantiles

theoretical_quantiles <- qnorm(p, mean = mean(x), sd = sd(x))

theoretical_quantiles

# QQ-plot
plot(theoretical_quantiles, observed_quantiles)
abline(0,1)

