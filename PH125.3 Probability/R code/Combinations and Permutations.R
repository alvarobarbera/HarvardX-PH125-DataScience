install.packages("gtools")
library(gtools)
library(dslabs)
library(tidyverse)

# 5 random phone numbers of 7 digits

all_phone_numbers <- permutations(10, 7, v = 0:9)
n <- nrow(all_phone_numbers)
index <- sample(n, 5)
all_phone_numbers[index,]


# Building a card deck

suits <- c("Diamonds", "Clubs", "Hearts", "Spades")
numbers <- c("Ace", "Deuce", "Three", "Four", "Five", "Six", "Seven", 
             "Eight", "Nine", "Ten", "Jack", "Queen", "King")
deck <- expand.grid(number = numbers, suit = suits)
deck <- paste(deck$number, deck$suit)



#probability of kings in deck

kings <- paste("King", suits)
kings

mean(deck %in% kings)

# To compute all possible ways we can choose two cards when 
# the order matters, we type:
  
hands <- permutations(52, 2, v = deck)

# This is a matrix with two columns and 2652 rows. 
# With a matrix we can get the first and second cards like this:

first_card <- hands[,1]
second_card <- hands[,2]

# Now the cases for which the first hand was a King can 
# be computed like this

kings <- paste("King", suits)
sum(first_card %in% kings)

#> [1] 204


# Probability of getting a King in the first AND second card

sum(first_card %in% kings & second_card %in% kings) / sum(first_card %in% kings)

# it is the same as

mean(first_card %in% kings & second_card %in% kings) / mean(first_card %in% kings)


# Probability of a natural 21 (facecard and ace)

# the 4 aces:
aces <- paste("Ace", suits)

# Facecards:
facecard <- c("King", "Queen", "Jack", "Ten")
facecard <- expand.grid(number = facecard, suit = suits)
facecard <- paste(facecard$number, facecard$suit)

# all possible hands

hands <- combinations(52, 2, v=deck) 

# probability of a natural 21 given that the ace is 
# listed first in `combinations`

mean(hands[,1] %in% aces & hands[,2] %in% facecard)

# probability of a natural 21 checking for both ace first and ace second

mean((hands[,1] %in% aces & hands[,2] %in% facecard)|(hands[,2] %in% aces & hands[,1] %in% facecard))

