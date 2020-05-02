x_hat <- 0.48
N <- 25


se <- sqrt(x_hat*(1-x_hat)/N)
se

pnorm(0.01/se) - pnorm(-0.01/se)

pnorm(1.96)-pnorm(-1.96)

margin_error <- 1.96 * se
margin_error
