# The 'errors' data have already been loaded. Examine them using the `head` function.
head(errors)


# Generate an object called 'totals' that contains the numbers of good and bad 
# predictions for polls rated A- and C-

totals <- errors %>%
  filter(grade %in% c("A-","C-")) %>%
  group_by(grade, hit) %>%
  summarise(num=n()) %>%
  spread(grade,num)


# Print the proportion of hits for grade A- polls to the console
totals[2,3]/sum(totals[3])

# Print the proportion of hits for grade C- polls to the console
totals[2,2]/sum(totals[2])

# Perform a chi-squared test on the hit data. Save the results as an object called 'chisq_test'.
chisq_test <- totals %>% 
  select(-hit) %>%
  chisq.test()
chisq_test


# Generate a variable called `odds_C` that contains the odds of getting the 
# prediction right for grade C- polls


odds_C <- (totals[[2,2]] / sum(totals[[2]])) / 
  (totals[[1,2]] / sum(totals[[2]]))


# Generate a variable called `odds_A` that contains the odds of getting the 
# prediction right for grade A- polls

odds_A <- (totals[[2,3]] / sum(totals[[3]])) / 
  (totals[[1,3]] / sum(totals[[3]]))


# Calculate the odds ratio to determine how many times larger the odds 
# ratio is for grade A- polls than grade C- polls

odds_A/odds_C


