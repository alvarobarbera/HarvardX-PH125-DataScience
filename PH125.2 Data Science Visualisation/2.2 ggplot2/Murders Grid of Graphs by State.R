library(dslabs)
library(tidyverse)
library(ggrepel)
library(ggthemes)
data(murders)

murders <- murders %>%
  mutate(rate=total/population*10^6)

us_murder_rate <- murders %>%
  summarise(rate=sum(total)/sum(population)*100000)
us_murder_rate

murders$region

South_Graph <- murders %>%
  filter(region=="South") %>%
  ggplot(aes(population/100000,total,label=abb)) +
  geom_point(color="blue",size=3) +
  geom_label_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total murders (log scale)") +
  ggtitle("South States")
  
West_Graph <- murders %>%
  filter(region=="West") %>%
  ggplot(aes(population/100000,total,label=abb)) +
  geom_point(color="green",size=3) +
  geom_label_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total murders (log scale)") +
  ggtitle("West States")

NorthCentral_Graph <- murders %>%
  filter(region=="North Central") %>%
  ggplot(aes(population/100000,total,label=abb)) +
  geom_point(color="red",size=3) +
  geom_label_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total murders (log scale)") +
  ggtitle("North Central States")

Northeast_Graph <- murders %>%
  filter(region=="Northeast") %>%
  ggplot(aes(population/100000,total,label=abb)) +
  geom_point(color="orange",size=3) +
  geom_label_repel() +
  scale_x_log10() +
  scale_y_log10() +
  xlab("Population in millions (log scale)") +
  ylab("Total murders (log scale)") +
  ggtitle("Northeast States")

library(gridExtra)

grid.arrange(NorthCentral_Graph, Northeast_Graph, South_Graph, West_Graph, ncol = 2)

