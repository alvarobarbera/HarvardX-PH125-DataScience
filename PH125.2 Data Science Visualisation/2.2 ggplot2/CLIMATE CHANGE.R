library(tidyverse)
library(dslabs)
data(temp_carbon)
data(greenhouse_gases)
data(historic_co2)



temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  pull(year) %>%
  max()


temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  .$year %>%
  max()

temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  select(year) %>%
  max()

# First year with carbon emissions available

temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  select(year) %>% min()


# Last year with carbon emissions available

temp_carbon %>%
  filter(!is.na(carbon_emissions)) %>%
  select(year) %>% max()

temp_carbon$carbon_emissions[temp_carbon$year==2014]/temp_carbon$carbon_emissions[temp_carbon$year==1751]

# First and last year with temp anomaly

temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  .$year %>% min()

temp_carbon %>%
  filter(!is.na(temp_anomaly)) %>%
  .$year %>% max()

min <- temp_carbon$temp_anomaly[temp_carbon$year==1880]
max <- temp_carbon$temp_anomaly[temp_carbon$year==2018]


# 20th century mean temperature

TA20 <- temp_carbon %>%
  filter(!is.na(temp_anomaly) & year %in% c(1901:2000))

colMeans(TA20)

# temperature with blue line for mean 20th century

p <- TA20 %>%
  ggplot(aes(year,temp_anomaly)) +
  geom_line()


p <- p + geom_hline(aes(yintercept = 0), col = "blue")
p


TA20 %>%
  ggplot(aes(year,temp_anomaly)) +
  geom_line() +
  geom_hline(yintercept = 0, col="blue") +
  ylab("Temperature anomaly (degrees C)") +
  ggtitle("Temperature anomaly relative to 20th century mean, 1880-2018") +
  geom_text(aes(x = 2000, y = 0.05, label = "20th century mean"), col = "blue") +
  geom_vline(aes(xintercept=1939),col="red") +
  geom_vline(aes(xintercept=1976),col="orange") +
  geom_text(aes(x=1936,y=0.05,label="1939"),col="red") +
  geom_text(aes(x=1978,y=0.05,label="1976"),col="orange")
  

TA20 %>%
  filter(temp_anomaly>0) %>%
  .$year %>% min()


TA20 %>%
  filter(temp_anomaly<0) %>%
  .$year %>% max()

TA20 %>%
  filter(temp_anomaly>0.5) %>%
  .$year %>% min()

#adding land and ocean

temp_carbon %>%
  filter(year %in% c(1880:2020)) %>%
  ggplot() +
  geom_line(aes(year,temp_anomaly)) +
  geom_line(aes(year,ocean_anomaly),col="blue") +
  geom_line(aes(year,land_anomaly), col="brown") +
  geom_hline(yintercept = 0, col="black",alpha=0.5) +
  geom_vline(xintercept = 2018, col="black",alpha=0.5)

names(greenhouse_gases)
head(greenhouse_gases)

greenhouse_gases %>%
  ggplot(aes(year,concentration)) +
  geom_line() +
  facet_grid(gas~., scales = "free") +
  geom_vline(xintercept = 1850) +
  ylab("Concentration (ch4/n2o ppb, co2 ppm)") +
  ggtitle("Atmospheric greenhouse gas concentration by year, 0-2000")


temp_carbon %>%
  ggplot(aes(year,carbon_emissions)) +
  geom_line()

#year, co2, source

co2_time <- historic_co2 %>%
  ggplot(aes(year,co2,color=source)) +
  geom_line()

co2_time_recent <- historic_co2 %>%
  filter(year>1500) %>%
  ggplot(aes(year,co2,color=source)) +
  geom_line()
co2_time
co2_time_recent

grid.arrange(co2_time,co2_time_recent)

historic_co2 %>%
  ggplot(aes(year,co2,color=source)) +
  geom_line() +
  xlim(-800000,-775000)

historic_co2 %>%
  ggplot(aes(year,co2,color=source)) +
  geom_line() +
  xlim(-375000,-330000)

historic_co2 %>%
  ggplot(aes(year,co2,color=source)) +
  geom_line() +
  xlim(-140000,-120000)

historic_co2 %>%
  ggplot(aes(year,co2,color=source)) +
  geom_line() +
  xlim(1700,2018)
