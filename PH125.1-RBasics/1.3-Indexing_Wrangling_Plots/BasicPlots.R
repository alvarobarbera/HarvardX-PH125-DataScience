library(dslabs)
data("murders")


# The plot function can be used to make scatterplots. Here is a plot of total murders versus population.

x <- murders$population / 10^6
y <- murders$total
plot(x, y)
