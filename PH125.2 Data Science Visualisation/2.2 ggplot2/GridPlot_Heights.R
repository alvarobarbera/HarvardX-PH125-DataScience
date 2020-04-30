library(dslabs)
library(tidyverse)
library(ggrepel)
library(ggthemes)
data(heights)


p <- heights %>% filter(sex=="Male") %>% ggplot(aes(x=height))

p1 <- p + geom_histogram(binwidth = 1,fill="blue",col="black")
p2 <- p + geom_histogram(binwidth = 2,fill="blue",col="black")
p3 <- p + geom_histogram(binwidth = 3,fill="blue",col="black")

install.packages("gridExtra")
library(gridExtra)

grid.arrange(p1,p2,p3,ncol=3)

p4 <- p +geom_histogram(binwidth=0.5)
p4             

round(heights$height)
heights <- mutate(heights, height_rd=round(height))
heights

names(heights)

p <- heights %>% filter(sex=="Male") %>% ggplot(aes(x=height_rd))

p4 <- p + geom_histogram(binwidth = 1,fill="blue",col="white")
p5 <- p + geom_density(fill="blue",col="white")

grid.arrange(p4,p5,ncol=2)
