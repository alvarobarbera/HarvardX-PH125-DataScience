library(dslabs)
library(tidyverse)
data("murders")

murder_rate = murders$total/murders$population*10^5

# if we wanted to know states with rate lower or equal to 0.71
ind <- murder_rate <= 0.71

murders$state[ind]


# In order to count how many are TRUE, the function sum returns the sum 
# of the entries of a vector and logical vectors get coerced to numeric 
# with TRUE coded as 1 and FALSE as 0. Thus we can count the states using:

sum(ind)


# logical operators

# creating the two logical vectors representing our conditions

west <- murders$region == "West"
safe <- murder_rate <= 1


# defining an index and identifying states with both conditions true
index <- safe & west

murders$state[index]


# which, to look up California's murder rate

index <- which(murders$state=="California")
murder_rate[index]

# match, find out the murder rates for several states

ind <- match(c("New York", "Florida", "Texas"), murders$state)
murder_rate[ind]


# check if a vector is within another vector with %in%

c("Boston", "Dakota", "Washington") %in% murders$state
