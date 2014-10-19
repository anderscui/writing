outcomes <- c("heads", "tails")

sim_fair_coin <- sample(outcomes, size = 100, replace = T)
table(sim_fair_coin)

# unfair coin
sim_unfair_coin <- sample(outcomes, size = 100, replace = T, prob = c(0.2, 0.8))
table(sim_unfair_coin)