#Use the unique and length functions to determine how many unique heights were reported

library(dslabs)
data(heights)
x <- heights$height
length(unique(x))

# There are 139 different measurements of height in the heights dataset

# Use the table function to compute the frequencies of each unique height value. 
# Because we are using the resulting frequency table in a later exercise we want 
# you to save the results into an object and call it tab.

x <- heights$height
tab <- table(x)

# To see why treating the reported heights as an ordinal value is not useful in 
# practice we note how many values are reported only once.

sum(tab==1)
