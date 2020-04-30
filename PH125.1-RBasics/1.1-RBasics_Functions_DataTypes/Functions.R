log(8)
log(a)

# help function or ? for help files
help(log)
?log

# to know the arguments of a function without opening help docs
args(log)

# we can change the default values by assigning another object
log(8,base=2)

# if no argument name is included R will understand it in the same order as the args() specs
log(8,2)

# To solve another equation such as 3x^2 + 2x - 1 we can copy and paste the code above and then redefine the variables and recompute the solution:
a <- 3
b <- 2
c <- -1
(-b + sqrt(b^2 - 4*a*c)) / (2*a)
(-b - sqrt(b^2 - 4*a*c)) / (2*a)

