install.packages("titanic")
options(digits = 3)    # report 3 significant digits
library(tidyverse)
library(titanic)

titanic <- titanic_train %>%
  select(Survived, Pclass, Sex, Age, SibSp, Parch, Fare) %>%
  mutate(Survived = factor(Survived),
         Pclass = factor(Pclass),
         Sex = factor(Sex))


# density

titanic %>% 
  ggplot(aes(x=Age,fill=Sex)) +
  geom_density(alpha=0.6)

# density facet

titanic %>% 
  ggplot(aes(x=Age,fill=Sex)) +
  geom_density(alpha=0.6) +
  facet_grid(Sex~.)

# count

titanic %>% 
  ggplot(aes(x=Age,y=..count..,fill=Sex)) +
  geom_density(alpha=0.6)

# density facet

titanic %>% 
  ggplot(aes(x=Age,y=..count..,fill=Sex)) +
  geom_density(alpha=0.6) +
  facet_grid(Sex~.)

#proportion of 18-35 male higher than women

titanic %>% 
  ggplot(aes(x=Age,fill=Sex)) +
  geom_density(alpha=0.6) +
  geom_vline(xintercept = 18) +
  geom_vline(xintercept = 35)


#proportion of < 17 male higher than women

titanic %>% 
  ggplot(aes(x=Age,fill=Sex)) +
  geom_density(alpha=0.6) +
  geom_vline(xintercept = 17)


# QUESTION 3 QQ plot age distribution

params <- titanic %>%
  filter(!is.na(Age)) %>%
  summarize(mean = mean(Age), sd = sd(Age))

titanic %>%
  ggplot(aes(sample = Age)) +
  geom_qq(dparams = params) +
  geom_abline()

# QUESTION 4 survival by sex

titanic %>%
  ggplot(aes(Survived,y=..count..,fill=Sex)) +
  geom_bar(position = position_dodge())

# QUESTION 5 survival by age

titanic %>%
  ggplot(aes(x=Age,y=..count..,fill=Survived)) +
  geom_density(alpha=0.4)


# QUESTION 6 survival by fare 
#Filter the data to remove individuals who paid a fare of 0. 
#Make a boxplot of fare grouped by survival status. 
#Try a log2 transformation of fares. 
#Add the data points with jitter and alpha blending.

names(titanic)

titanic %>%
  filter(!Fare==0) %>%
  group_by(Survived) %>%
  ggplot(aes(Survived,Fare,color=Survived)) +
  geom_boxplot() +
  scale_y_continuous(trans = "log2") +
  geom_jitter(alpha=0.2,width = 0.1)


# QUESTION 7 survival by passenger class

titanic %>%
  ggplot(aes(Pclass,y=..count..,fill=Survived)) +
  geom_bar()

titanic %>%
  ggplot(aes(Pclass,y=..count..,fill=Survived)) +
  geom_bar(position = position_fill())

titanic %>%
  ggplot(aes(Survived,y=..count..,fill=Pclass)) +
  geom_bar(position = position_fill())


# QUESTION 7 survival by age, sex and passenger class
# Create a grid of density plots for age, filled by survival status, 
# with count on the y-axis, faceted by sex and passenger class.

titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(Age,y=..count..,fill=Survived)) +
  geom_density(alpha=0.5) +
  facet_grid(Sex~Pclass)

titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(Age,y=..count..,fill=Pclass)) +
  geom_density(alpha=0.5) +
  facet_grid(.~Pclass)


titanic %>%
  filter(!is.na(Age)) %>%
  ggplot(aes(Age,y=..count..,fill=Sex)) +
  geom_density(alpha=0.5) +
  facet_grid(Sex~Pclass)
