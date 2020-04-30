library(dslabs)
library(tidyverse)
library(ggrepel)
library(ggthemes)
data(heights)

p <- heights %>% filter(sex=="Male") %>% ggplot(aes(x=height))
p + geom_histogram(binwidth = 1,fill="blue",color="black") +
  xlab("Male height in inches") +
  ggtitle("Heights Histogram")


