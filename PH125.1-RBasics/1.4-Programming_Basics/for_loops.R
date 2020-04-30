# creating a function that computes the sum of integers 1 through n
# 1 + 2 + 3 + … + n


sum_formula <- function(n) {
  x <- 1:n
  sum(x)
  }

sum_formula(100)


# a very simple for-loop
for(i in 1:5){
  print(i)
}

# we can use a for loop to create a vector that contains the sum_formula for 
# the the numbers 1 to 25

m <- 25

#then we create an empty vector where values will be stored

s_n <- vector(length=m)

#then we run the formula for m values

for (n in 1:m) {
  s_n[n] <- sum_formula(n)
}


# creating a plot for our summation function
n <- 1:m
plot(n, s_n)

# a table of values comparing our function to the summation formula
head(data.frame(s_n = s_n, formula = n*(n+1)/2))



# overlaying our function with the summation formula
plot(n, s_n)
lines(n, n*(n+1)/2)
