library(tidyverse) 
library(dslabs)
path <- system.file("extdata", package="dslabs")
filename <- file.path(path, "fertility-two-countries-example.csv")
wide_data <- read_csv(filename)
wide_data

# gather

# converting wide into tidy
new_tidy_data <- wide_data %>% gather(year, fertility, '1960':'2015')
new_tidy_data

# note year is stored as character, to convert it

new_tidy_data <- wide_data %>% gather(year, fertility, '1960':'2015', convert=TRUE)

# or

new_tidy_data <- new_tidy_data %>% mutate(year=as.numeric(year))
class(new_tidy_data$year)

# now we can plot

new_tidy_data %>% ggplot(aes(year, fertility, color=country)) + geom_point()

