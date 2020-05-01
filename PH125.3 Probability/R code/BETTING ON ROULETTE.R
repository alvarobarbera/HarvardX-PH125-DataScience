library(dslabs)
library(tidyverse)
library(ggplot2)

p_win <- 5/38
p_lose <- 1 - p_win
a <- 6
b <- -1

EX <- a*p_win+b*p_lose
EX

SEX <- abs(a-b)*sqrt(p_win*p_lose)
SEX

SEX/sqrt(500)

EX500 <- 500*EX

SEX500 <- SEX*sqrt(500)

pnorm(0, EX500, SEX500)
