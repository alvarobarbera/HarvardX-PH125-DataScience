# `region` is a factor in the murders dataset. 
class(murders$region)


# Factors store categorical data, in this case there are 4 levels
levels(murders$region)

# we can use the function reorder to change order, e.g. by total murders

region <- murders$region
value <- murders$total
region <- reorder(region, value, FUN = sum)
levels(region)

