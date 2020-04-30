library(dslabs)
data("murders")


# The plot function can be used to make scatterplots. Here is a plot of total murders versus population.

x <- murders$population / 10^6
y <- murders$total
plot(x, y)


# hist

x <- with(murders, total/population*10^5)
hist(x)

# boxplot
boxplot(rate~region, data = murders)


# The image function displays the values in a matrix using color. Here is a quick example:
  
x <- matrix(1:120, 12, 10)
image(x)

