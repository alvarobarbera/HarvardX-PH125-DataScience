library(tidyverse)
library(ggrepel)
library(ggthemes)
library(dslabs)
data(murders)

#define intercept

r <- murders %>% summarise(rate=sum(total)/sum(population)*10^6) %>% pull(rate)

#make the plot combining all elements

murders %>% ggplot(aes(population/10^6,total,label=abb)) +
  geom_point(aes(col=region),size=3) +
  scale_x_log10() +
  scale_y_log10() +
  xlab ("Population in millions (log scale)") +
  ylab ("Total number of murders (log scale)") +
  ggtitle("US Murders in 2010") +
  geom_abline(intercept=log10(r),lty=2,color="darkgrey") +
  scale_color_discrete(name="Region") +
  geom_text_repel() +
  theme_economist()
