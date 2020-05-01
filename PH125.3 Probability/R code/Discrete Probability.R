beads <- rep (c("blue","red"), times= c(2,3))

#picking one at random
sample(beads,1)

# repeting substraction 10000 times

t <- 10000
subs <- replicate (t, sample(beads,1))

table(subs)

prop.table(table(subs))


balls <- rep (c("cyan","magenta","yellow"), times= c(3,5,7))

t <- 1000000

subs <- replicate(t,sample(balls,1))

prop.table(table(subs))

3/15

12/15

3/15 * 12/14

0.2 * 0.8
