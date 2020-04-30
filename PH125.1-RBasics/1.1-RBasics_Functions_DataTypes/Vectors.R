library(dslabs)
data(murders)

# The object murders$population is not one number but several. 
# We call these types of objects vectors. A single number is technically a 
# vector of length 1, but in general we use the term vectors to refer to 
# objects with several entries. The function length tells you how many entries 
# are in the vector:

pop <- murders$population
length(pop)


# we can inspect vector class
class(pop)
class(murders$population)

# vectors of class character store character strings
class(murders$state)

# Logical vectors must be either true or false
a <- 3==2
