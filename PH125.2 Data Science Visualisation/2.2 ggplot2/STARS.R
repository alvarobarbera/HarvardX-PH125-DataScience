library(tidyverse)
library(dslabs)

data(stars)
options(digits = 3)   # report 3 significant 

mean(stars$magnitude)
#4.26

sd(stars$magnitude)
#7.35

# distribution of magnitude
stars %>%
  ggplot(aes(magnitude,y=..count..)) +
  geom_density(fill="grey")

#distribution of temperature
stars %>%
  ggplot(aes(temp)) +
  geom_density(fill="grey")

# scatter plot of temperature (X) and magnitude (Y)

stars %>%
  ggplot(aes(temp,magnitude)) +
  geom_point()

# scatter plot of temperature (X) and magnitude (Y) with flipped axis

stars %>%
  ggplot(aes(temp,magnitude)) +
  geom_point() +
  scale_y_reverse() +
  scale_x_continuous(trans = "log10") +
  scale_x_reverse()



# The least lumninous star in the sample with a surface temperature over 5000K
stars %>%
  ggplot(aes(temp,magnitude,label=star)) +
  geom_point() +
  geom_text_repel() +
  scale_y_reverse() +
  scale_x_continuous(trans = "log10") 

# Color by star type

stars %>%
  ggplot(aes(temp,magnitude,color=type,label=type)) +
  geom_point() +
  geom_text_repel() +
  scale_y_reverse() +
  scale_x_continuous(trans = "log10") +
  scale_x_reverse()

# G type

stars %>%
  filter(type=="G") %>%
  ggplot(aes(temp,magnitude,color=type)) +
  geom_point() +
  scale_y_reverse() +
  scale_x_continuous(trans = "log10")


