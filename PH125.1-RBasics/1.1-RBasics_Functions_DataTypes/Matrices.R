# we can define matrices in R

mat <- matrix(1:12,4,3)
mat

# to access specific entries in a matrix
mat[2,3]

# if you want the entire second row
mat[2,]

# similar procedure if we want entire first column
mat[,1]

# to access a subset of the matrix
mat[3:4,2:3]

# We can convert matrices into data frames using the function as.data.frame
as.data.frame(mat)

# we can also use brackets to access subsets of data frames
data("murders")
murders[25,1]

# using murders[1:6,] would be the same as using head()
murders[1:6,]
