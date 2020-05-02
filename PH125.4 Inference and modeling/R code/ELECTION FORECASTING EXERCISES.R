# Load the libraries and data
library(dplyr)
library(dslabs)
library(ggplot2)
data("polls_us_election_2016")

# Create a table called `polls` that filters by  state, date, and reports the spread
polls <- polls_us_election_2016 %>% 
  filter(state != "U.S." & enddate >= "2016-10-31") %>% 
  mutate(spread = rawpoll_clinton/100 - rawpoll_trump/100)

# Create an object called `cis` that has the columns indicated in the instructions

cis <- polls %>%
  mutate(X_hat = (spread+1)/2,
         se = 2*sqrt(X_hat*(1-X_hat)/samplesize),
         lower = spread-qnorm(.975)*se,
         upper = spread+qnorm(.975)*se) %>%
  select(state, startdate, enddate, pollster, grade, spread, lower, upper)

# Add the actual results to the `cis` data set

add <- results_us_election_2016 %>%
  mutate(actual_spread = clinton/100 - trump/100) %>%
  select(state, actual_spread)

ci_data <- cis %>%
  mutate(state=as.character(state)) %>%
  left_join(add,by="state")


# Create an object called `p_hits` that summarizes the proportion of hits for 
# each pollster that has at least 5 polls.

p_hits <- ci_data %>%
  mutate(hit = lower <= actual_spread & upper >= actual_spread) %>%
  group_by(pollster) %>%
  filter(n()>=5) %>%
  summarise(proportion_hits=mean(hit),n=n(),grade=grade[1]) %>%
  arrange(desc(proportion_hits))

p_hits

# Stratify by State (same as before, by state)

p_hits <- ci_data %>%
  mutate(hit= lower<= actual_spread & upper >= actual_spread) %>%
  group_by(state) %>%
  filter(n()>5) %>%
  summarise(proportion_hits=mean(hit),n=n()) %>%
  arrange(desc(proportion_hits))

# barplot of p_hits

p_hits %>%
  mutate(state=reorder(state,proportion_hits)) %>%
  ggplot(aes(state,proportion_hits),coordflip) +
  geom_bar(stat="identity") + coord_flip()


# Create an object called `errors` that calculates the difference between the predicted 
# and actual spread and indicates if the correct winner was predicted

errors <- ci_data %>% 
  mutate(error=spread-actual_spread, hit= sign(spread) == sign(actual_spread))

# Examine the last 6 rows of `errors`
tail(errors)  


# Plotting prediction results

# Create an object called `errors` that calculates the difference between the predicted 
# and actual spread and indicates if the correct winner was predicted

errors <- ci_data %>% mutate(error = spread - actual_spread, hit = sign(spread) == sign(actual_spread))

# Create an object called `p_hits` that summarizes the proportion of hits for each 
# state that has 5 or more polls

p_hits <- errors %>%
  group_by(state) %>%
  filter(n()>5) %>%
  summarise(proportion_hits = mean(hit),n=n())


# Make a barplot of the proportion of hits for each state

p_hits %>%
  mutate(state=reorder(state,proportion_hits)) %>%
  ggplot(aes(state,proportion_hits)) +
  geom_bar(stat="identity") + coord_flip()


# PLOTTING THE ERRORS

# Generate a histogram of the error
hist(errors$error)

# Calculate the median of the errors. Print this value to the console.
median(errors$error)


errors %>%
  filter(grade %in% c("A+","A","A-","B+")) %>%
  mutate(state=reorder(state, error)) %>%
  ggplot(aes(state, error)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  geom_boxplot() + geom_point()

# Errors by state for states with 5 or more polls

errors %>%
  filter(grade %in% c("A+","A","A-","B+")) %>%
  group_by(state) %>%
  filter(n()>5) %>%
  ungroup() %>%
  mutate(reorder(state,error)) %>%
  ggplot(aes(state, error)) +
  geom_boxplot() + geom_point()


