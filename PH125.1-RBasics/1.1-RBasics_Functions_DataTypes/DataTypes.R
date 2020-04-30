library(dslabs)
data("murders")

# function class help us determine what type we have
a <- 3
class(a)

# data frames are the most common way to store data, conceptually similar to tables
data("murders")
class(murders)

# to know more about the structure of an object
str(murders)

# to inspect the first 6 rows we can use the function head
head(murders)

# we can use the accessor to access variables within a data frame
murders$population

# we can quickly access the variable names with names()
names(murders)
