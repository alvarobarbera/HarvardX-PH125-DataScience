# conditional expressions
a <- 0

if(a!=0){
  print(1/a)
} else{
  print("No reciprocal for 0.")
}

# ifelse
a <- c(0, 1, 2, -4, 5)
result <- ifelse(a > 0, 1/a, NA)
result


# example of a function to replace missing spaces in vector (NAs) with ceros
data(na_example)
sum(is.na(na_example))
no_nas <- ifelse(is.na(na_example), 0, na_example) 
sum(is.na(no_nas))

# the any() and all() functions evaluate logical vectors
# any() will return TRUE if any of the conditions is met
# all() will return TRUE if all conditions are met

z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)
