
# example of defining a function to compute the average of a vector 

avg <- function(x){	  #define avg as a function
  s <- sum(x)		      # s is the sum of all values
  n <- length(x)		  # n is the length
  s/n				          # last line is what it will return
}

# the function mean already exists
mean(x)
