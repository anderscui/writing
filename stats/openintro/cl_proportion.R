p_hat <- 571 / 670
z_star <- qnorm(0.975)
se <- sqrt(p_hat * (1 - p_hat) / 670)

ci <- p_hat + c(-1, 1) * z_star * se

margin_error <- 2 * se # 2.7% = z_star * se

# we want to have smaller me:
# use this one: 
n <- (z_star * 100) ^ 2 * p_hat * (1 - p_hat)

# largest estimation
n <- (z_star * 100) ^ 2 * p_hat * (1 - p_hat)

n <- 39.2 ^ 2