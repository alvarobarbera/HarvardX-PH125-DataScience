library(dslabs)
library(tidyverse)
library(ggrepel)
library(ggthemes)
data(heights)

p <- heights %>% filter(sex=="Male") %>% ggplot(aes(x=height))
p + geom_density(fill="blue") +
  xlab("Male height in inches") +
  ggtitle("Heights Density")
