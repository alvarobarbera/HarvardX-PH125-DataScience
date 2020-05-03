path <- system.file("extdata", package = "dslabs")

filename <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <-  file.path(path, filename)

raw_dat <- read_csv(filename)
select(raw_dat, 1:5)

# we gather all columns into one, call it key

dat <- raw_dat %>% gather(key, value,-country)
dat

# separate the column key so we have year and variable in 2 columns

new_dat <- dat %>% separate(key,c("year", "variable_name"),"_",extra="merge")
new_dat


# now we want to spread variable_name into 2 separate columns for fertility
# and life expectancy, and fill it with the value

new_dat %>% spread(variable_name,value)


