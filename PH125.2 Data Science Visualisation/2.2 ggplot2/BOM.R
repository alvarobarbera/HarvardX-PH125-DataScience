library(bomrang)
library(ggrepel)



get_current_weather("Manly") %>%
  filter(local_date_time_full>"2020-04-17 23:30:00") %>%
  ggplot(aes(local_date_time_full,wind_spd_kt,gust_kt,label=wind_dir)) +
  geom_line(aes(local_date_time_full,wind_spd_kt),color="blue",size=1.5) +
  geom_line(aes(local_date_time_full,gust_kt),color="blue",lty=2) +
  geom_label(size=3,nudge_y = -0.9) +
  ggtitle("Manly Wind") +
  xlab("") +
  ylab("Wind (knots)")


