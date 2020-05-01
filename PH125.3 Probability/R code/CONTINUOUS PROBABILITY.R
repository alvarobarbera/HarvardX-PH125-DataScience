library(tidyverse)
library(dslabs)
data("heights")

x <- heights %>% filter(sex=="Male") %>% .$height
Fp <- function(a) mean(x<=a)

1 - Fp(70)

plot(dnorm(x))
