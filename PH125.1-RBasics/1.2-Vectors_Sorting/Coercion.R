# flexibility of R with data types
mix <- c(3, "Canada", TRUE)
mix
class(mix)

#  we can convert between data types
numbers <- c(1,3)
str(numbers)
numchar <- as.character(numbers)
str(numchar)

# R can return NAs

string <- c("1", "Canada", "45")
as.numeric(string)
