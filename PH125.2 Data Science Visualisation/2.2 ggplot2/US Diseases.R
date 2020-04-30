library(dslabs)
library(ggplot2)
library(tidyverse)
library(ggrepel)
library(dplyr)
library(RColorBrewer)

data("us_contagious_diseases")

str(us_contagious_diseases)


the_disease <- "Measles"

dat <- us_contagious_diseases %>%
  filter(!state%in%c("Hawaii","Alaska") & disease == the_disease) %>%
  mutate(rate = count / population * 10000 * 52 / weeks_reporting) %>% 
  mutate(state = reorder(state, rate)) 


dat %>% filter(state == "California" & !is.na(rate)) %>%
  ggplot(aes(year, rate)) +
  geom_line() + 
  ylab("Cases per 10,000")  + 
  geom_vline(xintercept=1963, col = "blue")

dat %>% ggplot(aes(year, state, fill = rate)) +
  geom_tile(color = "grey50") +
  scale_x_continuous(expand=c(0,0)) +
  scale_fill_gradientn(colors = brewer.pal(9, "YlOrRd"), trans = "sqrt") +
  geom_vline(xintercept=1963, col = "blue") +
  theme_minimal() +  
  theme(panel.grid = element_blank(), 
        legend.position="bottom", 
        text = element_text(size = 8)) +
  ggtitle(the_disease) + 
  ylab("") + xlab("")

display.brewer.all(type="seq")


avg <- us_contagious_diseases %>%
  filter(disease==the_disease) %>%
  group_by(year) %>%
  summarise(us_rate=sum(count,na.rm=TRUE)/sum(population,na.rm=TRUE)*10000)


dat %>% 
  filter(!is.na(rate)) %>%
  ggplot() +
  geom_line(aes(year,rate,group=state),color="grey50",size=1,alpha=0.1,show.legend = FALSE) +
  scale_y_continuous(trans="sqrt",breaks=c(0,5, 25,125,300)) +
  geom_line(mapping = aes(year, us_rate),  data = avg, size = 1) +
  ggtitle("Cases per 10,000 by state") + 
  xlab("") + ylab("") +
  geom_text(data=data.frame(x=1955,y=60),mapping=aes(x,y,label="US average rate")) +
  geom_vline(xintercept = 1963,color="blue")


