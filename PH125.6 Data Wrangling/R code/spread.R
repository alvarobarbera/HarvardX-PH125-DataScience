# It's the inverse of `gather`. 
# The second argument tells spread which variable will be used as 
# the column names. The third argument specifies which variable to 
# use to fill out the cells:


# we previously had
new_tidy_data


# with spread
back_to_wide <- new_tidy_data %>% spread(year,fertility)
back_to_wide
