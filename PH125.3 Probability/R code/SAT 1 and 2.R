#Probability of guessing correctly 1 question

p_correct <- 0.2
p_not_correct <- 1-p_correct


#Guessin on one question, expected value
avg <- 1*p_correct+-0.25*p_not_correct

#standard error

sd <- sqrt(44)*abs(1--0.25)*sqrt(p_correct*p_not_correct)

1-pnorm(8,avg,sd)

# Monte Carlo for 10000 students

set.seed(21)
B <- 10000
n <- 44

exam_scores <- replicate(B,{
  X <- sample(c(1,-0.25),n,replace = TRUE,prob=c(p_correct,p_not_correct))
  sum(X)
})

mcavg <- mean(exam_scores)
mcsd <- sd(exam_scores)

1 - pnorm(8,mcavg,mcsd)


############ SAT 2

p_correct2 <- 0.25
p_not_correct2 <- 1 - p_correct2

EX2 <- 1*p_correct2+0*p_not_correct2

44*EX2

SEX2 <- sqrt(44)*abs(1-0)*sqrt(p_correct2*p_not_correct2)

1 - pnorm(35, EX2, SEX2)

p <- seq(0.25, 0.95, 0.05)

n <- 44
a <- 1
b <- 0
x <- 0.2

exp_val <- sapply(p, function(x){
  mu <- n * a*x + b*(1-x)
  sigma <- sqrt(n) * abs(b-a) * sqrt(x*(1-x))
  1-pnorm(35, mu, sigma)
})

min(p[which(exp_val > 0.8)])



