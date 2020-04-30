# We can create vectors using the function c, which stands for concatenate. 
# We use c to concatenate entries in the following way:
  
codes <- c(380, 124, 818)
codes
countries <- c("USA","Canada","Mexico")
countries

# naming vectors
country_codes <- c(USA=43, Canada=4, Mexico=33)
country_codes
class(country_codes)
names(country_codes)

# sequencies
ten_numbers <- seq(1,10)
ten_numbers

cerofive <- seq(-10,10,0.5)

1:10

# cerofive is of class numeric
class(cerofive)

# 1:10 integer
class(1:10)

# subsetting to access specific values of a vector
cerofive[3]

cerofive[c(3,4)]


