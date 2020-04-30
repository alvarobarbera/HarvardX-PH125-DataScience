# Say we want to rank the states from least to most gun murders. 
# The function sort sorts a vector in increasing order
library(dslabs)
data("murders")
sort(murders$total)

# order: It takes a vector as input and returns the vector of 
# indexes that sorts the input vector.

x <- c(31, 4, 15, 92, 65)
sort(x)


# with order
index <- order(x)
x[index]

# we can order the states names by total murders. According to R California had the most murders

index <- order(murders$total)
murders$abb[index]

# entry with the largest value
max(murders$total)

# which.max will return the index of the entry with largest value
which.max(murders$total)

#to return the state name
murders$state[which.max(murders$total)]

#or
maxmurder <- which.max(murders$total)
murders$state[maxmurder]

# rank, returns a vector with the rank of the first entry, second entry, etc
rank(x)
