library(tidyverse)

permutations(8,3)
?str
str(permutations(8,3))

str(permutations(3,3))

medals <- c("gold","bronze","silver")
runners <- c(1,8)
sample(medals,runners)

runners <- c("Jamaica", "Jamaica", "Jamaica", "USA", "Ecuador", "Netherlands", "France", "South Africa")
set.seed(1)

B <- 10000
results <- replicate(B, {
  winners <- sample(runners, 3)
  (winners[1] %in% "Jamaica" & winners[2] %in% "Jamaica" & winners[3] %in% "Jamaica")
})
mean(results)
combinations(6,3)

6*3*20

f <- function(entree){
  print(3*15*entree)
}

# Use sapply to apply the function to entree option counts ranging from 1 to 12.
# What is the minimum number of entree options required in order to generate more
#  than 365 combinations?
options <- seq(1:12)
sapply(options, f)


ff <- function(sides){
  3*6*nrow(combinations(sides,2))
}
options <- 2:12
sapply(options, ff)


esoph

head(esoph)
nrow(esoph)


esoph %>% 
  filter(alcgp=="120+") %>%
  summarise(sum_cases=sum(ncases),tot=sum(ncontrols)+sum(ncases),probability=sum_cases/tot)

esoph %>%
  filter(alcgp=="0-39g/day") %>%
  summarise(sum_cases=sum(ncases), tot=sum(ncases)+sum(ncontrols), probability=sum_cases/tot)

esoph$tobgp

Tenorless <- "0-9g/day"

totalcases <- esoph %>% summarize(tot_cases = sum(ncases))
cases_tenorless <- esoph %>% filter(tobgp != "0-9g/day") %>%
  summarize(smoking10_cases = sum(ncases))

cases_tenorless/totalcases


totalcontrol <- esoph %>% summarise(totalcontrol=sum(ncontrols))
control_ten <- esoph %>% 
  filter(tobgp != "0-9g/day") %>%
  summarise(control_ten=sum(ncontrols))

control_ten / totalcontrol

esoph %>%
  group_by(alcgp) %>%
  select(alcgp,ncases,ncontrols) %>%
  data.frame()

totalcases <- esoph %>%
  summarise(sum(ncases))

cases_top_alcohol <- esoph %>%
  filter(alcgp=="120+") %>%
  summarise(sum(ncases))

p_cases_top_alcohol <- cases_top_alcohol/totalcases


cases_top_tobacco <- esoph %>%
  filter(tobgp=="30+") %>%
  summarise(sum(ncases))

cases_top_tobacco/totalcases

cases_top_both <- esoph %>%
  filter(tobgp=="30+" & alcgp=="120+") %>%
  summarise(sum(ncases))

cases_top_either <- esoph %>%
  filter(tobgp=="30+" | alcgp=="120+") %>%
  summarise(sum(ncases))
p_cases_top_either <- cases_top_either/totalcases

control_top_alcohol <- esoph %>%
  filter(alcgp=="120+") %>%
  summarise(sum(ncontrols))

p_control_top_alcohol <- control_top_alcohol/totalcontrol

p_cases_top_alcohol/p_control_top_alcohol

control_top_tobacco <- esoph %>%
  filter(tobgp=="30+") %>%
  summarise(sum(ncontrols))

p_control_top_tobacco <- control_top_tobacco/totalcontrol
p_control_top_tobacco

control_top_both <- esoph %>%
  filter(tobgp=="30+" & alcgp=="120+") %>%
  summarise(sum(ncontrols))

p_control_top_both <- control_top_both/totalcontrol
p_control_top_both

control_top_either <- esoph %>%
  filter(tobgp=="30+" | alcgp=="120+") %>%
  summarise(sum(ncontrols))

p_control_top_either <- control_top_either/totalcontrol
p_control_top_either


p_cases_top_either/p_control_top_either
