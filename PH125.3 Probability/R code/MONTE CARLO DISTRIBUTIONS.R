library(dslabs)
library(tidyverse)
data("heights")

x <- heights %>% filter(sex=="Male") %>% .$height

n <- length(x)
avg <- mean(x)
s <- sd(x)

simulated_heights <- rnorm(n,avg,s)

data.frame(simulated_heights = simulated_heights) %>%
  ggplot(aes(simulated_heights)) +
  geom_histogram(color="black", binwidth = 2)

B <- 10000

tallest <- replicate(B,{
  simulated_data <- rnorm(800,avg,s)
  max(simulated_data)
})

mean(tallest >= 7*12)
