library(dslabs)
library(tidyverse)
library(ggrepel)
library(ggthemes)
data(heights)

params <- heights %>% filter(sex=="Male") %>%
  summarize(mean = mean(height), sd = sd(height))

heights %>% filter(sex=="Male") %>%
  ggplot(aes(sample = height)) +
  geom_qq(dparams = params) +
  geom_abline()

  
