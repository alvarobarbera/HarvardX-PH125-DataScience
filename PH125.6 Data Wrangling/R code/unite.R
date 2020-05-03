
path <- system.file("extdata", package = "dslabs")

filename <- "life-expectancy-and-fertility-two-countries-example.csv"
filename <-  file.path(path, filename)

raw_dat <- read_csv(filename)

dat %>% 
  separate(key, var_names, fill = "right") %>%
  # we can unite the columns like this
  unite(variable_name,first_variable_name,second_variable_name) %>%
  spread(variable_name,value) %>%
  rename(fertility=fertility_NA)
