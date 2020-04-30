library(dslabs)
library(tidyverse)
library(ggrepel)
library(ggthemes)
data(murders)

murders <- murders %>%
  mutate(rate=total/population*100000)

us_murder_rate <- murders %>%
  summarise(rate=sum(total)/sum(population)*100000)

US_Graph <- murders %>%
  ggplot(aes(state,rate,label=abb,color=region)) +
  geom_point(size=2) +
  geom_label_repel(size=2) +
  xlab("State") +
  ylab("Murder rate") +
  ggtitle("South States") +
  theme(axis.text.x=element_text(angle=90,hjust=1)) +
  scale_y_log10() +
  geom_hline(yintercept = us_murder_rate$rate,lty=1,alpha=0.4,show.legend = TRUE) +
  scale_color_discrete(name="Region")

US_Graph
