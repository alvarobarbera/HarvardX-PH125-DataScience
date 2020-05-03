library(tidyverse)

dat <- read_csv("http://mlr.cs.umass.edu/ml/machine-learning-databases/breast-cancer-wisconsin/wdbc.data", col_names = FALSE)

head(dat)
nrow(dat)
ncol(dat)


